import 'package:flutter/material.dart';

class DateRangeBox extends StatelessWidget {
  final String boxLabel;
  final showDateRange;

  DateRangeBox({
    this.boxLabel,
    this.showDateRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      size: 18.0,
                      color: Colors.green[700],
                    ),
                    Text(
                      showDateRange == null ? boxLabel : showDateRange,
                      style: TextStyle(
                          color: Colors.green[700],
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
