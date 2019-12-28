import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/commentBox.dart';
import 'package:pavilion/customWidget/headerContainer.dart';
import 'package:pavilion/customWidget/submitButton.dart';
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
  var attendanceID,
      attendanceExitTime,
      attendanceEntryTime,
      attendanceDate,
      token;
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
    token = prefs.getString('token') ?? '';

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
        var response = await http.post(url,
            headers: {HttpHeaders.authorizationHeader: token}, body: input);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (responseBody['status']) {
            var responseData = responseBody['message'];

            //print(responseData);

            showToast(responseBody['message']);
            prefs.remove('attendance_id');
            prefs.remove('attendance_entry_time');
            prefs.remove('attendance_exit_time');
            prefs.remove('attendance_date');
            Navigator.popAndPushNamed(context, '/navigationPage');
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
            HeaderContainer(
              headerIcon: Icons.mode_edit,
              headerTitle: "Review",
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
                  CommentBox(
                    commentController: _commentController,
                    boxLabel: "Review details",
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SubmitButton(
                    onPressed: reviewAttendance,
                    buttonTitle: "Review",
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
