import 'package:flutter/material.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(25.0),
      child: Text(
        'Attendance List',
        style: TextStyle(
          fontSize: 36,
        ),
      ),
    );
  }
}
