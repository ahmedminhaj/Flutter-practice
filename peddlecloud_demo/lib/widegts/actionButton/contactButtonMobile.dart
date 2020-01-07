import 'package:flutter/material.dart';

class ContactButtonMobile extends StatelessWidget {
  final String title;
  ContactButtonMobile(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.amber[700],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
