import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _fcmFore = FirebaseMessaging();

Future<String> apiTokenGet() async {
  final FirebaseMessaging _fcmFore = FirebaseMessaging();
  String token;
  try {
    token = await _fcmFore.getToken();
    return token;
  } catch (e) {
    throw HttpException('Notification Exception: n01');
  }
}
