import 'package:flutter/material.dart';
import 'package:pavilion/profile/Profile.dart';
import 'package:pavilion/catering/catering.dart';
import 'package:pavilion/profile/editProfile.dart';
import 'package:pavilion/homepage.dart';
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
        '/logIn': (BuildContext context) => MyHomePage(),
        '/homePage': (BuildContext context) => HomePage(),
        '/mealOrder': (BuildContext context) => MealOrder(),
        '/catering': (BuildContext context) => Catering(),
        '/profile': (BuildContext context) => Profile(),
        '/resetPass': (BuildContext context) => ResetPassword(),
        '/editProfile': (BuildContext context) => EditProfile(),
        
      },
      home: MyHomePage(),
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

