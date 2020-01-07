import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String inputText;
  final textColor;
  LabelText({
    this.inputText,
    this.textColor
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      inputText,
      style: TextStyle(
          color: textColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins'),
      
    );
  }
}