import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/core/services/constants/api_url.dart';
import 'package:beautina_provider/services/api/post.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DBMyService {
  Future addAService(Map<String, dynamic> requestBody) async {
    http.Response response;

    try {
      PostHelper _postHelper = PostHelper(
          auth: true, url: URL_DATABASE_LIVE + ApiUrls.POST_MY_SERVICES);
      response = await _postHelper.makePostRequest(requestBody);
      if (response.statusCode != 200) {
        throw HttpException('An error occured.');
      }
    } catch (e) {
      throw HttpException(e.toString());
      // return {};
    }
  }

  Future disableService(String serviceDocId) async {
    http.Response response;

    try {
      PostHelper _postHelper = PostHelper(
          auth: true, url: URL_DATABASE_LIVE + ApiUrls.POST_DISABLE_SERVICE);
      response = await _postHelper.makePatchRequest({"_id": serviceDocId});
      if (response.statusCode != 200) {
        throw HttpException('An error occured.');
      }
    } catch (e) {
      throw HttpException(e.toString());
      // return {};
    }
  }

  Future<String> getMyServices(String param) async {
    http.Response response;

    try {
      PostHelper _postHelper = PostHelper(
          auth: true, url: URL_DATABASE_LIVE + ApiUrls.GET_MY_SERVICES);
      response = await _postHelper.makeGetRequest(param);
      if (response.statusCode != 200) {
        throw HttpException('An error occured.');
      }
      return response.body;
    } catch (e) {
      throw HttpException(e.toString());
      // return {};
    }
  }
}
