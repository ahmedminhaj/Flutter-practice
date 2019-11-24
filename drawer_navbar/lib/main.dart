import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Nav';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 6.1),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'team Pavilion',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Attendance'),
              leading: Icon(Icons.calendar_today),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Catering'),
              leading: Icon(Icons.restaurant_menu),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Leave management'),
              leading: Icon(Icons.directions_walk),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Reimbursment'),
              leading: Icon(Icons.library_add),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Notification'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
