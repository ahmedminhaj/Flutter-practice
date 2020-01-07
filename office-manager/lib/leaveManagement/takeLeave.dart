import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pavilion/customWidget/commentBox.dart';
import 'package:pavilion/customWidget/customText.dart';
import 'package:pavilion/customWidget/dateRangeBox.dart';
import 'package:pavilion/customWidget/dialogBox.dart';
import 'package:pavilion/customWidget/headerContainer.dart';
import 'package:pavilion/customWidget/labelText.dart';
import 'package:pavilion/customWidget/submitButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class TakeLeave extends StatefulWidget {
  @override
  _TakeLeaveState createState() => _TakeLeaveState();
}

class _TakeLeaveState extends State<TakeLeave> {
  static final TextEditingController _commentController =
      TextEditingController();
  String inputDate = ' ', startDate, endDate;
  String leaveType;
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime datetemp, startDateT, endDateT;
  List<String> dateRange;
  var dateString, _date, showDate, token;
  String userID;
  Map data;
  List userData;
  bool isLoading = false;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //List leaveCategory;
  //List<int> categoryID;
  List categoryData = List();
  String selectLeaveCategory;

  String get comment => _commentController.text;

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  goBack() {
    Navigator.of(context).pop();
    isLoading = false;
  }

  getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');

    Map input = {'user_id': userID, 'type': "1"};
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

  Future<void> takeLeave() async {
    if (dateRange != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');
      token = prefs.getString('token') ?? '';

      dateString = dateRange.reduce((value, element) => value + ',' + element);
      print(dateString);

      Map input = {
        'user_id': userID,
        'date': dateString,
        'type': '1',
        'comment': comment,
        'leave_day_type': leaveType,
        'leave_category': selectLeaveCategory,
      };
      print(input);
      try {
        var url = '$base_url/leave/user_leave_create';
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
      showToast("Need a date to take leave");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderContainer(
              headerIcon: Icons.calendar_today,
              headerTitle: "Take Leave",
            ),
            Container(
              padding: EdgeInsets.only(top: 100.0, left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () async {
                      final List<DateTime> picked =
                          await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate:
                            startDateT == null ? DateTime.now() : startDateT,
                        initialLastDate:
                            endDateT == null ? DateTime.now() : endDateT,
                        //firstDate: DateTime(2000),
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(3100),
                        initialDatePickerMode:
                            DateRagePicker.DatePickerMode.day,
                      );
                      if (picked != null) {
                        print(picked);

                        if (picked.length > 1) {
                          if ((picked[0].day == picked[1].day) &&
                              (picked[0].month == picked[1].month) &&
                              (picked[0].year == picked[1].year)) {
                            _date =
                                "${picked[0].day}-${picked[0].month}-${picked[0].year}";
                            startDateT = picked[0];
                            endDateT = picked[0];
                          } else {
                            _date =
                                "${picked[0].day}-${picked[0].month}-${picked[0].year} to ${picked[1].day}-${picked[1].month}-${picked[1].year}";
                            startDateT = picked[0];
                            endDateT = picked[1];
                          }
                        } else {
                          _date =
                              "${picked[0].day}-${picked[0].month}-${picked[0].year}";
                          startDateT = picked[0];
                          endDateT = picked[0];
                        }

                        print(_date);
                        setState(() {
                          showDate = _date;

                          final dateToGenerate =
                              endDateT.difference(startDateT).inDays;
                          dateRange = List.generate(
                            dateToGenerate + 1,
                            (i) => dateFormat.format(DateTime(startDateT.year,
                                startDateT.month, startDateT.day + (i))),
                          );
                        });
                        print(dateRange);
                      }
                    },
                    child: DateRangeBox(
                      showDateRange: showDate,
                      boxLabel: " Pick a date or date range",
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 30.0,
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
                          inputText: "Leave Type:",
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              groupValue: leaveType,
                              value: '2',
                              onChanged: (val) {
                                setState(() {
                                  leaveType = val;
                                });
                              },
                            ),
                            CustomText(
                              inputText: "Half Leave",
                            ),
                            Radio(
                              groupValue: leaveType,
                              value: '1',
                              onChanged: (val) {
                                setState(() {
                                  leaveType = val;
                                });
                              },
                            ),
                            CustomText(
                              inputText: "Full Leave",
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
                              value: selectLeaveCategory,
                              onChanged: (inputValue) {
                                setState(() {
                                  selectLeaveCategory = inputValue;
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
                  SizedBox(
                    height: 20.0,
                  ),
                  CommentBox(
                    commentController: _commentController,
                    boxLabel: "Cause Of Leave",
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SubmitButton(
                    onPressed: () {
                      // setState(() {
                      //   isLoading = true;
                      // });
                      showCustomDialog(context, takeLeave, showDate, goBack);
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
      popUpText: "Leave request for $dateRange",
      confirmAction: () {
        onPressed();
      },
      backAction: () {
        back();
      },
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => simpleDialog);
}
