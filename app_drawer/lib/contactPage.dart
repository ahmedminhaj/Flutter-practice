import 'package:app_drawer/drawerWidget/drawer.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String radioItem = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Radio Button"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Selecte button: "),
            
            RadioListTile(
              groupValue: radioItem,
              title: Text("Button 1"),
              value: "Item 1",
              onChanged: (val){
                setState(() {
                  radioItem = val;
                });
              },
            ),
            RadioListTile(
              groupValue: radioItem,
              title: Text("Button 2"),
              value: "Item 2",
              onChanged: (val){
                setState(() {
                  radioItem = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}