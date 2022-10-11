import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/core/services/constants/api_url.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/services/api/post.dart';
import 'package:http/http.dart' as http;

final ERROR = "حدث خطأ ما، الرجاء المحاولة مجددا";

// String URL_ADD_FAVORITE = 'https://beautyorders.herokuapp.com/favorite';

// Future<Null> apiUserAddNew(ModelUser user) async {
//   try {
//     await Firestore.instance.collection('users').add(user.toMap());
//   } catch (err) {
//     showToast(err);
//   }
// }

Future<ModelBeautyProvider> apiUserProviderAddNew(
    ModelBeautyProvider modelBeautyProvider) async {
  PostHelper ph = PostHelper(
      auth: false, url: URL_DATABASE_LIVE + ApiUrls.URL_ADD_NEW_USER);
  ph.auth = false;
  http.Response response;
  try {
    var bp = modelBeautyProvider.getMap();
    response = await ph.makePostRequest(modelBeautyProvider.getMap());
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
    final parsed = json.decode(response.body);

    return ModelBeautyProvider.fromMap(parsed);
  } catch (e) {
    throw HttpException(e.toString());
  }
}

Future<ModelBeautyProvider?> apiLoadOneBeautyProvider() async {
  ModelBeautyProvider beautyProvider =
      BeautyProviderController.getBeautyProviderProfile();
  http.Response response;
  PostHelper ph = PostHelper(
      auth: true, url: URL_DATABASE_LIVE + ApiUrls.PATCH_PROVIDERS_AND_UPDATE);

  Map<String, dynamic> body = {
    'client_id': beautyProvider.uid,
  };

  try {
    response = await ph.makePatchRequest(body);

    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body));
    return parseOne(response.body);
  } catch (e) {
    throw HttpException(ERROR);
  }
}

ModelBeautyProvider parseOne(String responseBody) {
  final parsed = json.decode(responseBody);
  return ModelBeautyProvider.fromMap(parsed);
}

Future<ModelBeautyProvider> apiBeautyProviderUpdateUsername(
    String username) async {
  // ModelBeautyProvider beautyProvider = await sharedUserProviderGetInfo();
  http.Response response;
  PostHelper ph = PostHelper(
      auth: true, url: URL_DATABASE_LIVE + ApiUrls.URL_UPDATE_USERNAME);

  //because busy dates contains datetime so please convert them to string to be encodable

  Map<String, dynamic> body = {
    'username': username,
  };

  try {
    response = await ph.makePatchRequest(body);

    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
    // ModelBeautyProvider model = parseOne(response.body);
    // await sharedUserProviderSet(beautyProvider: model);
    var user = BeautyProviderController.getBeautyProviderProfile()
      ..username = username;
    await BeautyProviderController().storeToLocalDB(user);

    return user;
  } catch (e) {
    throw HttpException(ERROR);
  }
}

Future<ModelBeautyProvider> apiBeautyProviderUpdate(
    ModelBeautyProvider beautyProvider) async {
  // ModelBeautyProvider beautyProvider = await sharedUserProviderGetInfo();
  http.Response response;
  PostHelper ph =
      PostHelper(auth: true, url: URL_DATABASE_LIVE + ApiUrls.URL_UPDATE_USER);

  //because busy dates contains datetime so please convert them to string to be encodable

  Map<String, dynamic> body = {
    'default_accept': beautyProvider.default_accept,
    'default_after_accept': beautyProvider.default_after_accept,
    'phone': beautyProvider.phone,
    'intro': beautyProvider.intro,
    'name': beautyProvider.name,
    // 'services': beautyProvider.servicespro,
    'client_id': beautyProvider.uid,
    'username': beautyProvider.username,
    // 'service_duration': beautyProvider.service_duration,
    'available': beautyProvider.available,
    // 'busy_dates': busyDates,
    'location': beautyProvider.location,
    'city': beautyProvider.city,
    'country': beautyProvider.country,
    'image': beautyProvider.image
  };

  try {
    response = await ph.makePatchRequest(body);

    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
    // ModelBeautyProvider model = parseOne(response.body);
    // await sharedUserProviderSet(beautyProvider: model);
    // await sharedUserProviderSet(beautyProvider: beautyProvider);
    await BeautyProviderController().storeToLocalDB(beautyProvider);

    return beautyProvider;
  } catch (e) {
    print(
        'http error \n url: ${URL_DATABASE_LIVE + ApiUrls.URL_UPDATE_USER} \n error: ${e.toString()}');

    throw HttpException(e.toString());
  }
}
