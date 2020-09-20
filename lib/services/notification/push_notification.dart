import 'dart:io';

import 'package:beautina_provider/db_sqflite/notification_sqflite.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:beautina_provider/models/notification.dart' as noti;

class PushNotification {
  final FirebaseMessaging _fcmFore = FirebaseMessaging();
  final FirebaseMessaging _fcmBack = FirebaseMessaging();
  final NotificationHelper _notificationHelper = NotificationHelper();

  startForeground(BuildContext context, Function f) {
    _fcmFore.getToken().then((token) {
      print('token is: ' + token);
    });

    _fcmFore.configure(
      onMessage: (Map<String, dynamic> message) async {
        String id = message['data']['id'];
        await saveToMySql(id);
        print("onMessage: some data $id +++++++++++++++++++++++++++++++");
        f();
      },
      onResume: (Map<String, dynamic> message) async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Text('intropage')),
        );
        // String id = message['data']['id'];
        // await saveToMySql(id);
        print("onMessage: some data $message ++++++++++++++++++++++++++++++++");
      },
      onLaunch: (Map<String, dynamic> message) async {
        String id = message['data']['id'];
        // await saveToMySql(id);
        print("onMessage: some data $id +++++++++++++++++++++++++++++++++");
      },
    );
  }

  saveToMySql(String id) async {
    // noti.MyNotification notification = await dbServerloadNotification(id);
    _notificationHelper.initializeDatabase().then((data) async {
      // await _notificationHelper.insertNotification(notification);
      print('it is added!');
    });
  }

  startBackground(BuildContext context) {
    _fcmFore.configure(
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Text('notificationpage')),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch here is go");
        print("onMessage: some data $message");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Text('notification page')),
        );
      },
    );
  }

  void iOS_Permission() {
    _fcmFore.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcmFore.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
