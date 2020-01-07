import 'package:flutter/material.dart';
import 'package:peddlecloud/widegts/actionButton/contactButton.dart';
import 'package:peddlecloud/widegts/siteDetais/siteDetails.dart';

class HomeViewDestop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SiteDetails(),
        Expanded(
          child: Center(
            child: ContactButton("Contact Us"),
          ),
        )
      ],
    );
  }
}
