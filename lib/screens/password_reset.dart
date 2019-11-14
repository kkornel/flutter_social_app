import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/rounded_button.dart';
import 'package:flutter_social_app/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PasswordResetScreen extends StatefulWidget {
  static String id = "password_reset_screen";

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  String email;

  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Container(
                child: Text('We got you, no worries.'),
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
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Reset',
                color: Colors.yellowAccent,
                onPressed: () async {
                  // setState(() {
                  //   _showSpinner = true;
                  // });
                  try {
                    // final authResult = await _auth.signInWithEmailAndPassword(
                    // email: email, password: password);
                    // if (authResult.user != null) {
                    // Navigator.pushNamed(context, ChatScreen.id);
                    // }

                    // try {
                    //   var responseData = await NetworkUtils.post('users/login/',
                    //       {'username': this.email, 'password': this.password});

                    //   print(responseData);

                    //   UserAccount.TOKEN = responseData['token'];

                    //   // TODO: get full user profile

                    //   Navigator.pushNamed(context, HomeScreen.id);
                    // } catch (exception) {
                    //   print(exception);
                    //   Flushbar(
                    //     message: "Invalid login or password.",
                    //     margin: EdgeInsets.all(8.0),
                    //     borderRadius: 20.0,
                    //     backgroundColor: Colors.red,
                    //     icon: Icon(
                    //       Icons.remove_circle_outline,
                    //       size: 28.0,
                    //       color: Colors.white,
                    //     ),
                    //     duration: Duration(seconds: 3),
                    //   )..show(context);
                    // }

                    // setState(() {
                    //   _showSpinner = false;
                    // });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
