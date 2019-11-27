import 'package:flutter/material.dart';

class Catering extends StatefulWidget {
  @override
  _CateringState createState() => _CateringState();
}

class _CateringState extends State<Catering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Catering List',
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
