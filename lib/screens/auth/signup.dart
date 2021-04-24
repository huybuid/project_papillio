import 'package:flutter/material.dart';
import 'package:project_papillio/components/already_have_an_account_acheck.dart';
import 'package:project_papillio/components/rounded_button.dart';
import 'package:project_papillio/components/rounded_input_field.dart';
import 'package:project_papillio/components/rounded_password_field.dart';
import 'package:project_papillio/screens/shared/loading.dart';
import 'package:project_papillio/services/auth_services.dart';

import '../../theme.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  const SignUp({Key key, @required this.toggleView}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '', password = '';
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    Size size = MediaQuery.of(context).size;
    bool loading = false;

    return (loading) ? Loading(backgroundColor: materialColor[50], spinColor: materialColor[500]) : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.25),
              Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    child: new Image.asset(
                      'assets/icons/papilio.png',
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
              SizedBox(height: 5.0),
              Text('SIGN UP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RoundedInputField(
                  hintText: "Email",
                  size: MediaQuery.of(context).size.width * 0.8,
                  color: materialColor[500],
                  boxColor: materialColor[150],
                  icon: Icon(Icons.person_rounded, color: materialColor[500]),
                  onChanged: (text) {
                    setState(() => email = text);
                  }),
              RoundedPasswordField(
                obscureText: isObscure,
                hintText: "Password",
                size: MediaQuery.of(context).size.width * 0.8,
                onChanged: (text) {
                  setState(() => password = text);
                },
                color: materialColor[500],
                boxColor: materialColor[150],
                onIconPressed: (password == '') ? null : () {
                  setState(() => isObscure = !isObscure);
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: materialColor[500],
                textColor: materialColor[50],
                size: size.width*0.8,
                onPress: () async {
                  setState(() => loading = true);
                  print(email);
                  print(password);
                  dynamic result = await _auth.SignUpWithEmail(email, password);
                  if (result != null)
                    print("Signed up successfully!");
                  else {
                    setState(() {
                      loading = false;
                    });
                  }
                },
              ),
              Expanded(child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 30.0),
                child: AlreadyHaveAnAccountCheck(
                  login: false,
                  onPress: () {
                    widget.toggleView();
                  },
                ),
              ))
            ],
          ),
        )
      )
    );
  }
}
