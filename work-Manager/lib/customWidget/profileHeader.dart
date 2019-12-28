import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String designation;
  final String department;

  ProfileHeader({
    this.userName,
    this.designation,
    this.department
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
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
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    designation,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    department,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30.1,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 115, 0, 0),
          alignment: Alignment.topCenter,
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
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
    );
  }
}
