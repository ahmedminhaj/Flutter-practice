import 'package:flutter/material.dart';
import 'package:pavilion/homepage.dart';
import 'signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signUp': (BuildContext context) => SignupPage(),
        '/logIn': (BuildContext context) => MyHomePage(),
        '/homePage': (BuildContext context) => HomePage(),
      },
      home: MyHomePage(),
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '_',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      SizedBox(width: 0.2),
                      Text(
                        'teamPavilion',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 120.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'login',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 90.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 6.1),
                      ),
                      SizedBox(width: 1.0),
                      Text(
                        '.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 90.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/homePage');
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New in Pavilion ?',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/signUp');
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
      )
    );
  }
}
