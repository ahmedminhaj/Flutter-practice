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
    setState(() {
      email = userData['email'];
      name = userData['name'];
      personalEmail = userData['personal_email'];
      address = userData['permanent_address'];
      contactNumber = userData['contact_no'];
      joinDate = userData['join_date'];
      nid = userData['nid'];
      bloodGroup = userData['blood_group'];
      designation = userData['designation'];
      emergencyContact = userData['emergency_contact'];
      bankAccount = userData['bank_account_no'];
      department = userData['department_name'];
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
