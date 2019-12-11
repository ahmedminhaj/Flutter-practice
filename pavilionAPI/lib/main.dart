import 'package:flutter/material.dart';
import 'package:pavilion/leaveManagement/riseOvertime.dart';
import 'package:pavilion/leaveManagement/takeLeave.dart';
import 'package:pavilion/navigation.dart';
import 'package:pavilion/profile/Profile.dart';
import 'package:pavilion/catering/catering.dart';
import 'package:pavilion/profile/editProfile.dart';
import 'package:pavilion/catering/mealOrder.dart';
import 'package:pavilion/profile/resetPassword.dart';
import 'logIn.dart';
import 'signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signUp': (BuildContext context) => SignupPage(),
        '/logIn': (BuildContext context) => LogInPage(),
        '/navigationPage': (BuildContext context) => NavigationPage(),
        '/mealOrder': (BuildContext context) => MealOrder(),
        '/catering': (BuildContext context) => Catering(),
        '/profile': (BuildContext context) => Profile(),
        '/resetPass': (BuildContext context) => ResetPassword(),
        '/editProfile': (BuildContext context) => EditProfile(),
        '/takeLeave': (BuildContext context) => TakeLeave(),
        '/riseOvertime': (BuildContext context) => RiseOvertime(),
        
      },
      home: NavigationPage(),
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

