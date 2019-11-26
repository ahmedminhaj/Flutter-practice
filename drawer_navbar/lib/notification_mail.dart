import 'package:flutter/material.dart';

class NotificationMail extends StatefulWidget {
  @override
  _NotificationMailState createState() => _NotificationMailState();
}

class _NotificationMailState extends State<NotificationMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Mail & Notification',
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
