import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/prefrences/services.dart';
import 'package:beautina_provider/services/api_config.dart';
import 'package:http/http.dart' as http;

var SALON_SERVICES = '${URL_DATABASE_LIVE}salon_services';

Future<Map<String, dynamic>?> apiProvidedServices() async {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseUser currentUser = await _auth.currentUser();

  http.Response response;

  try {
    response = await http.get(Uri.parse(SALON_SERVICES));
    // if (response.statusCode != 200) {
    //   throw HttpException('An error occured.');
    // }
    memorySetServices(json.decode(response.body));
    return json.decode(response.body);
  } catch (e) {
    // throw HttpException(e.message);
  }
  // .where('developers', arrayContains: currentUser.uid)
}
