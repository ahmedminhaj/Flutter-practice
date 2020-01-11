import 'package:flutter/material.dart';
import 'package:HajiraKhata/customWidget/customText.dart';

class SecondaryHeader extends StatelessWidget {
  final String headerName;
  final onPressed;

  SecondaryHeader({
    this.headerName,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Colors.green[700],
            Colors.green[400],
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: CustomText(
              inputText: headerName,
              textColor: Colors.white,
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 50.0),
          //   child: FlatButton(
          //     onPressed: () {},
          //     child: Center(
          //       child: Icon(
          //         Icons.search,
          //         color: Colors.white,
          //       ),
          //       // Text(
          //       //   'Search',
          //       //   style: TextStyle(color: Colors.white, fontSize: 20),
          //       // ),
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 50.0),
            child: FlatButton(
              onPressed: onPressed,
              child: Center(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
