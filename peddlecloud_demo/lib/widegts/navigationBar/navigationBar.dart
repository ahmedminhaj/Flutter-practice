import 'package:flutter/material.dart';
import 'package:peddlecloud/widegts/navigationBar/navigationBarMobile.dart';
import 'package:peddlecloud/widegts/navigationBar/navigationBarTablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(),
      tablet: NavigationBarTablet(),
    );
  }
}

