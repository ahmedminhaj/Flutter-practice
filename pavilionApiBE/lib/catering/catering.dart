import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/customText.dart';
import 'package:pavilion/customWidget/loadingPage.dart';
import 'package:pavilion/customWidget/secondaryHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class Catering extends StatefulWidget {
  @override
  _CateringState createState() => _CateringState();
}

class _CateringState extends State<Catering> {
  String userID = "";
  Map data;
  List userData;
  var token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cateringList();
  }

  Future<void> cateringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    token = prefs.getString('token') ?? '';
    Map input = {
      'user_id': userID,
    };
    try {
      var url = '$base_url/catering/user_catering_list';
      http.Response response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          //print(responseBody);
          data = json.decode(response.body);
          setState(() {
            userData = data["data"];
            isLoading = false;
          });
        } else {
          //print('status false');
          //print(responseBody);

          if (responseBody['message'] == tokenDatabaseCheck ||
              responseBody['message'] == tokenTimeCheck) {
            showToast(responseBody['message']);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/logIn', (Route<dynamic> route) => false);
          } else {
            setState(() {
              isLoading = false;
            });
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

  Future<void> deleteMeal(String id) async {
    Map input = {
      'id': id,
    };
    try {
      var url = '$base_url/catering/user_catering_order_delete';
      http.Response response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          //print(responseBody);
          data = json.decode(response.body);
          setState(() {
            cateringList();
          });
        } else {
          //print('status false');
          //print(responseBody);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            SecondaryHeader(
              headerName: "Catering List",
              onPressed: cateringList,
            ),
            Expanded(
              child: isLoading
                  ? LoadingPage()
                  : ListView.builder(
                      itemCount: userData == null ? 0 : userData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[200],
                                Colors.grey[300],
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CustomText(
                                inputText: " ${userData[index]["date"]}",
                                textColor: Colors.black,
                              ),
                              CustomText(
                                inputText: " ${userData[index]["day"]}",
                                textColor: Colors.black,
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    String id = '${userData[index]["id"]}';
                                    // Alert(
                                    //   context: context,
                                    //   type: AlertType.error,
                                    //   title: "Meal Cancelation",
                                    //   desc: "Do you want to cancel you Meal?",
                                    //   buttons: [
                                    //     DialogButton(
                                    //       child: Text(
                                    //         "Confirm",
                                    //         style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 20),
                                    //       ),
                                    //       onPressed: () 
                                    //       {
                                    //         deleteMeal(id);
                                    //         //Navigator.pop(context);
                                    //         setState(() {
                                    //           isLoading = true;
                                    //         });
                                    //       },
                                    //     )
                                    //   ],
                                    // ).show();
                                    deleteMeal(id);
                                    setState(() {
                                      isLoading = true;
                                    });
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Poppins',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[700],
          elevation: 25.0,
          onPressed: () {
            Navigator.of(context).pushNamed('/mealOrder');
          },
          child: Icon(Icons.restaurant_menu),
        ),
      ),
    );
  }
}
