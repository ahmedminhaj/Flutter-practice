import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pageList = ['Home', 'Attendance', 'Catering', 'Leave', 'Notification', 'Reinvorsment'];
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated navbar"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _pageList[_page],
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6.1),
              ),
              RaisedButton(
                child: Text('Go Back To Home'),
                onPressed: () {
                  final CurvedNavigationBarState navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState.setPage(0);
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
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
            Icons.airplanemode_active,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.mail_outline,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.library_add,
            size: 25,
            color: Colors.white,
          )
        ],
        color: Colors.green,
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
