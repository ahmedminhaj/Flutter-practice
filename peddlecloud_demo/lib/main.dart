import 'package:flutter/material.dart';
import 'package:peddlecloud/views/homeView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peddlecloud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'OpenSans',
            ),
      ),
      home: HomeView(),
    );
  }
}