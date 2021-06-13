import 'dart:io';

import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PostHelper {
  String url;
  static const Map<String, String> JSON_TYPE_HEADER = {
    "Content-type": "application/json ",
  };

  bool auth = true;

  Future<Map<String, String>> getAuthHeader() async {
    ModelBeautyProvider user = await sharedUserProviderGetInfo();
    return {
      "Content-type": "application/json ",
      HttpHeaders.authorizationHeader: 'Bearer ${user.tokenId}'
    };
  }

  Map<String, String> header = JSON_TYPE_HEADER;
  PostHelper({this.auth, this.url});

  Future<http.Response> makePatchRequest(Map<String, dynamic> map) async {
    print(json.encode(map));
    String body = json.encode(map);
    // showToast(body);
    // make POST request

    Map<String, String> header = await getAuthHeader();

    Future<http.Response> response;
    try {
      response = http.patch(Uri.parse(url), headers: header, body: body);
    } catch (e) {}

    return response;
  }

  Future<http.Response> makePostRequest(Map<String, dynamic> map) async {
    // set up POST request arguments
    print(json.encode(map));
    String body = json.encode(map);
    print(body);
    // make POST request
    if (auth) header = await getAuthHeader();
    http.Response response = await http.post(
      Uri.parse(url),
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

  Future<String> makeGetRequest(String param) async {
    http.Response response = await http.post(Uri.parse(url + "/$param"), headers: header);
    return response.body;
  }
}
