import 'package:flutter/material.dart';

class Reimbursment extends StatefulWidget {
  @override
  _ReimbursmentState createState() => _ReimbursmentState();
}

class _ReimbursmentState extends State<Reimbursment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bills & Convins',
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
