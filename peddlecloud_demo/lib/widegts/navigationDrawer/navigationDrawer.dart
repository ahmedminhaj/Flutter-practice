import 'package:flutter/material.dart';
import 'package:peddlecloud/widegts/navigationDrawer/drawerHeader.dart';
import 'package:peddlecloud/widegts/navigationDrawer/drawerItem.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(),
          DrawerItem("Project", Icons.pageview),
          DrawerItem("About", Icons.help),
        ],
      ),
    );
  }
}
