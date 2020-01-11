import 'dart:io';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:HajiraKhata/customWidget/loadingPage.dart';
import 'package:HajiraKhata/customWidget/profileInfoCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:HajiraKhata/api/global.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  //static String routeName;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //static String routeName = '/profile';

  String userID = " ";
  var data, token;
  var userData;
  bool isLoading = true;
  String email = " ",
      name = " ",
      personalEmail = " ",
      address = " ",
      contactNumber = " ",
      joinDate = " ",
      nid = " ",
      bloodGroup = " ",
      designation = " ",
      emergencyContact = " ",
      relation = " ",
      bankAccount = " ",
      department = " ",
      userName = " ";

  @override
  void initState() {
    super.initState();
    profileInfo();
  }

  Future<void> profileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('user_id');
    token = prefs.getString('token') ?? '';

    Map input = {
      'user_id': userID,
    };

    try {
      var url = '$base_url/user/user_profile';
      http.Response response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: token}, body: input);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['status']) {
          data = jsonDecode(response.body);
          userData = data['data'];
          prefs.setString('user_email', userData['email']);
          prefs.setString('user_full_name', userData['name']);
          prefs.setString('user_personal_email', userData['personal_email']);
          prefs.setString(
              'user_permanent_address', userData['permanent_address']);
          prefs.setString('user_contact_no', userData['contact_no']);
          prefs.setString('user_join_date', userData['join_date']);
          prefs.setString('user_nid', userData['nid']);
          prefs.setString('user_blood_group', userData['blood_group']);
          prefs.setString('user_designation', userData['designation']);
          prefs.setString(
              'user_emergency_contact', userData['emergency_contact']);
          prefs.setString('user_bank_account_no', userData['bank_account_no']);
          prefs.setString('user_department_name', userData['department_name']);
          prefs.setString('user_relation_with_emergency_contact',
              userData['relation_with_emergency_contact']);

          setState(() {
            userName = prefs.getString('users_username');
            email = prefs.getString('user_email') ?? '';
            name = prefs.getString('user_full_name') ?? '';
            personalEmail = prefs.getString('user_personal_email') ?? '';
            address = prefs.getString('user_permanent_address') ?? '';
            contactNumber = prefs.getString('user_contact_no') ?? '';
            joinDate = prefs.getString('user_join_date') ?? '';
            nid = prefs.getString('user_nid') ?? '';
            bloodGroup = prefs.getString('user_blood_group') ?? '';
            designation = prefs.getString('user_designation') ?? '';
            emergencyContact = prefs.getString('user_emergency_contact') ?? '';
            bankAccount = prefs.getString('user_bank_account_no') ?? '';
            department = prefs.getString('user_department_name') ?? '';
            relation =
                prefs.getString('user_relation_with_emergency_contact') ?? '';
            isLoading = false;
          });
        } else {
          if (responseBody['message'] == tokenDatabaseCheck ||
              responseBody['message'] == tokenTimeCheck) {
            showToast(responseBody['message']);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/logIn', (Route<dynamic> route) => false);
          } else {
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
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Profile"),
      ),
      body: isLoading ? LoadingPage() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
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
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Animator(
                      tweenMap: {
                        "opacity": Tween<double>(begin: 0.5, end: 1),
                        "translation": Tween<Offset>(
                          begin: Offset(0.5, 0),
                          end: Offset(-0.3, 0),
                        )
                      },
                      cycles: 1,
                      duration: Duration(milliseconds: 1800),
                      builderMap: (Map<String, Animation> anim) =>
                          FadeTransition(
                        opacity: anim["opacity"],
                        child: FractionalTranslation(
                          translation: anim["translation"].value,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 35.0,
                            color: Colors.black,
                          ),
                          // FlutterLogo(
                          //   size: 35,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    '$userName',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.3),
                  ),
                  subtitle: Text(
                    "$designation, $department",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Password Reset',
                  color: Colors.blue,
                  icon: Icons.lock_open,
                  onTap: () {
                    Navigator.of(context).pushNamed('/resetPass');
                  },
                ),
                IconSlideAction(
                  caption: 'Edit Profile',
                  color: Colors.indigo,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.of(context).pushNamed('/editProfile');
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                ProfileInfoCard(
                  keyName: 'Name',
                  value: '$name',
                ),
                ProfileInfoCard(
                  keyName: 'Email',
                  value: '$email',
                ),
                ProfileInfoCard(
                  keyName: 'Contact Number',
                  value: '$contactNumber',
                ),
                ProfileInfoCard(
                  keyName: 'Address',
                  value: '$address',
                ),
                ProfileInfoCard(
                  keyName: 'NID',
                  value: '$nid',
                ),
                ProfileInfoCard(
                  keyName: 'Blood Group',
                  value: '$bloodGroup',
                ),
                ProfileInfoCard(
                  keyName: 'Joining Date',
                  value: '$joinDate',
                ),
                ProfileInfoCard(
                  keyName: 'Emerency Contact Number',
                  value: '$emergencyContact',
                ),
                ProfileInfoCard(
                  keyName: 'Relation with emergency contact',
                  value: '$relation',
                ),
                ProfileInfoCard(
                  keyName: 'Bank Account Number',
                  value: '$bankAccount',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
