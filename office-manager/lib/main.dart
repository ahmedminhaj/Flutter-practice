import 'package:flutter/material.dart';
import 'package:HajiraKhata/attendance/attendanceReview.dart';
import 'package:HajiraKhata/leaveManagement/riseOvertime.dart';
import 'package:HajiraKhata/leaveManagement/takeLeave.dart';
import 'package:HajiraKhata/navigation.dart';
import 'package:HajiraKhata/passRecovery.dart';
import 'package:HajiraKhata/profile/Profile.dart';
import 'package:HajiraKhata/catering/catering.dart';
import 'package:HajiraKhata/profile/editProfile.dart';
import 'package:HajiraKhata/catering/mealOrder.dart';
import 'package:HajiraKhata/profile/resetPassword.dart';
import 'logIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/recoveryPass': (BuildContext context) => RecoveryPass(),
        '/logIn': (BuildContext context) => LogInPage(),
        '/navigationPage': (BuildContext context) => NavigationPage(),
        '/mealOrder': (BuildContext context) => MealOrder(),
        '/catering': (BuildContext context) => Catering(),
        '/profile': (BuildContext context) => Profile(),
        '/resetPass': (BuildContext context) => ResetPassword(),
        '/editProfile': (BuildContext context) => EditProfile(),
        '/takeLeave': (BuildContext context) => TakeLeave(),
        '/riseOvertime': (BuildContext context) => RiseOvertime(),
        '/reviewAttendance': (BuildContext context) => AttendanceReview(),
        
      },
      home: NavigationPage(),
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

