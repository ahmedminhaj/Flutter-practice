import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Server URL
final String base_url = "https://pavdev.peddlecloud.com/api";

// Localhost URL
//final String base_url = "http://192.168.1.2/pavdev/api";

final String tokenDatabaseCheck = "Token not exists in Database" ;
final String tokenTimeCheck = "Token Time Expire." ;


// Show message in toast
void showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 3,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white
  );
}


