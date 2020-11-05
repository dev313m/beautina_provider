import 'package:beautina_provider/db_sqflite/notification_sqflite.dart';
import 'package:beautina_provider/screens/dates/index.dart';
import 'package:beautina_provider/screens/my_salon/index.dart';
import 'package:beautina_provider/screens/notification/index.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/ui/ui.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:beautina_provider/screens/settings/index.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/models/notification.dart' as noti;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

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
// PreloadPageController getPageCntrl(BuildContext context) {
//   return Provider.of<VMRootData>(context).getPageRootPageCntr();
// }

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
  // onAlertWithCustomContentPressed(context);

  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  //Get Latest version info from firebase config

  try {
    // Using default duration to force fetching from remote server.
    http.Response respond = await http.get(
        'https://resorthome.000webhostapp.com/version_service_provider.php');
    final String nowVersion = respond.body;

    double newVersion = double.parse(nowVersion.trim().replaceAll(".", ""));
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

initNotFuture(BuildContext context) async {
  VMRootUi vmRootUi = Provider.of<VMRootUi>(context);
  VMRootData vmRootData = Provider.of<VMRootData>(context);
  vmRootUi.pageController.addListener(() async {
    if (vmRootUi.pageController.page.toInt() == 1.0) {
      vmRootUi.isVisitedPage = true;
    } else if (vmRootUi.isVisitedPage) {
      vmRootUi.isVisitedPage = false;
      await vmRootData.notificationHelper.initializeDatabase().then((d) {
        vmRootData.notificationHelper
            .updateListToRead(vmRootData.notificationList);
        vmRootData.refreshList();
      });
      // _notificationHelper.updateNotification();
    }
  });
}
