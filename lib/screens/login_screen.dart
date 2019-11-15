import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/screens/password_reset.dart';
import 'package:flutter_social_app/utils/constants.dart';
import 'package:flutter_social_app/utils/network_utils.dart';
import 'package:flutter_social_app/utils/constants_strings.dart' as STRINGS;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:developer' as dev;

import 'package:flutter_social_app/utils/logger.dart';
import 'home_screen.dart';
import 'package:flutter_social_app/utils/user_account.dart';
import 'package:flushbar/flushbar.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  final String emailFromRegister;

  LoginScreen({this.emailFromRegister});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _updateUI(widget.emailFromRegister);
  }

  void _updateUI(String emailFromRegister) {
    setState(() {
      if (emailFromRegister == null) {
        return;
      }
      _email = emailFromRegister;
    });
  }

  Future<void> _loginUser() async {
    setState(() {
      _showSpinner = true;
    });

    try {
      String token = await NetworkUtils.loginUser(_email, _password);

      print('login(): Got token: $token');
      log('login(): Got token: $token');
      dev.log('login(): Got token: $token', name: 'login');
      dev.log('login(): Got token: $token');
      UserAccount.TOKEN = token;

      // TODO: get full user profile

      Navigator.pushNamed(context, HomeScreen.id);
    } catch (exception) {
      print(exception);
      Flushbar(
        message: STRINGS.ERROR_INVALID_LOGIN_OR_PASSWORD,
        margin: EdgeInsets.all(8.0),
        borderRadius: 20.0,
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.remove_circle_outline,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 5),
      )..show(context);
    }

    setState(() {
      _showSpinner = false;
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
                  tag: kHeroTagLogo,
                  child: Container(
                    height: 200.0,
                    child: Image.asset(kImageMainLogo),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFormField(
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _email = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                  hintText: STRINGS.ENTER_EMAIL,
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
                  _password = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: STRINGS.ENTER_PASSWORD),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: STRINGS.LOG_IN,
                color: Colors.yellowAccent,
                onPressed: () async {
                  await _loginUser();
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
                        STRINGS.MSG_FORGOT_PASSWORD,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
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
