import 'logIn.dart';
import 'package:flutter/material.dart';
import 'package:pavilion/homepage.dart';
import 'signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      routes: <String, WidgetBuilder>{
        '/signUp': (BuildContext context) => SignupPage(),
        '/logIn': (BuildContext context) => LogInPage(),
        '/homePage': (BuildContext context) => HomePage(),
      },
      home: LogInPage(),
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

