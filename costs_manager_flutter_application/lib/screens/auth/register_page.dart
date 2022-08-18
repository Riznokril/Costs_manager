// ignore_for_file: prefer_const_constructors

import 'package:costs_manager_flutter_application/utils/general_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    if (passwordConfirm()) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  bool passwordConfirm() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'lib/assets/images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 24),

                  // Hello There!
                  Text(
                    "Hello There!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 56,
                    ),
                  ),
                  SizedBox(height: 12.0),

                  // Register below with your details!
                  Text(
                    "Register below with your details!",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),

                  // email TextField
                  GeneralTextField(
                    controller: _emailController,
                    hintText: "Email",
                    isPassword: false,
                  ),
                  SizedBox(height: 12.0),

                  // password TextField
                  GeneralTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    isPassword: true,
                  ),
                  SizedBox(height: 12.0),

                  // confirm password TextField
                  GeneralTextField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    isPassword: true,
                  ),
                  SizedBox(height: 12.0),

                  // sign in button
                  GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),

                  // I'm a member! register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I'm a member! "),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text("Login now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
