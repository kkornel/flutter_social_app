import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/input_validation_text.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/screens/login_screen.dart';
import 'package:flutter_social_app/utils/constants.dart';
import 'package:flutter_social_app/utils/constants_api.dart' as API;
import 'package:flutter_social_app/utils/constants_strings.dart' as STRINGS;
import 'package:flutter_social_app/utils/network_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email;
  String _username;
  String _password;
  String _password2;
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
      message: STRINGS.MSG_ACCOUNT_CREATED_FOR + ' $_email',
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
          STRINGS.SIGN_IN,
          style: TextStyle(color: Colors.white),
        ),
      ),
    )..show(context);
  }

  Future<void> _registerUser(context) async {
    _resetErrorMap();

    setState(() {
      _showSpinner = true;
    });

    try {
      var response = await NetworkUtils.registerUser(
          _email, _username, _password, _password2);

      print(response);

      if (response[API.FIELD_RESPONSE] == API.SUCCESS) {
        _showFlashBar(context, response[API.FIELD_EMAIL]);
      } else {
        setState(() {
          response.forEach((k, v) => errorTextFieldsMap[k] = v);
        });
      }
    } catch (e) {
      print(e);
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
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _email = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: STRINGS.ENTER_EMAIL),
              ),
              InputValidationText(
                msg: errorTextFieldsMap['email'],
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _username = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: STRINGS.ENTER_USERNAME),
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
                  _password = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: STRINGS.ENTER_PASSWORD),
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
                  _password2 = value;
                },
                decoration: kEmailPasswordInputDecoration.copyWith(
                    hintText: STRINGS.MSG_CONFRIM_PASSWORD),
              ),
              InputValidationText(
                msg: errorTextFieldsMap['password'],
              ),
              RoundedButton(
                text: STRINGS.MSG_SIGN_ME_UP,
                color: Colors.yellowAccent,
                onPressed: () async {
                  await _registerUser(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
