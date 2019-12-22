import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pavilion/customWidget/commentBox.dart';
import 'package:pavilion/customWidget/dateRangeBox.dart';
import 'package:pavilion/customWidget/headerContainer.dart';
import 'package:pavilion/customWidget/loadingPage.dart';
import 'package:pavilion/customWidget/submitButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import 'package:intl/intl.dart';

class MealOrder extends StatefulWidget {
  @override
  _MealOrderState createState() => _MealOrderState();
}

class _MealOrderState extends State<MealOrder> {
  static final TextEditingController _commentController =
      TextEditingController();
  String inputDate = ' ', startDate, endDate;
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime datetemp, startDateT, endDateT;
  List<String> dateRange;
  var dateString, _date, showDate;
  String userID, token;
  Map data;
  List userData;
  bool isLoading = false;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  String get comment => _commentController.text;

  Future<void> mealOrder() async {
    if (dateRange != null) {
      dateString = dateRange.reduce((value, element) => value + ',' + element);
      //print(dateString);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');
      token = prefs.getString('token') ?? '';

      Map input = {
        'user_id': userID,
        'date': dateString,
        'comment': comment,
      };

      try {
        var url = '$base_url/catering/user_catering_order_create';
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
      showToast("Need a date to order meal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? LoadingPage() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderContainer(
              headerIcon: Icons.restaurant_menu,
              headerTitle: "Meal Order",
            ),
            Container(
              padding: EdgeInsets.only(top: 100.0, left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 4.0,
                    onPressed: () async {
                      //var _date;
                      final List<DateTime> picked =
                          await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate:
                            startDateT == null ? DateTime.now() : startDateT,
                        initialLastDate:
                            endDateT == null ? DateTime.now() : endDateT,
                        /*firstDate: DateTime(2000),*/
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(3100),
                        // initialDatePickerMode:
                        // DateRagePicker.DatePickerMode.day,
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
                          // startDateT = picked[0];
                          // endDateT = picked[1] == null ? picked[0] : picked[1];

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
                    child: 
                    DateRangeBox(
                      showDateRange: showDate,
                      boxLabel: " Pick a date or date range",
                    ),
                    
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CommentBox(
                    commentController: _commentController,
                    boxLabel: "Any specification",
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SubmitButton(
                    onPressed: (){
                      setState(() {
                        isLoading = true;
                      });
                      mealOrder();
                    },
                    buttonTitle: "Order Now",
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
