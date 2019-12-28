import 'package:flutter/material.dart';
import 'package:pavilion/drawerWidget/drawer.dart';
import 'leave.dart' as leave;
import 'overtime.dart' as overtime;

class LeaveManagement extends StatefulWidget {
  @override
  _LeaveManagementState createState() => _LeaveManagementState();
}

class _LeaveManagementState extends State<LeaveManagement>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
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
      appBar: 
      AppBar(
        title: Text("Leave Management"),
        bottom: TabBar(
              labelColor: Colors.green[700],
              controller: controller,
              indicatorWeight: 5.0,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.green,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Leave",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    "Overtime",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ],
            ),
      ),
      
      drawer: AppDrawer(),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          leave.Leave(),
          overtime.Overtime(),
        ],
      ),
    );
  }
}
