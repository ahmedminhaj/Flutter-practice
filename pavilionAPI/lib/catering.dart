import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'global.dart';
import 'dart:convert';

class Catering extends StatefulWidget {
  @override
  _CateringState createState() => _CateringState();
}

class _CateringState extends State<Catering> {
  String userID = "";
  Map data;
  List userData;

  @override
  void initState() {
    super.initState();
    cateringList();
  }

  Future<void> cateringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    Map input = {
      'user_id': userID,
    };
    var url = '$base_url/catering/user_catering_list';
    http.Response response = await http.post(url, body: input);
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    debugPrint(userData.toString());
    debugPrint(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green[100],
                    Colors.green[300],
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    " ${userData[index]["date"]}",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${userData[index]["day"]}",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.redAccent[400],
                      color: Colors.red[400],
                      elevation: 7.0,
                      child: FlatButton(
                        onPressed: () {},
                        child: Center(
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.restaurant_menu),
      ),
    );
  }
}
