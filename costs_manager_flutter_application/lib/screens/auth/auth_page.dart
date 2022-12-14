import 'package:costs_manager_flutter_application/screens/auth/login_page.dart';
import 'package:costs_manager_flutter_application/screens/auth/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially, show the login page
  bool showLoginPage = false;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return RegisterPage(showLoginPage: toggleScreens);
    } else {
      return LoginPage(showRegisterPage: toggleScreens);
    }
  }
}
