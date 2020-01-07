import 'package:flutter/material.dart';
import 'package:peddlecloud/widegts/actionButton/contactButtonMobile.dart';
import 'package:peddlecloud/widegts/actionButton/contactButtonTablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactButton extends StatelessWidget {
  final String title;
  ContactButton(this.title);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ContactButtonMobile(title),
      tablet: ContactButtonTablet(title),
    );
  }
}
