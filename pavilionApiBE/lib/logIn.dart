import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pavilion/api/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password;
  bool passwordVisible;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  Future<void> login() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      Map input = {
        'email': _email,
        'password': _password,
        'role_id': '2',
      };

      try {
        var url = '$base_url/auth/user_login';
        var response = await http.post(url, body: input);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (responseBody['status']) {
            var responseData = responseBody['data'];

            // Saving response data in Shared preference
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('user_id', responseData['id']);
            prefs.setString('user_name', responseData['name']);
            prefs.setString('user_designation', responseData['designation']);
            prefs.setString('user_department', responseData['department']);
            prefs.setString('users_username', responseData['username']);
            prefs.setString('token', responseData['token']);
            print(responseData);
            // Navigate to homepage
            Navigator.of(context).pushNamed('/navigationPage');
          } else {
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
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '_',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          SizedBox(width: 0.2),
                          Text(
                            'teamPavilion',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'login',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 90.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 6.1),
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 90.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      validator: (input) =>
                          !input.contains('@') ? 'Not a valid Email' : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onSaved: (val) => _password = val,
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
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
                      obscureText: passwordVisible,
                      validator: (input) => input.length < 5
                          ? 'Password must be more then 5 characters'
                          : null,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: FlatButton(
                          onPressed: login,
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New in Pavilion ?',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signUp');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
