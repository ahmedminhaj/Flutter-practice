import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Test App',
    home: GridviewPage(),
  ));
}

class GridviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GridView',
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            color: Colors.amber,
            child: Center(
              child: Text(
                'A',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Container(
            color: Colors.lightGreenAccent,
            child: Center(
              child: Text(
                'B',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Container(
            color: Colors.redAccent[200],
            child: Center(
              child: Text(
                'C',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Container(
            color: Colors.teal[300],
            child: Center(
              child: Text(
                'D',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
