import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/customText.dart';

class HomePageButton extends StatelessWidget {
  final onPressed;
  final String buttonText;

  HomePageButton({
    this.buttonText,
    this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: onPressed,
      child: CustomText(
        inputText: buttonText,
        textColor: Colors.white,
      ),
    );
  }
}
