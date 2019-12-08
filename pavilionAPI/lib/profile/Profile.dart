import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pavilion/customWidget/profileInfoCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pavilion/api/global.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userID = "";
  var data;
  var userData;
  String email, name, personalEmail, address, contactNumber, joinDate, nid, bloodGroup, designation, emergencyContact, bankAccount, department;

  @override
  void initState() {
    super.initState();
    profileInfo();
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
    prefs.setString('user_email', userData['email']);
    prefs.setString('user_full_name', userData['name']);
    prefs.setString('user_personal_email', userData['personal_email']);
    prefs.setString('user_permanent_address', userData['permanent_address']);
    prefs.setString('user_contact_no', userData['contact_no']);
    prefs.setString('user_join_date', userData['join_date']);
    prefs.setString('user_nid', userData['nid']);
    prefs.setString('user_blood_group', userData['blood_group']);
    prefs.setString('user_designation', userData['designation']);
    prefs.setString('user_emergency_contact', userData['emergency_contact']);
    prefs.setString('user_bank_account_no', userData['bank_account_no']);
    prefs.setString('user_department_name', userData['department_name']);
    
    setState(() {
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
    });
    //debugPrint(userData.toString());
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
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
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/image/leftArrow.png'),
                        ),
                      ),
                      //Image.asset("assets/image/leftArrow.png",)
                    ),
                  ),
                  title: Text(
                    '$name',
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
                  icon: Icons.restore_page,
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
