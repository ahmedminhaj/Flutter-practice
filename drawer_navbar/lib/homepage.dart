import 'package:drawer_navbar/attendance.dart';
import 'package:drawer_navbar/catering.dart';
import 'package:drawer_navbar/home.dart';
import 'package:drawer_navbar/leave.dart';
import 'package:drawer_navbar/notification_mail.dart';
import 'package:drawer_navbar/reimbursment.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    DrawerItem('Home', Icons.home),
    DrawerItem('Attendance', Icons.calendar_today),
    DrawerItem('Catering', Icons.restaurant_menu),
    DrawerItem('Leave Management', Icons.directions_walk),
    DrawerItem('Reinbursment', Icons.library_add),
    DrawerItem('Notification', Icons.notifications_active),
  ];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  //GlobalKey _bottomNavigationKey = GlobalKey();

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return Attendance();
      case 2:
        return Catering();
      case 3:
        return Leave();
      case 4:
        return Reimbursment();
      case 5:
        return NotificationMail();
      default:
        return Text('Error');
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          selected: i == _selectedIndex,
          onTap: () => _onSelectItem(i),
        ),
      );
    }
    int _nav;
    if (_selectedIndex < 4) {
      _nav = _selectedIndex;
    } else {
      _nav = 0;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedIndex].title),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        //key: _bottomNavigationKey,

        index: _nav,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.calendar_today,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.restaurant_menu,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.directions_walk,
            size: 25,
            color: Colors.white,
          ),
        ],
        color: Colors.green,
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 500),
        onTap: (i) {
          setState(() {
            _nav = i;
            _selectedIndex = i;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                "teamPavilion",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 32,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: _getDrawerItem(
        _selectedIndex,
      ),
    );
  }
}
