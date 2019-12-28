import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
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
            "Drawer Menu",
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
            "Drawer Item",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
