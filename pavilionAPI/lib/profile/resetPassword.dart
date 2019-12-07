import 'package:flutter/material.dart';
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
  String _newPass, _confirmPass, _oldPass;

  String userID = "";
  var data;
  var userData;
  String email,
      name,
      personalEmail,
      address,
      contactNumber,
      joinDate,
      nid,
      bloodGroup,
      designation,
      emergencyContact,
      bankAccount,
      department;

  Future<void> profileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    Map input = {
      'user_id': userID,
    };
    var url = '$base_url/user/user_profile';
    http.Response response = await http.post(url, body: input);
    data = jsonDecode(response.body);
    userData = data['data'];
    setState(() {
      email = userData['email'];
      name = userData['name'];
      personalEmail = userData['personal_email'];
      address = userData['permanent_address'];
      contactNumber = userData['contact_no'];
      joinDate = userData['join_date'];
      nid = userData['nid'];
      bloodGroup = userData['blood_group'];
      designation = userData['designation'];
      emergencyContact = userData['emergency_contact'];
      bankAccount = userData['bank_account_no'];
      department = userData['department_name'];
    });
    //debugPrint(userData.toString());
    print(data);
  }

  Future<void> resetPass() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');
      Map inputPass = {
        'user_id': userID,
        'oldpassword': _oldPass,
        'newpassword': _newPass,
        'confirmnewpassword': _confirmPass,
      };

      try {
        var url = '$base_url/user/change_password';
        http.Response response = await http.post(url, body: inputPass);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody['status']) {
            showToast(responseBody['message']);
            Navigator.of(context).pushNamed('/logIn');
          } else {
            showToast(responseBody['message']);
            print(responseBody);
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
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green[700],
                              Colors.green[200],
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(300),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.green[300],
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "$name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "$designation",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 5.5,
                            ),
                            Text(
                              "$department",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 105, 0, 0),
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10.0, 10.0)),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/image/avater.jpg'),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 9.0,
                            color: Colors.blue[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (val) => _oldPass = val,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Previous Password',
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
                      onSaved: (val) => _newPass = val,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'New Password',
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
                      onSaved: (val) => _confirmPass = val,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
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
                      validator: (input) => input == _newPass
                          ? "new password didn't match"
                          : null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 120.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: FlatButton(
                          onPressed: resetPass,
                          child: Center(
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
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
