import 'package:flutter/material.dart';

class Leave extends StatefulWidget {
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Leave management',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 6.1,
          ),
        ),
      ),
    );
  }
}
