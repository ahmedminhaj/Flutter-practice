import 'package:app_drawer/contactPage.dart';
import 'package:app_drawer/counterPage.dart';
import 'package:app_drawer/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/counter': (BuildContext context) => CounterPage(),
        '/home': (BuildContext context) => MyHomePage(),
        '/contact': (BuildContext context) => ContactPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}
