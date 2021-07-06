import 'package:flutter/material.dart';
import 'package:yasm_mobile/services/auth.service.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";

  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YASM!!🌟'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to YASM!!🌟'),
            TextButton(
              onPressed: _authService.getLoggedInUserDetails,
              child: Text('Test Node API'),
            ),
            TextButton(
              onPressed: _authService.logout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
