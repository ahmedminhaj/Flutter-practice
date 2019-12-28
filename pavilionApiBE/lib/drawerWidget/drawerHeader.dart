import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawerHeader extends StatefulWidget {
  @override
  _AppDrawerHeaderState createState() => _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader> {
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
    return DrawerHeader(
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
          Text(
            "teamPavilion",
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
    );
  }
}
