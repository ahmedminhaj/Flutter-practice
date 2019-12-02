import 'package:flutter/material.dart';

class NoticeMail extends StatefulWidget {
  @override
  _NoticeMailState createState() => _NoticeMailState();
}

class _NoticeMailState extends State<NoticeMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Mail & Notice',
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
