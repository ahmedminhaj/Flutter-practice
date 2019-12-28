import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final commentController;
  final String boxLabel;

  CommentBox({
    this.boxLabel,
    this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: commentController,
      decoration: InputDecoration(
        labelText: boxLabel,
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
