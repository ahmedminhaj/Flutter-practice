import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pavilion/customWidget/commentBox.dart';
import 'package:pavilion/customWidget/dateRangeBox.dart';
import 'package:pavilion/customWidget/headerContainer.dart';
import 'package:pavilion/customWidget/submitButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class RiseOvertime extends StatefulWidget {
  @override
  _RiseOvertimeState createState() => _RiseOvertimeState();
}

class _RiseOvertimeState extends State<RiseOvertime> {
  static final TextEditingController _commentController =
      TextEditingController();
  String inputDate;
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime datetemp;
  String userID;
  Map data;
  List userData;
  var token;
  bool isLoading = false;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  String get comment => _commentController.text;

  Future<void> riseOvertime() async {
    if (inputDate != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');
      token = prefs.getString('token') ?? '';

      Map input = {
        'user_id': userID,
        'type': "2",
        'date': inputDate,
        'comment': comment,
      };

      try {
        var url = '$base_url/leave/user_overtime_create';
        var response = await http.post(url,
            headers: {HttpHeaders.authorizationHeader: token}, body: input);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (responseBody['status']) {
            var responseData = responseBody['message'];

            print(responseData);

            showToast(responseBody['message']);
            //Navigator.of(context).PushNamed('/catering');
            isLoading = false;
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
      print(input);
    } else {
      showToast("Need a date to rise overtime");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderContainer(
              headerIcon: Icons.calendar_view_day,
              headerTitle: "Overtime Rise",
            ),
            Container(
              padding: EdgeInsets.only(top: 100.0, left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: datetemp == null ? currentDate : datetemp,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                      ).then((date) {
                        setState(() {
                          datetemp = date;
                          inputDate = '${date.year}-${date.month}-${date.day}';
                        });
                      });
                    },
                    child: DateRangeBox(
                      showDateRange: inputDate,
                      boxLabel: " Pick a Date",
                    ),
                    
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CommentBox(
                    commentController: _commentController,
                    boxLabel: "Overtime Details",
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SubmitButton(
                    onPressed: (){
                      setState(() {
                        isLoading = true;
                      });
                      riseOvertime();
                    },
                    buttonTitle: "Submit",
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
