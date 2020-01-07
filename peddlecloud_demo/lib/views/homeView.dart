import 'package:flutter/material.dart';
import 'package:peddlecloud/views/homeViewDestop.dart';
import 'package:peddlecloud/views/homeViewMobile.dart';
import 'package:peddlecloud/widegts/centeredView/centeredView.dart';
import 'package:peddlecloud/widegts/navigationBar/navigationBar.dart';
import 'package:peddlecloud/widegts/navigationDrawer/navigationDrawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.Mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              NavigationBar(),
              Expanded(
                child: ScreenTypeLayout(
                  mobile: HomeViewMobile(),
                  desktop: HomeViewDestop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
