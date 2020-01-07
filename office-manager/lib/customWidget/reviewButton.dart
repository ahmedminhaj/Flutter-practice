import 'package:flutter/material.dart';

class ReviewButton extends StatelessWidget {
  final shadow;
  final color;
  final onPressed;
  final buttonText;

  ReviewButton({
    this.buttonText,
    this.color,
    this.onPressed,
    this.shadow,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 110,
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        shadowColor: shadow,
        color: color,
        elevation: 7.0,
        child: FlatButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
      ),
    );
  }
}
