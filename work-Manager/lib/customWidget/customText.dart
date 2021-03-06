import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String inputText;
  final textColor;
  final align;

  CustomText({
    this.align,
    this.inputText,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
    
      inputText,
      style: TextStyle(
          color: textColor,
          fontSize: 19.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins'),
      textAlign: align,
    );
  }
}
