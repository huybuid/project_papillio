import 'package:flutter/material.dart';
import 'package:project_papillio/screens/auth/signup.dart';
import 'package:project_papillio/screens/auth/login.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? Login(toggleView: toggleView,)
        : SignUp(toggleView: toggleView,);
  }
}
