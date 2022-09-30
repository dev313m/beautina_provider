import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class DBNotification {
  Future send(
      {required Map<String, String> data, required String token}) async {
    try {
      await FirebaseMessaging.instance.sendMessage(
        to: token,
        messageType: 'any',
        data: data,
      );
    } catch (e) {
      throw HttpException(e.toString());
      // return {};
    }
  }
}
