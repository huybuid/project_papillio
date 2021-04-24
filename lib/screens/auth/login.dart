import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_papillio/components/already_have_an_account_acheck.dart';
import 'package:project_papillio/components/rounded_button.dart';
import 'package:project_papillio/components/rounded_input_field.dart';
import 'package:project_papillio/components/rounded_password_field.dart';
import 'package:project_papillio/screens/shared/loading.dart';
import 'package:project_papillio/services/auth_services.dart';
import 'package:project_papillio/theme.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({Key key, @required this.toggleView}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '', password = '';
  String message = '';
  bool isObscure = true, isError = false;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    Size size = MediaQuery.of(context).size;

    return (loading) ? Loading(backgroundColor: materialColor[50], spinColor: materialColor[500]) : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Form(
            key: _formKey,
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
                Text('LOGIN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RoundedInputField(
                  validator: (String val) => val.contains(new RegExp(r'\S+@\S+\.\S')) ? null : 'Enter a valid email',
                  hintText: "Email",
                  size: MediaQuery.of(context).size.width * 0.8,
                  color: materialColor[500],
                  boxColor: materialColor[150],
                  icon: Icon(Icons.person_rounded, color: materialColor[500]),
                  onChanged: (text) {
                    setState(() => email = text);
                  },
                ),
                RoundedPasswordField(
                  hintText: "Password",
                  size: MediaQuery.of(context).size.width * 0.8,
                  obscureText: isObscure,
                  onChanged: (text) {
                    setState(() => password = text);
                  },
                  color: materialColor[500],
                  boxColor: materialColor[150],
                  onIconPressed: (password.isEmpty) ? null : () {
                    setState(() => isObscure = !isObscure);
                  },
                ),
                RoundedButton(
                  text: "LOG IN",
                  color: materialColor[500],
                  size: size.width*0.8,
                  textColor: materialColor[50],
                  onPress: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result =
                      await _auth.SignInWithEmail(email, password);
                      if (result != null) {
                        setState(() {
                          message = result;
                          loading = false;
                          isError = true;
                        });
                      }
                    }
                  },
                ),
                TextButton(
                  child: Text('Forgot password?', style: TextStyle(color: Colors.grey)),
                  onPressed: () async {
                    await _auth.SendPasswordReset(email);
                    setState(() {
                      message = 'Password reset form sent. Please check your email';
                      isError = false;
                    });
                  },
                ),
                Text(message, style: TextStyle( color: (isError) ? Colors.red : Colors.amber ),),
                Expanded(child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: AlreadyHaveAnAccountCheck(
                    login: true,
                    onPress: () {
                      widget.toggleView();
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
      )
    );
  }
}
