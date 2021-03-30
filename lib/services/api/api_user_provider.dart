import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/services/api/post.dart';
import 'package:http/http.dart' as http;

final ERROR = "حدث خطأ ما، الرجاء المحاولة مجددا";
String URL_UPDATE_USERNAME =
    'https://app-beautyorder.uc.r.appspot.com/beauty_providers/update_username';
String URL_ADD_NEW_USER =
    'https://app-beautyorder.uc.r.appspot.com/beauty_providers/login';
String URL_UPDATE_USER =
    'https://app-beautyorder.uc.r.appspot.com/beauty_providers/update';
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
  PostHelper ph = PostHelper(auth: false, url: URL_ADD_NEW_USER);
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
    throw HttpException(ERROR);
  }
}

Future<ModelBeautyProvider> apiLoadOneBeautyProvider() async {
  ModelBeautyProvider beautyProvider = await sharedUserProviderGetInfo();
  http.Response response;
  try {
    response = await http.Client().get(
        'https://app-beautyorder.uc.r.appspot.com/beauty_providers/' +
            beautyProvider.uid);

    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
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
    ModelBeautyProvider beautyProvider) async {
  // ModelBeautyProvider beautyProvider = await sharedUserProviderGetInfo();
  http.Response response;
  PostHelper ph = PostHelper(auth: true, url: URL_UPDATE_USERNAME);

  //because busy dates contains datetime so please convert them to string to be encodable

  Map<String, dynamic> body = {
    'name': beautyProvider.name,
    'client_id': beautyProvider.uid,
    'username': beautyProvider.username,
  };

  try {
    response = await ph.makePatchRequest(body);

    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
    // ModelBeautyProvider model = parseOne(response.body);
    // await sharedUserProviderSet(beautyProvider: model);
    await sharedUserProviderSet(beautyProvider: beautyProvider);

    return beautyProvider;
  } catch (e) {
    throw HttpException(ERROR);
  }
}

Future<ModelBeautyProvider> apiBeautyProviderUpdate(
    ModelBeautyProvider beautyProvider) async {
  // ModelBeautyProvider beautyProvider = await sharedUserProviderGetInfo();
  http.Response response;
  PostHelper ph = PostHelper(auth: true, url: URL_UPDATE_USER);

  //because busy dates contains datetime so please convert them to string to be encodable

  List<Map<String, String>> busyDates = beautyProvider.busyDates.map((e) {
    Map<String, String> busyDate = {
      'from': e['from'].toString(),
      'to': e['to'].toString()
    };
    return busyDate;
  }).toList();

  Map<String, dynamic> body = {
    'default_accept': beautyProvider.default_accept, 
    'default_after_accept': beautyProvider.default_after_accept,
    'phone': beautyProvider.phone,
    'intro': beautyProvider.intro,
    'name': beautyProvider.name,
    'services': beautyProvider.servicespro,
    'client_id': beautyProvider.uid,
    'username': beautyProvider.username,
    'service_duration': beautyProvider.service_duration,
    'available': beautyProvider.available,
    'busy_dates': busyDates,
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
    await sharedUserProviderSet(beautyProvider: beautyProvider);

    return beautyProvider;
  } catch (e) {
    throw HttpException(ERROR);
  }
}
