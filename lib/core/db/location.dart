import 'dart:async';
import 'dart:io';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/core/services/constants/api_url.dart';
import 'package:beautina_provider/services/api/post.dart';
import 'package:http/http.dart' as http;

class DBChangeLocation {
  Future updateLocation({required double lat, required double lng}) async {
    http.Response response;

    try {
      PostHelper _postHelper = PostHelper(
          auth: true, url: URL_DATABASE_LIVE + ApiUrls.UPDATE_LOCATION);
      response = await _postHelper.makePostRequest({'lng': lng, 'lat': lat});
      if (response.statusCode != 200) {
        throw HttpException('An error occured.');
      }
    } catch (e) {
      throw HttpException(e.toString());
      // return {};
    }
  }
}
