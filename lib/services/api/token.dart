
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


Future<String> apiTokenGet() async {
  final FirebaseMessaging _fcmFore = FirebaseMessaging.instance;
  String token;
  try {
    token = await _fcmFore.getToken();
    return token;
  } catch (e) {
    throw HttpException(e.toString());
    
  }
}
