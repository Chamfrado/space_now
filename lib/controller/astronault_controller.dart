import 'dart:convert';

import 'package:space_now/models/astronault.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AstronaultController {
  static final AstronaultController instance = AstronaultController();

  static const _baseURL = 'http://api.open-notify.org/';
  late SharedPreferences _prefs;

  Future<List<Astronault>> getAstronaultList() async {
    _prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
      Uri.parse('${_baseURL}astros.json'),
    );

    //print(response.body);

    if (response.statusCode == 200) {
      List<Astronault> astronaults = [];
      print(response.body);
      Map results = jsonDecode(response.body);
      
      results['people'].forEach(
        (astronaultResult) {
          Astronault astronault = Astronault.fromJson(astronaultResult);
          astronaults.add(astronault);
        },
      );
      return astronaults;
    } else {
      throw Exception('Falha ao buscar astronaultas');
    }
  }
}
