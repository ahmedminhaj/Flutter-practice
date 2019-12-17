import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';

class AttendanceReview extends StatefulWidget {
  @override
  _AttendanceReviewState createState() => _AttendanceReviewState();
}

class _AttendanceReviewState extends State<AttendanceReview> {
  static final TextEditingController _commentController =
      TextEditingController();
  String get comment => _commentController.text;
  var attendanceID, attendanceExitTime, attendanceEntryTime, attendanceDate;
  Map data;
  List userData;

  attendanceDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      attendanceEntryTime = prefs.getString('attendance_entry_time');
      attendanceExitTime = prefs.getString('attendance_exit_time');
      attendanceDate = prefs.getString('attendance_date');
    });
  }

  @override
  void initState() {
    attendanceDetails();
    super.initState();
  }

  Future<void> reviewAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    attendanceID = prefs.getString('attendance_id');

    print("review comment:: " + comment);
    if (comment == '') {
      showToast("Review details missing");
    } else {
      Map input = {
        'id': attendanceID,
        'comment': comment,
      };
      try {
        var url = '$base_url/user/user_attendance_review';
        var response = await http.post(url, body: input);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (responseBody['status']) {
            var responseData = responseBody['message'];

            print(responseData);

            showToast(responseBody['message']);
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

  goBack() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('attendance_id');
    pref.remove('attendance_entry_time');
    pref.remove('attendance_exit_time');
    pref.remove('attendance_date');
    // await pref.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      onPressed: goBack,
                      child: Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: 35,
                    color: Colors.white,
                  ),
                  Text(
                    "Review",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.white,
                        letterSpacing: 2.1),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 100.0, left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    attendanceEntryTime == 'NULL'
                        ? " You forgot to input entry time "
                        : "Entry at $attendanceEntryTime",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    attendanceExitTime == 'NULL'
                        ? " You forgot to input exit time "
                        : "Exit at $attendanceExitTime",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Date $attendanceDate",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Review details',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
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
                        onPressed: reviewAttendance,
                        child: Center(
                          child: Text(
                            'Review',
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
