import 'package:beauty_order_provider/db_sqflite/notification_sqflite.dart';
import 'package:beauty_order_provider/models/notification.dart';
import 'package:beauty_order_provider/prefrences/last_notification_date.dart';
import 'package:beauty_order_provider/reusables/toast.dart';
import 'package:beauty_order_provider/models/notification.dart' as noti;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class SharedRoot with ChangeNotifier {
  bool build = true;
  List<noti.MyNotification> _notificationList = [];
  NotificationHelper _notificationHelper;
  DateTime lastNotifyDate;
  PreloadPageController pageController;
  List<Widget> pages;
  bool _hideBars = false;

  bool get hideBars => _hideBars;

  set hideBars(bool hideBars) {
    _hideBars = hideBars;
    notifyListeners();
  }

  bool isVisitedPage = false; //if notification page is visited
  SharedRoot({this.build = true}) {
    if (build) {
      initNotFuture();
      initialize();
      initNotificationDb();
    }
  }

  shareRoot() {
    initNotFuture();
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

  initNotFuture() async {
    pageController = PreloadPageController(
      initialPage: 3,
      keepPage: true,
    );
    pageController.addListener(() async {
      if (pageController.page.toInt() == 1.0) {
        isVisitedPage = true;
      } else if (isVisitedPage) {
        isVisitedPage = false;
        await _notificationHelper.initializeDatabase().then((d) {
          _notificationHelper.updateListToRead(_notificationList);
          refreshList();
        });
        // _notificationHelper.updateNotification();
      }
    });
  }

  navigateBtwPages(BuildContext context, int index) {
    pageController.jumpTo(index.toDouble());
    notifyListeners();
  }

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

  List<noti.MyNotification> get notificationList => _notificationList;

  PreloadPageController getPageRootPageCntr() => pageController;
}
