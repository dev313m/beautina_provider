import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// [id, name, phone, city, country]
Future<Null> sharedUserProviderSet(
    {required ModelBeautyProvider beautyProvider}) async {
  if (beautyProvider.tokenId == '' || beautyProvider.tokenId == null) {
    ModelBeautyProvider bp = await sharedUserProviderGetInfo();
    beautyProvider.tokenId = bp.tokenId;
  }
  Map<String, dynamic> fixedMap = beautyProvider.getMap();
  fixedMap['busy_dates'] = beautyProvider.busyDates!.map((e) {
    Map<String, String> busyDate = {
      'from': e['from'].toString(),
      'to': e['to'].toString()
    };
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
  // '{"type":1,"service_duration":{"hc01":15,"تست":15,"hca01":60,"hs01":15,"wa01":300,"hs05":150,"wa03":60,"test":120,"bb01":60},"default_after_accept":2,"available":false,"auth_login":"","tokenId":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwMDgxNDRmN2EyOWYzMDAwYTM4MTBiZCIsImVtYWlsIjoicmFzYXNpLmJAZ21haWwuY29tIiwiaWF0IjoxNjE1ODI4NTY1fQ.4D-YhG_gD8fRCpLTdH33O3NqO_yqqB_g2ykv9WNKjOg","default_accept":false,"image":"","package":{},"busy_dates":[],"username":"good_d","customers":2.0,"acheived":0,"intro":"jklsjfdlkjfsldkfj lsdkjfdls jfdslkf jdslf djl ","favorite_count":2,"location":[37.4219983,-122.084],"name":"test","visitors":0,"points":0,"reg_date":"2021-01-20 14:30:17.240Z","rating":9.0,"phone":"+966433333333","city":"Mekkah","country":"SA","voter":3,"email":"rasasi.b@gmail.com","likes":0,"achieved":0,"services":{"hair_cut":{},"hair_style":{"hs05":[90]},"wax":{"wa03":[40]},"other":{"test":[90]},"henna_red":{}},"token":"dC36J0sbKr4:APA91bEu4Myr1HToXAf2AmiOXuYZii7MRd_x2mdS2vYdaJ6vb-77m7V72Kz4DVyScIZfOwextqA3A_W1sSF_P_Wd3ErY8Q4twCEgaZvgaOeDEYgtE5BrniaX0Jj1_5QKlnljdWhEUNv7","_id":"6008144f7a29f3000a3810bd"}'
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_info', jsonUser);
}

Future<ModelBeautyProvider> sharedUserProviderGetInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userInfo = prefs.getString('user_info');

  if (userInfo != null) {
    // ModelUser user = ModelUser.fromMap(json.decode(userInfo));
    return ModelBeautyProvider.fromMap(json.decode(userInfo));
  }
  return ModelBeautyProvider();
}
