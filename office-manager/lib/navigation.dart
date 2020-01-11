import 'package:flutter/material.dart';
import 'package:HajiraKhata/attendance/attendance.dart';
import 'package:HajiraKhata/catering/catering.dart';
import 'package:HajiraKhata/home.dart';
import 'package:HajiraKhata/leaveManagement/leaveManagement.dart';
import 'package:HajiraKhata/noticeMail.dart';
import 'package:HajiraKhata/reimbursment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class NavigationPage extends StatefulWidget {
  final drawerItems = [
    DrawerItem('Home', Icons.home),
    DrawerItem('Attendance', Icons.calendar_today),
    DrawerItem('Catering', Icons.restaurant_menu),
    DrawerItem('Leave Management', Icons.directions_walk),
    DrawerItem('Reimbursment', Icons.library_add),
    DrawerItem('Official Notice', Icons.notifications_active),
  ];

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return Attendance();
      case 2:
        return Catering();
      case 3:
        return LeaveManagement();
      case 4:
        return Reimbursment();
      case 5:
        return NoticeMail();
      default:
        return Text('Error');
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  String userName = '';
  String userID = '';
  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('users_username');
    setState(() {
      userID = prefs.getString('user_id');
    });
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedIndex].title),
        backgroundColor: Colors.green[700],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green[700],
                    Colors.green[200],
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(75),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("v0.01.10", style: TextStyle(color: Colors.white),),
                  Text(
                    "hajiraKhata",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "$userName",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 22,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: drawerOptions,
            ),
          ],
        ),
      ),
      body: _getDrawerItem(
        _selectedIndex,
      ),
    );
  }
}
