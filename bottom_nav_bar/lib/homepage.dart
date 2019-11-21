import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(25.0),
      child: Text(
        'Home Page',
        style: TextStyle(
          fontSize: 36,
        ),
      ),
    );
  }
}
