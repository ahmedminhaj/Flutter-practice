import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SiteDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var textAlignment =
            sizingInformation.deviceScreenType == DeviceScreenType.Desktop
                ? TextAlign.left
                : TextAlign.center;
        double titleSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 50
                : 80;
        double descriptionSize =
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile
                ? 16
                : 20;

        return Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "FOR A BETTER FUTURE",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    height: 0.83,
                    fontSize: titleSize,
                    fontFamily: 'OpenSans-Bold'),
                textAlign: textAlignment,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "We work hard to build a better future for our next generation & wants to provide you safe and easy lifestyle. ",
                style: TextStyle(
                  fontSize: descriptionSize,
                  height: 1.5,
                ),
                textAlign: textAlignment,
              )
            ],
          ),
        );
      },
    );
  }
}
