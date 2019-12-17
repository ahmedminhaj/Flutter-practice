import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class Overtime extends StatefulWidget {
  @override
  _OvertimeState createState() => _OvertimeState();
}

class _OvertimeState extends State<Overtime> {
  String userID = "";
  Map data;
  List userData;
  var token;

  @override
  void initState() {
    super.initState();
    overtimeList();
  }

  Future<void> overtimeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    token = prefs.getString('token') ?? '';
    Map input = {
      'user_id': userID,
      'type': '2',
    };
    try{
      var url = '$base_url/leave/user_overtime_list';
    http.Response response = await http.post(url, headers: {HttpHeaders.authorizationHeader: token}, body: input);
    if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          print(responseBody);
          data = json.decode(response.body);
          setState(() {
            userData = data["data"];
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
    }catch(e){
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green[700],
                    Colors.green[400],
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Overtime List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 50.0),
                  //   child: FlatButton(
                  //     onPressed: () {},
                  //     child: Center(
                  //       child: Icon(
                  //         Icons.search,
                  //         color: Colors.white,
                  //       ),
                  //       // Text(
                  //       //   'Search',
                  //       //   style: TextStyle(color: Colors.white, fontSize: 20),
                  //       // ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0),
                    child: FlatButton(
                      onPressed: overtimeList,
                      child: Center(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userData == null ? 0 : userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: userData[index]["is_approved"] == 'Approved'
                            ? [
                                Colors.green[200],
                                Colors.green[300],
                              ]
                            : userData[index]["is_approved"] == 'Rejected'
                                ? [
                                    Colors.red[100],
                                    Colors.red[200],
                                  ]
                                : [
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
                        Text(
                          " ${userData[index]["date"]}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "${userData[index]["is_approved"]}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
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
          onPressed: () {
            Navigator.of(context).pushNamed('/riseOvertime');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
