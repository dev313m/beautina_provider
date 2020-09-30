import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// [id, name, phone, city, country]
Future<Null> sharedUserProviderSet({@required ModelBeautyProvider beautyProvider}) async {
  if (beautyProvider.tokenId == '' || beautyProvider.tokenId == null) {
    ModelBeautyProvider bp = await sharedUserProviderGetInfo();
    beautyProvider.tokenId = bp.tokenId;
  }
  Map<String, dynamic> fixedMap = beautyProvider.getMap();
  fixedMap['busy_dates'] = beautyProvider.busyDates.map((e) {
    Map<String, String> busyDate = {'from': e['from'].toString(), 'to': e['to'].toString()};
    return busyDate;
  }).toList();

  String jsonUser = json.encode(fixedMap);

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
  prefs.setString('user_info', jsonUser);
}

Future<ModelBeautyProvider> sharedUserProviderGetInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userInfo = prefs.getString('user_info');

  if (userInfo != null) {
    // ModelUser user = ModelUser.fromMap(json.decode(userInfo));
    return ModelBeautyProvider.fromMap(json.decode(userInfo));
  }
  return null;
}
