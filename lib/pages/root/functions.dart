import 'package:beauty_order_provider/db_sqflite/notification_sqflite.dart';
import 'package:beauty_order_provider/pages/dates/index.dart';
import 'package:beauty_order_provider/pages/my_salon/index.dart';
import 'package:beauty_order_provider/pages/notification/index.dart';
import 'package:beauty_order_provider/pages/packages/index.dart';
import 'package:beauty_order_provider/pages/root/shared_variable_root.dart';
import 'package:beauty_order_provider/pages/root/ui.dart';
import 'package:beauty_order_provider/pages/settings/index.dart';
import 'package:beauty_order_provider/prefrences/sharedUserProvider.dart';
import 'package:beauty_order_provider/reusables/toast.dart';
import 'package:beauty_order_provider/services/api/api_user_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:beauty_order_provider/models/notification.dart' as noti;
import 'package:url_launcher/url_launcher.dart';

///This will return the list of pages that appears in the main menu of the app
List<Widget> getMainPages() {
  List<Widget> _pages = [
    PageSettings(),
    NotificationPage(),
    DatePage(),
    // PagePackage(),
    PageSalon(),
  ];
  return _pages;
}

///This controls the movement of the mainpages inside the app
PreloadPageController getPageCntrl(BuildContext context) {
  return Provider.of<SharedRoot>(context).getPageRootPageCntr();
}

Future onNotificationMessage(String id) async {
  await saveNotificationToMySql(id);
  return null;
}

Future saveNotificationToMySql(String id) async {
  try {
    // noti.MyNotification notification = await dbServerloadNotification(id);
    NotificationHelper _notificationHelper = NotificationHelper();
    await _notificationHelper.initializeDatabase().then((data) async {
      // await _notificationHelper.insertNotification(notification);
      // print('it is added!');
      return null;
    });
  } catch (e) {
    showToast(e.toString());
  }
}

int getNewCounterNotification(List<noti.MyNotification> n) {
  int counter = n.where((n) => n.status == 0).length;
  return counter;
}

versionCheck(BuildContext context) async {
  await Future.delayed(Duration(seconds: 4));
  onAlertWithCustomContentPressed(context);

  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  //Get Latest version info from firebase config
  final RemoteConfig remoteConfig = await RemoteConfig.instance;

  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    remoteConfig.getString('version');
    double newVersion = double.parse(
        remoteConfig.getString('version').trim().replaceAll(".", ""));
    if (newVersion > currentVersion) {
      onAlertWithCustomContentPressed(context);
    }
  } on FetchThrottledException catch (exception) {
    // Fetch throttled.
    print(exception);
  } catch (exception) {
    print('Unable to fetch remote config. Cached or default values will be '
        'used');
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
