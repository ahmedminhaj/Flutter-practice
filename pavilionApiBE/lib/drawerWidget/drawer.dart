import 'package:pavilion/drawerWidget/drawerHeader.dart';
import 'package:pavilion/drawerWidget/drawerItem.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          AppDrawerHeader(),
          DrawerItem(
            icon: Icons.home,
            text: "Home",
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   '/home', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamed('/home');
            },
          ),
          DrawerItem(
            icon: Icons.calendar_today,
            text: "Attendance",
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/attendance', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamed('/attendance');
            },
          ),
          DrawerItem(
            icon: Icons.restaurant_menu,
            text: "Catering",
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/catering', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamed('/catering');
            },
          ),
          DrawerItem(
            icon: Icons.directions_walk,
            text: "Leave Management",
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/leaveMangement', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamed('/leaveMangement');
            },
          ),
          DrawerItem(
            icon: Icons.library_add,
            text: "Reimbursment",
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/reimbursment', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamed('/reimbursment');
            },
          ),
          DrawerItem(
            icon: Icons.notifications_active,
            text: "Notification",
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/notification', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamed('/notification');
            },
          ),
        ],
      ),
    );
  }
}
