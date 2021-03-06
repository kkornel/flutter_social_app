import 'package:flutter/material.dart';
import 'package:flutter_social_app/screens/home_screen.dart';
import 'package:flutter_social_app/screens/login_screen.dart';
import 'package:flutter_social_app/screens/password_reset.dart';
import 'package:flutter_social_app/screens/registration_screen.dart';
import 'package:flutter_social_app/screens/welcome_screen.dart';
import 'package:flutter_social_app/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<UserAccount>(
    // builder: (context) => UserAccount(),
    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: WelcomeScreen.id,
      initialRoute: HomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PasswordResetScreen.id: (context) => PasswordResetScreen(),
      },
    );
  }
}
