import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
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
  String emailMsg = 'dsadasdasdsa';
  String username;
  String usernameMsg = '';
  String password1;
  String password1Msg = '';
  String password2;
  String password2Msg = '';
  bool _showSpinner = false;

  Flushbar flush;
  bool _wasButtonClicked;

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
                msg: this.emailMsg,
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
                msg: this.usernameMsg,
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
                msg: this.password1Msg,
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
                msg: this.password2Msg,
              ),
              RoundedButton(
                text: 'Sign Me Up!',
                color: Colors.yellowAccent,
                onPressed: () async {
                  flush = Flushbar<bool>(
                    // title: "Hey Ninja",
                    margin: EdgeInsets.all(8.0),
                    borderRadius: 20.0,
                    backgroundColor: Colors.green,
                    message: "Account created for: ksadasdasodihaskdlj@wp.pl",
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    mainButton: FlatButton(
                      onPressed: () {
                        flush.dismiss(true); // result = true
                        // Navigator.pushNamed(context, LoginScreen.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              emailFromRegister: 'dsadasdsa',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Back to Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ) // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
                    ..show(context).then((result) {
                      setState(() {
                        // setState() is optional here
                        _wasButtonClicked = result;
                      });
                    });

                  // setState(() {
                  //   _showSpinner = true;
                  // });
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
                      flush = Flushbar<bool>(
                        title: "Hey Ninja",
                        margin: EdgeInsets.all(8.0),
                        borderRadius: 20.0,
                        backgroundColor: Colors.red,
                        message:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                        icon: Icon(
                          Icons.done_outline,
                          color: Colors.white,
                        ),
                        mainButton: FlatButton(
                          onPressed: () {
                            flush.dismiss(true); // result = true
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(color: Colors.amber),
                          ),
                        ),
                      ) // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
                        ..show(context).then((result) {
                          setState(() {
                            // setState() is optional here
                            _wasButtonClicked = result;
                          });
                        });

                      // Flushbar(
                      //   message: "Invalid login or password.",
                      //   margin: EdgeInsets.all(8.0),
                      //   borderRadius: 20.0,
                      //   backgroundColor: Colors.red,
                      //   icon: Icon(
                      //     Icons.remove_circle_outline,
                      //     size: 28.0,
                      //     color: Colors.white,
                      //   ),
                      //   duration: Duration(seconds: 3),
                      // )..show(context);

                      var s = LoginScreen.id;
                      // Navigator.pushNamed(context, LoginScreen.id);
                    }

                    print('json: $response');

                    print(response['response']);

                    // setState(() {
                    //   this.emailMsg = 'sss';
                    // });
                    // UserAccount.TOKEN = responseData['token'];

                    // // TODO: get full user profile

                    // Navigator.pushNamed(context, HomeScreen.id);

                    // Flushbar(
                    //   message: "Invalid login or password.",
                    //   margin: EdgeInsets.all(8.0),
                    //   borderRadius: 20.0,
                    //   backgroundColor: Colors.red,
                    //   icon: Icon(
                    //     Icons.remove_circle_outline,
                    //     size: 28.0,
                    //     color: Colors.white,
                    //   ),
                    //   duration: Duration(seconds: 3),
                    // )..show(context);

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

class InputValidationText extends StatelessWidget {
  InputValidationText({@required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 0.0, bottom: 5.0),
        child: Text(
          this.msg,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
