import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/customText.dart';
import 'package:pavilion/customWidget/loadingPage.dart';
import 'package:pavilion/customWidget/secondaryHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class Leave extends StatefulWidget {
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  TextEditingController editingController = TextEditingController();
  String userID = "";
  Map data;
  List userData;
  var token;
  bool isLoading = true;
  List categoryData = List();
  String selectLeaveCategory;

  @override
  void initState() {
    super.initState();
    // getCategory();
    leaveList();
  }

  // getCategory() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userID = prefs.getString('user_id');

  //   Map input = {'user_id': userID, 'type': "1"};
  //   try {
  //     var url = '$base_url/leave/leave_category';

  //     var response = await http.post(url, body: input);
  //     if (response.statusCode == 200) {
  //       var responseBody = jsonDecode(response.body);

  //       if (responseBody['status']) {
  //         var responseData = responseBody['data'];
  //         print(responseData);
  //         // print(responseData.length);

  //         setState(() {
  //           categoryData = responseData;
  //         });
  //       } else {
  //         print(responseBody['status']);
  //       }
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> leaveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    token = prefs.getString('token') ?? '';
    Map input = {
      'user_id': userID,
      'type': '1',
    };

    try {
      var url = '$base_url/leave/user_leave_list';
      http.Response response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          //print(responseBody);
          data = json.decode(response.body);
          setState(() {
            userData = data["data"];
            isLoading = false;
          });
        } else {
          //print('status false');
          //print(responseBody);

          if (responseBody['message'] == tokenDatabaseCheck ||
              responseBody['message'] == tokenTimeCheck) {
            showToast(responseBody['message']);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/logIn', (Route<dynamic> route) => false);
          } else {
            setState(() {
              isLoading = false;
            });
            showToast(responseBody['message']);
          }
        }
      } else {
        print('Error in status code');

        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // void filterSearchResult(String query) {
  //   print(query);

  //   if (query.isNotEmpty) {
  //     List dummyList;
  //     for (int i = 0; i < userData.length; i++) {
  //       if (userData[i]
  //           .category_name
  //           .toLowerCase()
  //           .contains(query.toLowerCase())) {
  //         dummyList.add(userData[i]);
  //       }
  //     }
  //     print(dummyList);
  //     print(userData);
  //     userData = dummyList;
  //   } else {
  //     setState(() {
  //       userData.clear();
  //       userData.addAll(userData);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SecondaryHeader(
              headerName: "Leave List",
              onPressed: leaveList,
            ),
            //  TextField(
            //   onChanged: (value) {
            //     filterSearchResult(value);
            //   },
            //   controller: editingController,
            //   decoration: InputDecoration(
            //     labelText: "Search",
            //     hintText: "Search",
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(25.0)),
            //     ),
            //   ),
            // ),

            Expanded(
              child: isLoading
                  ? LoadingPage()
                  : ListView.builder(
                      itemCount: userData == null ? 0 : userData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 0.0),
                          
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: userData[index]["is_approved"] ==
                                      'Approved'
                                  ? [
                                      Colors.green[200],
                                      Colors.green[300],
                                    ]
                                  : userData[index]["is_approved"] == 'Rejected'
                                      ? [
                                          Colors.red[100],
                                          Colors.red[200],
                                        ]
                                      : [
                                          Colors.grey[200],
                                          Colors.grey[300],
                                        ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: ListTile(
                            title: CustomText(
                              inputText: " ${userData[index]["date"]}",
                              textColor: Colors.black,
                            ),
                            subtitle: CustomText(
                              inputText: " ${userData[index]["category_name"]}",
                              textColor: Colors.black,
                            ),
                            trailing: CustomText(
                              inputText: " ${userData[index]["is_approved"]}",
                              textColor: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: () {
          Navigator.of(context).pushNamed('/takeLeave');
        },
        child: Icon(Icons.add_box),
      ),
    );
  }
}
