import 'package:flutter/material.dart';
import 'package:pavilion/drawerWidget/drawer.dart';

class NoticeMail extends StatefulWidget {
  @override
  _NoticeMailState createState() => _NoticeMailState();
}

class _NoticeMailState extends State<NoticeMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
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
