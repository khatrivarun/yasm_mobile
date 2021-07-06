import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yasm_mobile/constants/endpoint.constant.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:yasm_mobile/dto/auth/login_user/login_user.dto.dart';
import 'package:yasm_mobile/dto/auth/register_user/register_user.dto.dart';
import 'package:yasm_mobile/exceptions/auth/NotLoggedIn.exception.dart';
import 'package:yasm_mobile/exceptions/auth/UserAlreadyExists.exception.dart';
import 'package:yasm_mobile/exceptions/auth/UserNotFound.exception.dart';
import 'package:yasm_mobile/exceptions/auth/WrongPassword.exception.dart';

class AuthService {
  final firebaseAuth.FirebaseAuth _firebaseAuth =
      firebaseAuth.FirebaseAuth.instance;

  Future<void> getLoggedInUserDetails() async {
    if (_firebaseAuth.currentUser != null) {
      String firebaseAuthToken =
          await this._firebaseAuth.currentUser!.getIdToken();

      Uri url = Uri.parse("$endpoint/user/me");

      Map<String, String> headers = {
        "Authorization": "Bearer $firebaseAuthToken",
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode >= 400) {
        throw NotLoggedInException(
          message: "You are not logged in. Please log in and try again.",
        );
      }

      print(json.decode(response.body));
    }
  }

  Future<void> registerUser(RegisterUser registerUser) async {
    Uri url = Uri.parse("$endpoint/auth/register");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: json.encode(registerUser.toJson()),
    );

    Map<String, dynamic> body = json.decode(response.body);

    if (response.statusCode == 422) {
      throw UserAlreadyExistsException(message: body["message"]);
    }
  }

  Future<void> login(LoginUser loginUser) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: loginUser.email,
        password: loginUser.password,
      );
    } on firebaseAuth.FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw UserNotFoundException(
          message: 'No user found for that email.',
        );
      } else if (error.code == 'wrong-password') {
        throw WrongPasswordException(
          message: 'Wrong password provided for the specified user account.',
        );
      }
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
