import 'package:app_drawer/drawerWidget/drawer.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
