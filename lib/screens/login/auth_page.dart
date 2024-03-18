import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/bottomTabBar/fab_tabs_bar.dart';
import 'package:navigation_bar/screens/login/login_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //User Logged In
          if (snapshot.hasData) {
            return FabBar(selectedIndex: 0);
          }
          //User Not Logged In
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
