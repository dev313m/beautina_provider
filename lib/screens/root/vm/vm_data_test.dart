import 'package:beautina_provider/db_sqflite/notification_sqflite.dart';
import 'package:beautina_provider/models/notification.dart';
import 'package:beautina_provider/prefrences/last_notification_date.dart';
import 'package:beautina_provider/models/notification.dart' as noti;
import 'package:get/get_state_manager/get_state_manager.dart';

class VMRootDataTest extends GetxController {
  ///initialize requests flag
  bool build = true;

  ///list of all saved notifications
  List<noti.MyNotification> _notificationList = [];

  bool isBusyAddingAddingNotifications = false;

  /// sqlite database class initializer
  NotificationHelper _notificationHelper;

  /// The date of last notifications recieved.
  DateTime lastNotifyDate;

  /// If the initilizing is required do two things:
  ///     1- Get saved notification list from sqlite.
  ///     2- Send a request to recieve new notfications and then update the list.
  VMRootDataTest({this.build = true}) {
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

  /// Get new notifications and update sqlite and refresh list.
  ///
  ///1- Get last notification date to get new ones
  ///
  ///2- Order new notifications from the server
  ///
  ///3- Save result to SQFLite
  ///
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

      if (!isBusyAddingAddingNotifications)
        newList.forEach((dbNotification) async {
          isBusyAddingAddingNotifications = true;
          await _notificationHelper.insertNotification(dbNotification);
        });
      refreshNotificationList();
      isBusyAddingAddingNotifications = false;
    } catch (e) {
      isBusyAddingAddingNotifications = false;
      // showToast(e.toString());
    }
  }

  // navigateBtwPages(BuildContext context, int index) {
  //   pageController.jumpTo(index.toDouble());
  //   notifyListeners();
  // }

  /// Get new notifications from the sercer and update sqlite and refresh list.

  refreshNotificationList() async {
    await getNotificationList();
    update();
  }

  /// initialize sqlite and get saved notifications.
  initialize() async {
    _notificationHelper = NotificationHelper();
    await _notificationHelper.initializeDatabase();
    await getNotificationList();
  }

  /// get sqlite stored notfications and update the list
  Future getNotificationList() async {
    _notificationList = await _notificationHelper.getNotificationList();
    update();
  }

  NotificationHelper get notificationHelper => _notificationHelper;

  List<noti.MyNotification> get notificationList => _notificationList;

  // PreloadPageController getPageRootPageCntr() => pageController;
}
