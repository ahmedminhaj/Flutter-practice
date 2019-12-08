import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/editProfileCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String userID = "";
  var body, data;
  var responseData;
  var userData;
  String email,
      name,
      personalEmail,
      address,
      contactNumber,
      joinDate,
      nid,
      bloodGroup,
      designation,
      emergencyContact,
      bankAccount,
      department;

  @override
  void initState() {
    profileInfo();
    super.initState();
  }

  Future<void> profileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    Map input = {
      'user_id': userID,
    };
    var url = '$base_url/user/user_profile';
    http.Response response = await http.post(url, body: input);
    data = jsonDecode(response.body);
    userData = data['data'];
    setState(() {
      email = userData['email'];
      name = userData['name'];
      personalEmail = userData['personal_email'];
      address = userData['permanent_address'];
      contactNumber = userData['contact_no'];
      
      nid = userData['nid'];
      bloodGroup = userData['blood_group'];
      designation = userData['designation'];
      emergencyContact = userData['emergency_contact'];
      bankAccount = userData['bank_account_no'];
      department = userData['department_name'];
    });
    // print(email);
    // print(contactNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green[700],
                              Colors.green[200],
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(300),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.green[300],
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "$name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "$designation",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 5.5,
                            ),
                            Text(
                              "$department",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 105, 0, 0),
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10.0, 10.0)),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/image/avater.jpg'),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 9.0,
                            color: Colors.blue[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  EditProfileCard(
                    keyName: 'Name',
                    oldValue: "${userData['name']}",
                  ),
                  EditProfileCard(
                    keyName: 'Email',
                    oldValue: email,
                  ),
                  EditProfileCard(
                    keyName: 'Contact Number',
                    oldValue: contactNumber,
                  ),
                  EditProfileCard(
                    keyName: 'Address',
                    oldValue: address,
                  ),
                  EditProfileCard(
                    keyName: 'NID',
                    oldValue: nid,
                  ),
                  EditProfileCard(
                    keyName: 'Blood Group',
                    oldValue: bloodGroup,
                  ),
                  EditProfileCard(
                    keyName: 'Emerency Contact Number',
                    oldValue: emergencyContact,
                  ),
                  EditProfileCard(
                    keyName: 'Bank Account Number',
                    oldValue: bankAccount,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 40.0,
                width: 120.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.greenAccent,
                  color: Colors.green,
                  elevation: 7.0,
                  child: FlatButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Save Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
