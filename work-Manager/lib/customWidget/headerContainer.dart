import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  final String headerTitle;
  final headerIcon;

  HeaderContainer({
    this.headerIcon,
    this.headerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Colors.green[700],
            Colors.green[200],
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 35,
              color: Colors.white,
            ),
          ),
          Icon(
            headerIcon,
            size: 35,
            color: Colors.white,
          ),
          Text(
            headerTitle,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Colors.white,
                letterSpacing: 2.1),
          ),
        ],
      ),
    );
  }
}
