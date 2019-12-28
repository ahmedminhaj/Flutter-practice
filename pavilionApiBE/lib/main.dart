import 'package:flutter/material.dart';
import 'package:pavilion/attendance/attendance.dart';
import 'package:pavilion/attendance/attendanceReview.dart';
import 'package:pavilion/home.dart';
import 'package:pavilion/leaveManagement/leave.dart';
import 'package:pavilion/leaveManagement/leaveManagement.dart';
import 'package:pavilion/leaveManagement/overtime.dart';
import 'package:pavilion/leaveManagement/riseOvertime.dart';
import 'package:pavilion/leaveManagement/takeLeave.dart';
import 'package:pavilion/noticeMail.dart';
import 'package:pavilion/profile/Profile.dart';
import 'package:pavilion/catering/catering.dart';
import 'package:pavilion/profile/editProfile.dart';
import 'package:pavilion/catering/mealOrder.dart';
import 'package:pavilion/profile/resetPassword.dart';
import 'package:pavilion/reimbursment.dart';
import 'logIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/logIn': (BuildContext context) => LogInPage(),
        '/mealOrder': (BuildContext context) => MealOrder(),
        '/catering': (BuildContext context) => Catering(),
        '/attendance': (BuildContext context) => Attendance(),
        '/reimbursment': (BuildContext context) => Reimbursment(),
        '/home': (BuildContext context) => Home(),
        '/leaveMangement': (BuildContext context) => LeaveManagement(),
        '/notification': (BuildContext context) => NoticeMail(),
        '/profile': (BuildContext context) => Profile(),
        '/resetPass': (BuildContext context) => ResetPassword(),
        '/editProfile': (BuildContext context) => EditProfile(),
        '/takeLeave': (BuildContext context) => TakeLeave(),
        '/riseOvertime': (BuildContext context) => RiseOvertime(),
        '/reviewAttendance': (BuildContext context) => AttendanceReview(),
        '/leave': (BuildContext context) => Leave(),
        '/overtime': (BuildContext context) => Overtime(),
      },
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}
