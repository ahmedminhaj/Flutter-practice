import 'package:flutter/material.dart';

class ResetFormField extends StatelessWidget {
  bool passwordVisible;
  String inputPass;
  String labeltext;
  final validation;

  ResetFormField({
    this.inputPass,
    this.validation,
    this.labeltext,
    this.passwordVisible,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (val) => inputPass = val,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.green,
          ),
          onPressed: () {
            passwordVisible = !passwordVisible;
          },
        ),
      ),
      validator: validation,
    );
  }
}
