import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'data/json_user.dart';
import 'home.dart';
import 'homepage.dart';


class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  void onSubmit() {
    if (email != null && password != null) {
      print('Login with: ' + email + ' & ' + password);
      Navigator.of(context).pushNamed('/homePage');
    } else {
      print('input field empty');
    }
  }

  static var url = 'https://peddlecloud.com/pavdev/api//auth/';

  static BaseOptions options = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.plain,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    validateStatus: (code) {
      if(code >= 200){
        return true;
      }
    }

  );
  static Dio dio = Dio(options);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final TextEditingController _email =  TextEditingController();
  static final TextEditingController _pass =  TextEditingController();

  bool _isLoading = false;

  String get email => _email.text;
  String get password => _pass.text;

  Future<dynamic> _loginUser(String email, String password) async {
    try {
      Options options = Options(
        contentType: ContentType.parse("application/json"),
      );
      Response response = await dio.post("/user_login", data: {"email": email, "password": password, "android_id": "2"}, options: options);
      if (response.statusCode == 200 || response.statusCode == 201){
        var responseJson = json.decode(response.data);
        return responseJson;
      }else if (response.statusCode == 401){
        throw Exception("Incorrect Email or password");
      }else{
        throw Exception("Authentication Error");
      }
    }on DioError catch (exception){
      if (exception == null || exception.toString().contains('ScoketException')){
        throw Exception('Network Error');
      }else if (exception.type == DioErrorType.RECEIVE_TIMEOUT || exception.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception('Could not connect');
      }else{
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: _isLoading
              ? CircularProgressIndicator()
              : Column(
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
                  TextField(
                    controller: _email,
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
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _pass,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: ()  async{
                          setState (() => _isLoading = true);
                          var res = await _loginUser(_email.text, _pass.text);
                          setState(() => _isLoading = false);
                          JsonUser user = JsonUser.fromJson(res);
                          if (user != null){
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return Home(
                                  user: user,
                                );
                              } ));
                          }else{
                            Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Wrong Email"),)
                            );
                          }                        
                        },
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
    );
  }
}

class _HomePage {
}
