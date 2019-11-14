import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/input_validation_text.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/constants.dart';
import 'package:flutter_social_app/screens/login_screen.dart';
import 'package:flutter_social_app/utils/network_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String username;
  String password1;
  String password2;
  bool _showSpinner = false;

  Map errorTextFieldsMap = {
    'email': '',
    'username': '',
    'password': '',
  };

  void _resetErrorMap() {
    errorTextFieldsMap = {
      'email': '',
      'username': '',
      'password': '',
    };
  }

  void _showFlashBar(context, String _email) {
    Flushbar(
      margin: EdgeInsets.all(8.0),
      borderRadius: 30.0,
      backgroundColor: Colors.green,
      message: 'Account created for: $_email',
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      mainButton: FlatButton(
        onPressed: () {
          // Navigator.pushNamed(context, LoginScreen.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(
                emailFromRegister: _email,
              ),
            ),
          );
        },
        child: Text(
          "Sign In",
          style: TextStyle(color: Colors.white),
        ),
      ),
    )..show(context);
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
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  email = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              InputValidationText(
                msg: errorTextFieldsMap['email'],
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  username = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: 'Enter your username'),
              ),
              InputValidationText(
                msg: errorTextFieldsMap['username'],
              ),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  password1 = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              InputValidationText(
                msg: errorTextFieldsMap['password'],
              ),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  password2 = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: 'Confirm your password'),
              ),
              InputValidationText(
                msg: errorTextFieldsMap['password'],
              ),
              RoundedButton(
                text: 'Sign Me Up!',
                color: Colors.yellowAccent,
                onPressed: () async {
                  _resetErrorMap();

                  setState(() {
                    _showSpinner = true;
                  });

                  try {
                    Map data = {
                      'email': email,
                      'username': username,
                      'password': password1,
                      'password2': password2,
                    };

                    var response =
                        await NetworkUtils.post('users/register/', data);

                    if (response['response'] == 'Success') {
                      /*
                      * StatusCode: 200 -> json: {response: Success, emial: kornel@wp.pl, username: kornel, token: bb0a2edc5044623b93f6653e4188d4e13f36287e} 
                      */
                      _showFlashBar(context, response['email']);
                    } else {
                      /*
                      * StatusCode: 200 -> json: {email:    [Enter a valid email address.]} 
                      * StatusCode: 200 -> json: {email:    [my user with this email address already exists.]}
                      * StatusCode: 200 -> json: {username: [my user with this username already exists.]} 
                      * StatusCode: 400 -> json: {password: Password must contain at least 8 characters.}
                      * StatusCode: 400 -> json: {password: Password must much} 
                      */
                      setState(() {
                        response.forEach((k, v) => {
                              errorTextFieldsMap[k] = v
                                  .toString()
                                  .replaceAll(new RegExp(r'[^\s\w]'), '')
                                  .replaceAll(new RegExp('my user'), 'User')
                            });
                      });
                    }
                  } catch (e) {
                    print(e);
                  }

                  setState(() {
                    _showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
