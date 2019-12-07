import 'package:flutter/material.dart';

class EditProfileCard extends StatelessWidget {
  final String keyName;
  final String value;

  EditProfileCard({
    this.keyName,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: keyName,
              hintText: value,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
