import 'package:flutter/material.dart';
import 'package:pavilion/drawerWidget/drawer.dart';

class Reimbursment extends StatefulWidget {
  @override
  _ReimbursmentState createState() => _ReimbursmentState();
}

class _ReimbursmentState extends State<Reimbursment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reimbursment"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          'under construction',
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
