import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:HajiraKhata/api/global.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecoveryPass(),
    );
  }
}

class RecoveryPass extends StatefulWidget {
  @override
  _RecoveryPassState createState() => _RecoveryPassState();
}

class _RecoveryPassState extends State<RecoveryPass> {
  final formKey = GlobalKey<FormState>();
  String email, username;

   Future<void> forgetPass() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      Map input = {
        'official_email': email,
        'username': username,
        'role_id': '2',
      };

      try {
        var url = '$base_url/auth/user_forget_password';
        var response = await http.post(url, body: input);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (responseBody['status']) {
            // var responseData = responseBody['data'];
            showToast(responseBody['message']);
            print(responseBody);

            Navigator.of(context).pushNamedAndRemoveUntil(
                '/logIn', (Route<dynamic> route) => false);
            // setState(() {
            //   isLoading = false;
            // });
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
                width: MediaQuery.of(context).size.width,
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
                            'hajiraKhata',
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
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 130.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'forget pass',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4.5),
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '?',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 60.0,
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
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 45.0, left: 30.0, right: 30.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (input) => username = input,
                      decoration: InputDecoration(
                        labelText: 'USERNAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onSaved: (input) => email = input,
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
                      height: 70.0,
                    ),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            forgetPass();
                          },
                          child: Center(
                            child: Text(
                              'GET PASSWORD',
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
                      height: 20.0,
                    ),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/logIn');
                          },
                          child: Center(
                            child: Text(
                              '<< GO BACK',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    )
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
