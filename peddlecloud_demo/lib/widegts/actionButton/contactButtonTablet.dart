import 'package:flutter/material.dart';

class ContactButtonTablet extends StatelessWidget {
  final String title;
  ContactButtonTablet(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      ),
      decoration: BoxDecoration(
        color: Colors.amber[700],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
