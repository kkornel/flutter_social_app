import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/input_validation_text.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/screens/login_screen.dart';
import 'package:flutter_social_app/utils/constants.dart';
import 'package:flutter_social_app/utils/network_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_social_app/utils/constants_strings.dart' as STRINGS;
import 'package:flutter_social_app/utils/constants_api.dart' as API;

class PasswordResetScreen extends StatefulWidget {
  static String id = "password_reset_screen";

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  String _email;
  String _emailErrorMsg = '';

  bool _showSpinner = false;

  void _showFlashBar(context, String email, String msg) {
    Flushbar(
      margin: EdgeInsets.all(8.0),
      borderRadius: 30.0,
      backgroundColor: Colors.green,
      message: msg,
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
                emailFromRegister: email,
              ),
            ),
          );
        },
        child: Text(
          STRINGS.BACK_TO_LOGIN,
          style: TextStyle(color: Colors.white),
        ),
      ),
    )..show(context);
  }

  Future<void> _resetPassword() async {
    _emailErrorMsg = '';

    setState(() {
      _showSpinner = true;
    });

    try {
      var responseData = await NetworkUtils.resetUserPassword(_email);

      if (responseData[API.FIELD_RESPONSE] == API.SUCCESS) {
        _showFlashBar(context, _email, STRINGS.MSG_PASSWORD_EMAIL_SENT);
      } else {
        setState(() {
          _emailErrorMsg = responseData[API.FIELD_CONTENT];
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
                height: 24.0,
              ),
              Center(
                child: Container(
                  child: Text(
                    STRINGS.WE_GOT_YOU,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
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
                msg: _emailErrorMsg,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: STRINGS.RESET,
                color: Colors.yellowAccent,
                onPressed: () async {
                  await _resetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
