import 'package:flutter/material.dart';
import 'package:pavilion/data/json_user.dart';

class Home extends StatelessWidget {
  Home({@required this.user});
  final JsonUser user;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: user != null 
        ?Text(
          'Logged In ${user.email}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 6.1,
          ),
        )
        :Text('Not logged In'),
      ),
    );
  }
}


