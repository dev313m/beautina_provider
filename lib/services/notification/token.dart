import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

// final FirebaseMessaging _fcmFore = FirebaseMessaging.instance;

Future<String?> apiTokenGet() async {
  final FirebaseMessaging _fcmFore = FirebaseMessaging.instance;
  String? token;
  try {
    token = await _fcmFore.getToken();
    return token;
  } catch (e) {
    throw HttpException('Notification Exception: ${e.toString()}');
  }
}
