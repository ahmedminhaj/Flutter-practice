import 'package:flutter/material.dart';
import 'homepage.dart';
import 'catering.dart';
import 'leave.dart';
import 'attendance.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  final _pageOption = [
    HomePage(),
    Catering(),
    Leave(),
    Attendance(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom navigation bar"),
        
      ),
      body: _pageOption[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.green,),
            title: Text('Home', style: TextStyle(color: Colors.green),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.green,),
            title: Text('Attendance', style: TextStyle(color: Colors.green),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu, color: Colors.green,),
            title: Text('Catering', style: TextStyle(color: Colors.green),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk, color: Colors.green,),
            title: Text('Leave', style: TextStyle(color: Colors.green),),
          ),
        ],
      ),
    );
  }
}
