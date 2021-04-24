import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_papillio/screens/auth/auth.dart';
import 'package:project_papillio/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Auth();
    }
    else {
      return Home();
    }
  }
}
