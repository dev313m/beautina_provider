import 'dart:io';

import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PostHelper {
  String? url;
  static const Map<String, String> JSON_TYPE_HEADER = {
    "Content-type": "application/json ",
  };

  bool auth = true;

  Map<String, String> getAuthHeader() {
    String token = BeautyProviderController().getToken()!;
    return {
      "Content-type": "application/json ",
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };
  }

  Map<String, String> header = JSON_TYPE_HEADER;
  PostHelper({this.auth = true, this.url});

  Future<http.Response> makePatchRequest(Map<String, dynamic> map) async {
    String body = json.encode(map);
    // showToast(body);
    // make POST request
    Map<String, String> header = await getAuthHeader();

    print('POST HELPER: \n body: $body \n header: $header');
    Future<http.Response> response;
    try {
      response = http.patch(Uri.parse(url!), headers: header, body: body);
      return response;
    } catch (e) {
      throw HttpException("حدث خطأ ما");
    }
  }

  Future<http.Response> makePostRequest(Map<String, dynamic> map) async {
    // set up POST request arguments
    String uid =
        auth ? BeautyProviderController.getBeautyProviderProfile().uid! : '';
    String body = json.encode(auth ? (map..['client_id'] = uid) : map);

    // showToast(body);
    // make POST request
    if (auth) header = await getAuthHeader();
    print('POST HELPER: \n body: $body \n header: $header');

    http.Response response = await http.post(
      Uri.parse(url!),
      headers: header,
      body: body,
    );

    return response;
    // check the status code for the result
    // int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    // String body = response.body;
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 101
    // }
  }

  Future<http.Response> makeGetRequest(String param) async {
    http.Response response =
        await http.get(Uri.parse(url! + "/$param"), headers: header);
    return response;
  }
}
