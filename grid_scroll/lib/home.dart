import 'package:flutter/material.dart';
import 'gridone.dart' as gridone;
import 'gridtwo.dart' as gridtwo;
import 'list.dart' as flist;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: controller,
          indicatorWeight: 5.0,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Color(0xFFFFFFFF),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.grid_on),
            ),
            Tab(
              icon: Icon(Icons.image),
            ),
            Tab(
              icon: Icon(Icons.list),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          gridone.GridOne(),
          gridtwo.GridTwo(),
          flist.ListView(),
        ],
      ),
    );
  }
}
