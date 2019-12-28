import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pavilion/customWidget/customText.dart';
import 'package:pavilion/customWidget/homePageButton.dart';
import 'package:pavilion/customWidget/loadingPage.dart';
import 'package:pavilion/drawerWidget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pavilion/api/global.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getUserFromSP();
    super.initState();
  }

  bool isLoading = false;
  String userName = "";
  String userDesignation = "";
  String userDepartment = "";
  var token;
  String userID = "";
  String email = "";
  String meal = "";
  String entry = "";
  String exit = "";
  // String entryMsg = "Please tap the 'Entry Time' button.";
  // String exitMsg = "Tap the 'Exit Time' button before leave the office.";

  getUserFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('users_username') ?? '';
      userDesignation = prefs.getString('user_designation') ?? '';
      userDepartment = prefs.getString('user_department') ?? '';
      userID = prefs.getString('user_id') ?? '';
      token = prefs.getString('token') ?? '';
      isLoading = true;
    });
    if (userID == '' && userName == '') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/logIn', (Route<dynamic> route) => false);
    } else {
      loadingProfile();
    }
  }

  Future<void> loadingProfile() async {
    Map input = {
      'user_id': userID,
    };
    try {
      var url = '$base_url/user/user_today_info';
      var response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status']) {
          var responseData = responseBody['data'];
          //print(responseData);
          setState(() {
            email = responseData['email'];
            meal = responseData['meal'] != null ? "Placed" : "Not Placed";
            entry = responseData['entry_time'] ?? "0";
            exit = responseData['exit_time'] ?? "0";
            isLoading = false;
          });
          print(responseBody);
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
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> entryTime() async {
    Map input = {
      'user_id': userID,
    };
    try {
      var url = '$base_url/user/user_entry_time';
      var response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status']) {
          showToast(responseBody['message']);
          loadingProfile();
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
        //print('Error in status code');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> exitTime() async {
    Map input = {
      'user_id': userID,
    };
    try {
      var url = '$base_url/user/user_exit_time';
      var response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status']) {
          showToast(responseBody['message']);
          loadingProfile();
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
        //print('Error in status code');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEEEEEEEEE,  d MMMM y").format(now);
    return isLoading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: Text("Home"),
            ),
            drawer: AppDrawer(),
            body: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.4,
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
                        bottomLeft: Radius.circular(100),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/image/avater.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                inputText: "$userName",
                                textColor: Colors.white,
                              ),
                              CustomText(
                                inputText: "$userDesignation",
                                textColor: Colors.white,
                              ),
                              CustomText(
                                inputText: "$userDepartment",
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white24,
                          Colors.white,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: CustomText(
                            inputText: formattedDate,
                            textColor: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        meal == "Not Placed"
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: HomePageButton(
                                  buttonText: "Place today's meal",
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/mealOrder');
                                  },
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: CustomText(
                                  inputText: "Today's meal is $meal",
                                  textColor: Colors.black,
                                  align: TextAlign.center,
                                ),
                              ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: entry == "0"
                              ? HomePageButton(
                                  buttonText: "Press to add entry time",
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    entryTime();
                                  },
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      CustomText(
                                        inputText: "Today's entry time $entry",
                                        textColor: Colors.black,
                                        align: TextAlign.center,
                                      ),
                                      exit == "0"
                                          ? HomePageButton(
                                              buttonText:
                                                  "Press to add exit time",
                                              onPressed: () {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                exitTime();
                                              },
                                            )
                                          : CustomText(
                                              inputText:
                                                  "Today's exit time $exit",
                                              textColor: Colors.black,
                                              align: TextAlign.center,
                                            )
                                    ],
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
