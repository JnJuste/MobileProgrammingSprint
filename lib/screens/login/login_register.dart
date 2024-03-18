import 'package:flutter/material.dart';
import 'package:navigation_bar/screens/login/login_page.dart';
import 'package:navigation_bar/screens/login/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginPage = true;

  //Toggle between login and register Page
  void togglesPages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglesPages,
      );
    } else {
      return RegisterPage(
        onTap: togglesPages,
      );
    }
  }
}
