import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
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

  Future<void> deleteMeal(String id) async {
    Map input = {
      'id': id,
    };
    var url = '$base_url/catering/user_catering_order_delete';
    http.Response response = await http.post(url, body: input);
    data = json.decode(response.body);
    setState(() {
      cateringList();
    });
    print(input);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
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
                    child: Text(
                      "Catering List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 100.0),
                    child: FlatButton(
                      onPressed: cateringList,
                      child: Center(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        // Text(
                        //   'Search',
                        //   style: TextStyle(color: Colors.white, fontSize: 20),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userData == null ? 0 : userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[200],
                          Colors.grey[300],
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
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
                          child: InkWell(
                            onTap: () {
                              String id = '${userData[index]["id"]}';
                              deleteMeal(id);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Poppins',
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[700],
          onPressed: () {
            Navigator.of(context).pushNamed('/mealOrder');
          },
          child: Icon(Icons.restaurant_menu),
        ),
      ),
    );
  }
}
