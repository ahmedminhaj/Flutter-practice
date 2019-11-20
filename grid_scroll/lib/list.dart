import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class ListView extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  @override
  Widget build(BuildContext context) {
    final titles = [
      'bike',
      'boat',
      'bus',
      'car',
      'railway',
      'run',
      'subway',
      'transit',
      'walk',
      'time',
      'map',
      'ac unit',
      'mouse'
    ];

    final icons = [
      Icons.directions_bike,
      Icons.directions_boat,
      Icons.directions_bus,
      Icons.directions_car,
      Icons.directions_railway,
      Icons.directions_run,
      Icons.directions_subway,
      Icons.directions_transit,
      Icons.directions_walk,
      Icons.access_time,
      Icons.map,
      Icons.ac_unit,
      Icons.mouse
    ];

    return prefix0.ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(icons[index]),
              title: Text(titles[index]),
            ),
          );
        });
  }
}
