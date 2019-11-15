import 'package:flutter/material.dart';
import 'package:flutter_social_app/utils/constants.dart';
import 'package:flutter_social_app/utils/constants_strings.dart' as STRINGS;

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          MaterialButton(
            onPressed: null,
            child: Text(STRINGS.LOGIN),
          ),
          MaterialButton(
            onPressed: null,
            child: Text(STRINGS.REGISTER),
          ),
        ],
      ),
    );
  }
}
