import 'package:flutter/material.dart';

class EditProfileCard extends StatelessWidget {
  final String keyName;
  final String oldValue;
  final  onSave;

  EditProfileCard({
    this.keyName,
    this.oldValue,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70.0,
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextFormField(
            initialValue: oldValue,
            onSaved: onSave,
            decoration: InputDecoration(
              labelText: keyName,
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
