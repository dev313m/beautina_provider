import 'package:beautina_provider/db_sqflite/notification_sqflite.dart';
import 'package:beautina_provider/models/notification.dart';
import 'package:beautina_provider/prefrences/last_notification_date.dart';
import 'package:beautina_provider/models/notification.dart' as noti;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VMRootData with ChangeNotifier {
  bool build = true;
  List<noti.MyNotification> _notificationList = [];
  NotificationHelper _notificationHelper;
  DateTime lastNotifyDate;
  // PreloadPageController pageController;
  // List<Widget> pages;
  // bool _hideBars = false;

  // bool get hideBars => _hideBars;

  // set hideBars(bool hideBars) {
  //   _hideBars = hideBars;
  //   notifyListeners();
  // }

  VMRootData({this.build = true}) {
    if (build) {
      // initNotFuture();
      initialize();
      initNotificationDb();
    }
  }

  shareRoot() {
    // initNotFuture();
    initialize();
    initNotificationDb();
  }

  ///1- Get last notification date to get new ones
  ///2- Order new notifications from the server
  ///3- Save result to SQFLite
  ///4- Notify and update interface

  initNotificationDb() async {
    try {
      String lastNotificationDate = await getPrefrenceLastNotifyDate();

      _notificationHelper = NotificationHelper();
      await _notificationHelper.initializeDatabase();

      List<noti.MyNotification> newList = [];
      if (lastNotificationDate != null)
        newList = await dbServerloadAllNewNotification(lastNotificationDate);
      else
        newList = await dbServerloadAllNotification();

      newList.forEach((dbNotification) async {
        await _notificationHelper.insertNotification(dbNotification);
        refreshList();
      });
    } catch (e) {
      // showToast(e.toString());
    }
  }

  // navigateBtwPages(BuildContext context, int index) {
  //   pageController.jumpTo(index.toDouble());
  //   notifyListeners();
  // }

  refreshList() async {
    await getNotificationList();
    notifyListeners();
  }

  initialize() async {
    _notificationHelper = NotificationHelper();
    await _notificationHelper.initializeDatabase();
    await getNotificationList();
  }

  Future getNotificationList() async {
    _notificationList = await _notificationHelper.getNotificationList();
    notifyListeners();
  }

  NotificationHelper get notificationHelper => _notificationHelper;

  List<noti.MyNotification> get notificationList => _notificationList;

  // PreloadPageController getPageRootPageCntr() => pageController;
}
