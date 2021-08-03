import 'package:flutter/material.dart';
import 'package:yasm_mobile/widgets/user/email_update_tab.widget.dart';
import 'package:yasm_mobile/widgets/user/password_update_tab.widget.dart';
import 'package:yasm_mobile/widgets/user/profile_update_tab.widget.dart';

class UserUpdate extends StatelessWidget {
  const UserUpdate({Key? key}) : super(key: key);

  static const routeName = "/user-update";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Your Profile'),
          bottom: TabBar(
            indicatorColor: Colors.pink,
            tabs: [
              Tab(
                child: Text('User Details'),
              ),
              Tab(
                child: Text('Email Details'),
              ),
              Tab(
                child: Text('Password'),
              ),
              Tab(
                child: Text('Delete Account'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProfileUpdateTab(),
            EmailUpdateTab(),
            PasswordUpdateTab(),
            Text('Delete Account'),
          ],
        ),
      ),
    );
  }
}
