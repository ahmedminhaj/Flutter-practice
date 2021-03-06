import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:HajiraKhata/customWidget/commentBox.dart';
import 'package:HajiraKhata/customWidget/customText.dart';
import 'package:HajiraKhata/customWidget/dateRangeBox.dart';
import 'package:HajiraKhata/customWidget/dialogBox.dart';
import 'package:HajiraKhata/customWidget/headerContainer.dart';
import 'package:HajiraKhata/customWidget/labelText.dart';
import 'package:HajiraKhata/customWidget/submitButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:HajiraKhata/api/global.dart';
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
  String overtimeType;
  String selectOvertimeCategory;
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime datetemp;
  String userID;
  Map data;
  List userData;
  List categoryData = List();
  var token;
  bool isLoading = false;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  String get comment => _commentController.text;

   @override
  void initState() {
    getCategory();
    super.initState();
  }

  goBack(){
    isLoading = false;
    Navigator.of(context).pop();
  }

  getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');

    Map input = {'user_id': userID, 'type': "2"};
    try {
      var url = '$base_url/leave/leave_category';

      var response = await http.post(url, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          var responseData = responseBody['data'];
          print(responseData);
          // print(responseData.length);
          
          setState(() {
            categoryData = responseData;
          });
        } else {
          print(responseBody['status']);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

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
        'leave_day_type': overtimeType,
        'leave_category': selectOvertimeCategory,
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
                          inputDate = '${date.day}-${date.month}-${date.year}';
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        LabelText(
                          inputText: "Select Overtime Type:",
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              groupValue: overtimeType,
                              value: '2',
                              onChanged: (val) {
                                setState(() {
                                  overtimeType = val;
                                });
                              },
                            ),
                            CustomText(
                              inputText: "Half Day",
                            ),
                            Radio(
                              groupValue: overtimeType,
                              value: '1',
                              onChanged: (val) {
                                setState(() {
                                  overtimeType = val;
                                });
                              },
                            ),
                            CustomText(
                              inputText: "Full Day",
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            LabelText(
                              inputText: "Category:",
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            DropdownButton(
                              hint: CustomText(
                                inputText: "Select Category",
                              ),
                              value: selectOvertimeCategory,
                              onChanged: (inputValue) {
                                setState(() {
                                  selectOvertimeCategory = inputValue;
                                });
                              },
                              items: categoryData.map((category) {
                                return DropdownMenuItem(
                                  child: CustomText(
                                    inputText: category['category_name'],
                                  ),
                                  value: category['id'].toString(),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  CommentBox(
                    commentController: _commentController,
                    boxLabel: "Overtime Details",
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SubmitButton(
                    onPressed: () {
                      // setState(() {
                      //   isLoading = true;
                      // });
                      showCustomDialog(context, riseOvertime, inputDate, goBack);
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

void showCustomDialog(
    BuildContext context, Function onPressed, String dateRange, Function back) {
  Dialog simpleDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: DialogBox(
      popUpText: "Overtime request for $dateRange",
      confirmAction: (){
        onPressed();
      },
      backAction: (){
        back();
      },
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => simpleDialog);
}
