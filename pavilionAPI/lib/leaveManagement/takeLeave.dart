import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime datetemp, startDateT, endDateT;
  List<String> dateRange;
  var dateString;
  String userID;
  Map data;
  List userData;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  String get comment => _commentController.text;
  

  Future<void> takeLeave() async {
    if (dateRange != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');

      dateString = dateRange.reduce((value, element) => value + ',' + element);
      print(dateString);

      Map input = {
        'user_id': userID,
        'date': dateString,
        'type': '1',
        'comment': comment,
      };

      try {
        var url = '$base_url/leave/user_leave_create';
        var response = await http.post(url, body: input);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          if (responseBody['status']) {
            var responseData = responseBody['message'];

            print(responseData);

            showToast(responseBody['message']);
            //Navigator.of(context).PushNamed('/catering');
            //Navigator.popAndPushNamed(context, '/catering');
          } else {
            showToast(responseBody['message']);
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
                    Icons.calendar_view_day,
                    size: 35,
                    color: Colors.white,
                  ),
                  Text(
                    "Leave Request",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
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
                      final List<DateTime> picked =
                          await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate: DateTime.now(),
                        initialLastDate:DateTime.now(),
                        firstDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(3030),
                      );
                      
                      if (picked != null) {
                        //print(picked);
                        setState(() {
                          startDateT = picked[0];
                          endDateT = picked[1];
                           
                          final dateToGenerate =
                              endDateT.difference(startDateT).inDays;
                          dateRange = List.generate(
                            dateToGenerate + 1,
                            (i) => dateFormat.format(DateTime(startDateT.year, startDateT.month,
                                startDateT.day + (i))),
                          );

                          startDate =
                              '${startDateT.year}-${startDateT.month}-${startDateT.day}';
                          endDate =
                              '${endDateT.year}-${endDateT.month}-${endDateT.day}';
                        });
                        print(picked[0]);
                        print(picked[1]);
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
                                       startDate == null && endDate == null ? 'Pick a date or date range ' :"$startDate to $endDate",
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
                          Text(
                            "Pick Date",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
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
                      labelText: 'Cause Of Leave',
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
                        onPressed: takeLeave,
                        child: Center(
                          child: Text(
                            'Leave Request',
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