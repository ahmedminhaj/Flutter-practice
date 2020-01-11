import 'dart:io';

import 'package:flutter/material.dart';
import 'package:HajiraKhata/customWidget/profileHeader.dart';
import 'package:HajiraKhata/customWidget/submitButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:HajiraKhata/api/global.dart';
import 'dart:convert';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisible;
  String newPass, confirmPass, oldPass;

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
        'oldpassword': oldPass,
        'newpassword': newPass,
        'confirmnewpassword': confirmPass,
      };

      print(inputPass);

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
    passwordVisible = true;
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
                    TextFormField(
                      onSaved: (val) => oldPass = val,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: "Previous Password",
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
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (input) => input.length < 5
                          ? 'Password must be more then 5 characters'
                          : null,
                    ),
                    TextFormField(
                      onSaved: (val) => newPass = val,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: "New Password",
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
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (input) => input.length < 5
                          ? 'Password must be more then 5 characters'
                          : null,
                    ),
                    TextFormField(
                      onSaved: (val) => confirmPass = val,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: "Previous Password",
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
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (input) =>
                          input == newPass ? "new password didn't match" : null,
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
