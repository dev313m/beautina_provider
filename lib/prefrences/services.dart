import 'package:beauty_order_provider/models/beauty_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// [id, name, phone, city, country]
Future<Null> memorySetServices(Map<String, dynamic> map) async {
  String jsonUser = json.encode(map);

  // List<String> userInfo = [
  //   user.auth_id,
  //   user.name,
  //   user.phone,
  //   user.city,
  //   user.country,
  //   user.doc_id,
  //   user.token,
  //   user.image,
  //   user.reg_date.toString(),
  //   user.favorite_list.toString(),
  //   user.update_date.toString(),
  //   user.tokenId
  // ];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('services', jsonUser);
}

Future<Map<String, dynamic>> memoryGetServices() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userInfo = prefs.getString('services');

  if (userInfo != null) {
    // ModelUser user = ModelUser.fromMap(json.decode(userInfo));
    return json.decode(userInfo);
  }
  return null;
}
