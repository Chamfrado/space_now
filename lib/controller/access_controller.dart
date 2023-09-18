import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccessController{
  static final AccessController instance =  AccessController();

  static const _baseURL = 'https://api.escuelajs.co/api/v1/auth/';
  
  late SharedPreferences _prefs;

  Future<bool> verificarToken() async{
    _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');

    if (token != null && !JwtDecoder.isExpired(token) ) {

      return true;
    } else {
      return false;
    }

  }

  Future<bool> login(String email, String psswd)async {
    http.Response response = 
    await http.post(Uri.parse('${_baseURL}login'),
    headers: <String, String>{'Content-Type' : 'application/json'},
    body: jsonEncode({
      'email' : "john@mail.com",
      'password' : "changeme",
    }) 
    );

    print(response.body);

    if (response.statusCode == 201) {
      _prefs.setString('token', json.decode(response.body)['access_token']);
      return true;
    } else {
      return false;
    }

  }

  Future<bool> logout() async{
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    return true;
  }
}