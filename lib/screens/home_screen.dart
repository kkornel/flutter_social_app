import 'package:flutter/material.dart';

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
          Row(
            children: <Widget>[
              Image.asset('images/logo.png'),
              Text('Social APP'),
            ],
          ),
          MaterialButton(
            onPressed: null,
            child: Text('Login'),
          ),
          MaterialButton(
            onPressed: null,
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
