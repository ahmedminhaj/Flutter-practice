import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/profileHeader.dart';
import 'package:pavilion/customWidget/resetFormField.dart';
import 'package:pavilion/customWidget/submitButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisible;
  String _newPass, _confirmPass, _oldPass, tempPass;

  String userID = "";
  String userName, userDesignation, userDepartment;
  var data, token;
  var userData;

  Future<void> profileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');

    setState(() {
      userName = prefs.getString('user_full_name');
      userDepartment = prefs.getString('user_department_name');
      userDesignation = prefs.getString('user_designation');
    });
  }

  Future<void> resetPass() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');
      token = prefs.getString('token') ?? '';
      Map inputPass = {
        'user_id': userID,
        'oldpassword': _oldPass,
        'newpassword': _newPass,
        'confirmnewpassword': _confirmPass,
      };

      try {
        var url = '$base_url/user/change_password';
        http.Response response = await http.post(url,
            headers: {HttpHeaders.authorizationHeader: token}, body: inputPass);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody['status']) {
            prefs.clear();
            showToast(responseBody['message']);

            //Navigator.of(context).pushNamed('/logIn');
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/logIn', (Route<dynamic> route) => false);
          } else {
            if (responseBody['message'] == tokenDatabaseCheck ||
                responseBody['message'] == tokenTimeCheck) {
              showToast(responseBody['message']);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/logIn', (Route<dynamic> route) => false);
            } else {
              showToast(responseBody['message']);
            }
          }
        } else {
          print('Error in status code');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    passwordVisible = false;
    profileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Password Reset"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              ProfileHeader(
                userName: "$userName",
                designation: "$userDesignation",
                department: "$userDepartment",
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0.0),
                child: Column(
                  children: <Widget>[
                    ResetFormField(
                      labeltext: "Previous Password",
                      inputPass: _oldPass,
                      passwordVisible: passwordVisible,
                      validation: (input) => input.length < 5
                          ? 'Password must be more then 5 characters'
                          : null,
                    ),
                    ResetFormField(
                      labeltext: "New Password",
                      inputPass: _newPass,
                      passwordVisible: passwordVisible,
                      validation: (input) => input.length < 5
                          ? 'Password must be more then 5 characters'
                          : null,
                    ),
                    ResetFormField(
                      labeltext: "Confirm Password",
                      inputPass: _confirmPass,
                      passwordVisible: passwordVisible,
                      validation: (input) => input == _newPass
                          ? "new password didn't match"
                          : null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SubmitButton(
                      buttonTitle: "Reset",
                      onPressed: resetPass,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
