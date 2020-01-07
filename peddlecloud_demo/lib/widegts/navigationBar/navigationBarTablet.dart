import 'package:flutter/material.dart';
import 'package:peddlecloud/widegts/navigationBar/navbarItem.dart';
import 'package:peddlecloud/widegts/navigationBar/navbarLogo.dart';

class NavigationBarTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem("Projects"),
              SizedBox(
                width: 60,
              ),
              NavBarItem("About"),
            ],
          )
        ],
      ),
    );
  }
}