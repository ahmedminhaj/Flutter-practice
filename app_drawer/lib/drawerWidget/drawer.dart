import 'package:app_drawer/drawerWidget/drawerHeader.dart';
import 'package:app_drawer/drawerWidget/drawerItem.dart';
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
              Navigator.of(context).pushNamed('/home');
            },
          ),
          DrawerItem(
            icon: Icons.input,
            text: "Counter",
            onTap: () {
              Navigator.of(context).pushNamed('/counter');
            },
          ),
          DrawerItem(
            icon: Icons.contacts,
            text: "Contact",
            onTap: () {
              Navigator.of(context).pushNamed('/contact');
            },
          ),
        ],
      ),
    );
  }
}
