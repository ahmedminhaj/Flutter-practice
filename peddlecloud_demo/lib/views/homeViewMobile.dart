import 'package:flutter/material.dart';
import 'package:peddlecloud/widegts/actionButton/contactButton.dart';
import 'package:peddlecloud/widegts/siteDetais/siteDetails.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SiteDetails(),
        SizedBox(
          height: 100,
        ),
        ContactButton("Contact Us"),
      ],
    );
  }
}