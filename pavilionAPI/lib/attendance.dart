import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String userID = "";
  Map data;
  List userData;
  var attendanceId;

  @override
  void initState() {
    super.initState();
    attendanceList();
  }

  Future<void> attendanceList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    Map input = {
      'user_id': userID,
    };
    var url = '$base_url/user/user_timing_list';
    http.Response response = await http.post(url, body: input);
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    //debugPrint(userData.toString());
    print(data);
  }

  attendanceReview(var attendanceID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('attendance_id', attendanceID['id']);
      prefs.setString('attendance_entry_time', attendanceID['entry_time']);
      prefs.setString('attendance_exit_time', attendanceID['exit_time']);
      prefs.setString('attendance_date', attendanceID['date']);
    });
    Navigator.of(context).pushNamed('/reviewAttendance');

    // String aET = prefs.getString('attendance_entry_time');
    // print(attendanceID);
    // print(aET);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 0.0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[200],
                  Colors.grey[300],
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${userData[index]["date"]}",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Entry: ${userData[index]["entry_time"]}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 17.9,
                      ),
                      Text(
                        "Exit: ${userData[index]["exit_time"]}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                userData[index]["status"] == null
                    ? Container(
                        height: 30,
                        width: 100,
                        child: Material(
                          borderRadius: BorderRadius.circular(5.0),
                          shadowColor: Colors.green,
                          color: Colors.green[600],
                          elevation: 7.0,
                          child: FlatButton(
                            onPressed: () {
                              attendanceId = userData[index];
                              attendanceReview(attendanceId);
                              //print(attendanceId);
                            },
                            child: Center(
                              child: Text(
                                'Review',
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
                    : Container(
                        child: Text(
                          userData[index]["status"] == '0'
                              ? "Pending"
                              : userData[index]["status"] == '1'
                                  ? "Accepted"
                                  : "Rejected",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins'),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
