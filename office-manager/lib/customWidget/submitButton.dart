import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final onPressed;
  final String buttonTitle;

  SubmitButton({
    this.buttonTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 120.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.greenAccent,
        color: Colors.green,
        elevation: 7.0,
        child: FlatButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              buttonTitle,
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
