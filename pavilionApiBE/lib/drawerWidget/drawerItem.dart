import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final onTap;

  DrawerItem({
    this.icon,
    this.onTap,
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.1),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}