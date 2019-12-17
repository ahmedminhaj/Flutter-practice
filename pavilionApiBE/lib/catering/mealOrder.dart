import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
            //Navigator.popAndPushNamed(context, '/catering');
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.restaurant_menu,
                    size: 35,
                    color: Colors.white,
                  ),
                  Text(
                    "Order Meal",
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
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
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
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.green[700],
                                    ),
                                    Text(
                                      showDate == null
                                          ? ' Pick a date or date range'
                                          : " $showDate",
                                      //startDate == null && endDate == null ? 'Pick a date or date range ' :"$startDate to $endDate",
                                      style: TextStyle(
                                          color: Colors.green[700],
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _commentController,
                    //onChanged: (v) => _commentController.text = v,
                    decoration: InputDecoration(
                      labelText: 'Comment',
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
                        onPressed: mealOrder,
                        child: Center(
                          child: Text(
                            'Order Now',
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
