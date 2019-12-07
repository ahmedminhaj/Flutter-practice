import 'package:flutter/material.dart';
import 'package:pavilion/customWidget/editProfileCard.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
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
                              "Jack",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "Trainee",
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
                            "Peddlecloud",
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
                  value: 'Jack',
                ),
                EditProfileCard(
                  keyName: 'Email',
                  value: 'jack@mail.com',
                ),
                EditProfileCard(
                  keyName: 'Contact Number',
                  value: '+880000000000',
                ),
                EditProfileCard(
                  keyName: 'Address',
                  value: 'A/11, New Street, Old Twon',
                ),
                EditProfileCard(
                  keyName: 'NID',
                  value: '0023450001002003',
                ),
                EditProfileCard(
                  keyName: 'Blood Group',
                  value: 'A+',
                ),
                EditProfileCard(
                  keyName: 'Emerency Contact Number',
                  value: '+880000000000',
                ),
                EditProfileCard(
                  keyName: 'Bank Account Number',
                  value: '00201900000000000000',
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
    );
  }
}
