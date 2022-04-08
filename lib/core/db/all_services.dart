import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/core/services/constants/api_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DBAllServices {
  Future<List<dynamic>> apiAllServices() async {
    http.Response response;

    try {
      response = await http
          .get(Uri.parse(URL_DATABASE_LIVE + ApiUrls.GET_SALON_ALL_SERVICES));
      if (response.statusCode != 200) {
        throw HttpException('An error occured.');
      }
      var decoded = await compute(json.decode, response.body);
      return decoded['services'];
    } catch (e) {
      throw HttpException(e.toString());
      // return {};
    }
  }
}
