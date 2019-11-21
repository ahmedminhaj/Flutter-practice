import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(Navbar());

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}