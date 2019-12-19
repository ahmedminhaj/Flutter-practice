import 'package:flutter/material.dart';

class AttendanceButton extends StatelessWidget {
  final String inputText;
  final onPressed;
  final shadow;
  final color;

  AttendanceButton({this.color, this.inputText, this.onPressed, this.shadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: shadow,
        color: color,
        elevation: 7.0,
        child: FlatButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              inputText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
      ),
    );
  }
}
