import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/constants.dart';
import 'package:flutter_social_app/screens/password_reset.dart';
import 'package:flutter_social_app/utils/network_utils.dart';
import 'package:flutter_social_app/utils/user_account.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  final String emailFromRegister;

  LoginScreen({this.emailFromRegister});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.emailFromRegister);
  }

  void updateUI(String emailFromRegister) {
    setState(() {
      if (emailFromRegister == null) {
        return;
      }
      email = emailFromRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFormField(
                initialValue: email,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  email = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  password = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Log In',
                color: Colors.yellowAccent,
                onPressed: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    // final authResult = await _auth.signInWithEmailAndPassword(
                    // email: email, password: password);
                    // if (authResult.user != null) {
                    // Navigator.pushNamed(context, ChatScreen.id);
                    // }

                    try {
                      var responseData = await NetworkUtils.post('users/login/',
                          {'username': this.email, 'password': this.password});

                      print(responseData);

                      UserAccount.TOKEN = responseData['token'];

                      // TODO: get full user profile

                      Navigator.pushNamed(context, HomeScreen.id);
                    } catch (exception) {
                      print(exception);
                      Flushbar(
                        message: "Invalid login or password.",
                        margin: EdgeInsets.all(8.0),
                        borderRadius: 20.0,
                        backgroundColor: Colors.red,
                        icon: Icon(
                          Icons.remove_circle_outline,
                          size: 28.0,
                          color: Colors.white,
                        ),
                        duration: Duration(seconds: 3),
                      )..show(context);
                    }

                    setState(() {
                      _showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 58.0,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.red,
                  child: GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        print('cli');
                        Navigator.pushNamed(context, PasswordResetScreen.id);
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
