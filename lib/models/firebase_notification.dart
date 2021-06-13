import 'dart:convert';
import 'dart:io';
import 'package:beautina_provider/services/api/post.dart';
import 'package:beautina_provider/services/api_config.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
final NOTIFICATION_URL = '${URL_DATABASE_LIVE}send';

class ModelFirebaseNotification {
  String token;
  String body;
  String title;
  String type;
  String from;

  ModelFirebaseNotification(
      {this.body, this.from, this.title, this.type, this.token});

  Map<String,dynamic> getMap() {
    return {'title': title, 'body': body, 'token': token, 'type': "4"};
  }

   Future sendPushNotification() async {
    http.Response response;

    PostHelper ph = PostHelper(auth: true, url: NOTIFICATION_URL);
    try {
      response = await ph.makePostRequest(getMap());
      if (response.statusCode != 200)
        throw HttpException(jsonDecode(response.body)['message']);
    } catch (e) {
      throw HttpException("هناك خطأ: $e ");
    }
    return response;
  }
}
