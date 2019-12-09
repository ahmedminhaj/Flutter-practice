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
  List<String> bloodGroupList = [
    'A+',
    'A-',
    'O+',
    'O-',
    'B+',
    'B-',
    'AB+',
    'AB-'
  ];
  String selectBloodGroup;

  String email = "";
  String name = '';
  String personalEmail = "";
  String address = "";
  String contactNumber = "";
  String joinDate = "";
  String nid = "";
  String bloodGroup = "";
  String designation = "";
  String emergencyContact = "";
  String bankAccount = "";
  String department = "";
  String relation = "";

  String userEmail = "";
  String userName = '';
  String userPersonalEmail = "";
  String userAddress = "";
  String userContactNumber = "";
  String userJoinDate = "";
  String userNid = "";
  String userBloodGroup = "";
  String userDesignation = "";
  String useremergencyContact = "";
  String userBankAccount = "";
  String userDepartment = "";
  String userRelation = "";

  Future<bool> getUserProfileSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('user_full_name') ?? '';
    address = prefs.getString('user_permanent_address') ?? '';
    contactNumber = prefs.getString('user_contact_no') ?? '';
    nid = prefs.getString('user_nid') ?? '';
    bloodGroup = prefs.getString('user_blood_group') ?? '';
    designation = prefs.getString('user_designation') ?? '';
    emergencyContact = prefs.getString('user_emergency_contact') ?? '';
    bankAccount = prefs.getString('user_bank_account_no') ?? '';
    department = prefs.getString('user_department_name') ?? '';
    relation = prefs.getString('user_relation_with_emergency_contact') ?? '';
    return true;
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('user_id');
      Map inputPass = {
        'user_id': userID,
        'contact': userContactNumber,
        'nid': userNid,
        'blood_group': selectBloodGroup == null ? bloodGroup : selectBloodGroup,
        'emergency_contact': useremergencyContact,
        'relation': userRelation,
        //'bank_account_no': userBankAccount,
        'address': userAddress,
      };

      try {
        var url = '$base_url/user/user_edit_profile';
        http.Response response = await http.post(url, body: inputPass);

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody['status']) {
            showToast(responseBody['message']);
            Navigator.of(context).pushNamed('/navigationPage');
          } else {
            showToast(responseBody['message']);
            print(responseBody);
          }
        } else {
          print('Error in status code');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Edit Profile"),
      ),
      body: FutureBuilder(
        future: getUserProfileSP(),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
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
                                      '$name',
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
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(10.0, 10.0)),
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
                          keyName: 'Phone Number',
                          oldValue: contactNumber,
                          onSave: (input) => userContactNumber = input,
                        ),
                        EditProfileCard(
                          keyName: 'National ID',
                          oldValue: nid,
                          onSave: (input) => userNid = input,
                        ),
                        EditProfileCard(
                          keyName: 'Address',
                          oldValue: address,
                          onSave: (input) => userAddress = input,
                        ),

                        EditProfileCard(
                          keyName: 'Emergency Contact Number',
                          oldValue: emergencyContact,
                          onSave: (input) => useremergencyContact = input,
                        ),
                        EditProfileCard(
                          keyName: 'Relation with emergency number',
                          oldValue: relation,
                          onSave: (input) => userRelation = input,
                        ),
                        // EditProfileCard(
                        //   keyName: 'Bank Account Number',
                        //   oldValue: bankAccount,
                        //   onSave: (input) => userBankAccount = input,
                        // ),
                        DropdownButton(
                          hint: Text("Please choose your blood group"),
                          //value: bloodGroup,
                          value: selectBloodGroup == null ? bloodGroup : selectBloodGroup,
                          onChanged: (inputValue) {
                            setState(() {
                              selectBloodGroup = inputValue;
                            });
                          },
                          items: bloodGroupList.map((bloodgroup) {
                            return DropdownMenuItem(
                              child: Text(bloodgroup),
                              value: bloodgroup,
                            );
                          }).toList(),
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
                          onPressed: saveProfile,
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
            );
          }
        },
      ),
    );
  }
}
