import 'dart:convert';

import 'package:http/http.dart' as http;

class URLS{
  static const String base_url = 'https://peddlecloud.com/pavdev/api//auth/';

}

class ApiService{
  static Future<bool> loginUser(body) async{
    
    final response = await http.post('${URLS.base_url}/user_login', body: body);
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}