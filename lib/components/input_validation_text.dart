import 'package:flutter/material.dart';

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
