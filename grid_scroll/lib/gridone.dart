import 'package:flutter/material.dart';

class GridOne extends StatefulWidget {
  @override
  _GridOneState createState() => _GridOneState();
}

class _GridOneState extends State<GridOne> {
  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.directions_bike,
      Icons.directions_boat,
      Icons.directions_bus,
      Icons.directions_car,
      Icons.directions_railway,
      Icons.directions_run,
      Icons.directions_subway,
      Icons.directions_transit,
      Icons.featured_video,
      Icons.school,
      Icons.score,
      Icons.directions_walk,
      Icons.access_time,
      Icons.map,
      Icons.ac_unit,
      Icons.mouse,
      Icons.account_box,
      Icons.markunread_mailbox,
      Icons.keyboard,
      Icons.games
    ];

    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(20, (index) {
          return Card(
            elevation: 10.0,
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  icons[index],
                  color: Colors.deepPurple[500],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
