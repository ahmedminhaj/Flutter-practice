import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Test App',
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 1.0, top: 1.0, right: 1.0),
            padding: EdgeInsets.all(10.0),
            height: 200,
            width: 400,
            child: Image.asset('assets/mountain.jpg', fit: BoxFit.cover),
          ),
          Container(
            margin: EdgeInsets.only(left: 1.0, top: 1.0, right: 1.0),
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Kangchenjunga',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0, top: 0.0, right: 5.0),
            padding: EdgeInsets.all(10.0),
            height: 150,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              '"Somewhere between the bottom of the climb and the summit is the answer to the mystery why we climb. Never measure the height of a mountain until you reach the top. Then you will see how low it was."',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.green[500]),
                    Icon(Icons.star, color: Colors.green[500]),
                    Icon(Icons.star, color: Colors.green[500]),
                    Icon(Icons.star, color: Colors.green[500]),
                    Icon(Icons.star, color: Colors.black),
                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  '120+ review',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.green[500]),
                    Text('Location'),
                    Text('Nepal'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.landscape, color: Colors.green[500]),
                    Text('Tracking'),
                    Text('6hr+'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.train, color: Colors.green[500]),
                    Text('Travel Time'),
                    Text('3days'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
