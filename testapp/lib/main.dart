import 'package:flutter/material.dart';

void main(){
  runApp( MaterialApp(
    title: 'Test App',
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:  AppBar(title:  Text('Home')),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
              padding: EdgeInsets.all(15.0),
              height: 100,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text('Build and runnig 1st flutter test app on a real device without any error',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40.0, top: 10.0, right: 40.0),
              padding: EdgeInsets.all(15.0),
              height: 100,
              width: 330,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text('Adding container, colums, row and attached icon in row container',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 20),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 45.0, top: 20.0),
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(Icons.android),
                  ),
                Container(
                  margin: EdgeInsets.only(left: 40.0, top: 20.0),
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(Icons.radio),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.0, top: 20.0),
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(Icons.touch_app),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0),
                  padding: EdgeInsets.all(10.0),
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(Icons.access_alarm),
                )
                ],
            )
          ],
        )

    );

  }
}
