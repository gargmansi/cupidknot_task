import 'dart:convert';

import 'package:cupidknot_task/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

register(dynamic part) async {
  String url = "https://cupidknot.kuldip.dev/api/register";
  var response = await http.post(Uri.parse(url), body: part);
  return response;
}

login(dynamic body) async {
  String url = "https://cupidknot.kuldip.dev/api/login";
  var response = await http.post(Uri.parse(url), body: body);
  return response;
}

profile() async {
  String url = "https://cupidknot.kuldip.dev/api/user";
  var shared = await SharedPreferences.getInstance();
  String token = shared.getString("token")!;
  print(token);
  var response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token"
  });
  print(response.body);
  return jsonDecode(response.body);
}
