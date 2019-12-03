import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pavilion/global.dart';
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

  String userName = "";
  String userID = "";

  String email = "";
  String meal = "";
  String entry = "";
  String exit = "";

  String entryMsg = "On The Way";
  String exitMsg = "Still Working";

  getUserFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('user_name') ?? '';
      userID = prefs.getString('user_id') ?? '';
    });
    loadingProfile();
  }

  Future<void> loadingProfile() async {
    Map input = {
      'user_id': userID,
    };

    try {
      var url = '$base_url/user/user_profile';
      var response = await http.post(url, body: input);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          var responseData = responseBody['data'];
          //print(responseData);
          setState(() {
            email = responseData['email'];
            meal = responseData['meal'] != null ? "Placded" : "Not Placed";
            entry = responseData['entry_time'] ?? entryMsg;
            exit = responseData['exit_time'] ?? exitMsg;
          });
        } else {
          print(responseBody);
        }
      } else {
        //print('Error in status code');
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
      var response = await http.post(url, body: input);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          showToast(responseBody['message']);
          loadingProfile();
        } else {
          showToast(responseBody['message']);
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
      var response = await http.post(url, body: input);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          showToast(responseBody['message']);
          loadingProfile();
        } else {
          showToast(responseBody['message']);
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
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
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://image.freepik.com/free-vector/profile-icon-male-emotion-avatar_48369-2004.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.2,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$userName',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Text(
                          '$email',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Text(
                          'Trainee',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Text(
                          'Peddlecloud',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white24,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(75),
                ),
              ),
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Today's meal: $meal",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                      //letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    "Entry : $entry",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    "Exit : $exit",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      entry == entryMsg
                          ? Container(
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.green,
                                color: Colors.green[400],
                                elevation: 7.0,
                                child: FlatButton(
                                  onPressed: entryTime,
                                  child: Center(
                                    child: Text(
                                      'Entry Time',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      entry != entryMsg && exit == exitMsg
                          ? Container(
                              //padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.redAccent,
                                color: Colors.red[300],
                                elevation: 7.0,
                                child: FlatButton(
                                  onPressed: exitTime,
                                  child: Center(
                                    child: Text(
                                      'Exit Time',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
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
