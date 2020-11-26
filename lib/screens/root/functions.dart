import 'package:beautina_provider/screens/refresh.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/ui/ui.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/rendering.dart';

/// Version checker between the current and the http request of the saved one in server
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

///if the notificaton page visited:
///1- clear the numbers on the notification
///2- set a flag to await the process to finish [[isVisitedPage]]
onNotificationPageVisited(BuildContext context) async {
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
        vmRootData.refreshNotificationList();
      });
      // _notificationHelper.updateNotification();
    }
  });
}

///Listern if the connection is lost to the internetw
listenToInternet(BuildContext context) {
  StreamSubscription<ConnectivityResult> subscription;

  subscription =
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result.index == ConnectivityResult.none.index) {
      Provider.of<VMRootUi>(context).isNoInternet = true;
      // isNoInternet = true;
    } else {
      Provider.of<VMRootUi>(context).isNoInternet = false;

      // refreshApp(context);
      // isNoInternet = false;
    }
  });
}

/// initialize timeago string
initTimeString() {
  timeago.setLocaleMessages('ar', timeago.ArMessages());
}

/// Take an action if app life cycle changes,
/// [[todo]] must be checked if context is ready.. !
lifeCycleChangeAction(AppLifecycleState state, BuildContext context) {
  switch (state) {
    case AppLifecycleState.inactive:
      print("Inactive");
      break;
    case AppLifecycleState.paused:
      print("Paused");
      break;
    case AppLifecycleState.resumed:
      refreshResume(context);
      break;
    case AppLifecycleState.detached:
      print("Suspending");
      break;
  }
}

///To check if the user on the root screen, it will go otherwise it will move
///the user to root screen
Future<bool> willExitApp(BuildContext context) async {
  if (Provider.of<VMRootUi>(context).pageController.page != 3) {
    Provider.of<VMRootUi>(context).pageController.jumpToPage(3);

    return false;
  }
  return true;
}

///This method to close keyboard whenever a user click on not keyboard

closeKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

///Hide bar when scroll down
Function onScrollDown = (BuildContext context) {
  Provider.of<VMRootUi>(context).hideBars = true;
};

///Show bar when scroll up

Function onScrollUp = (BuildContext context) {
  Provider.of<VMRootUi>(context).hideBars = false;
};

///Take an action when scrolling down or up
onScrollAction(
    ScrollController scrollController, bool hideBars, BuildContext context,
    {Function onScrolldown, Function onScrollUp}) {
  if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse &&
      hideBars)
    onScrollDown(context);
  else if (Provider.of<VMRootUi>(context).hideBars && !hideBars)
    onScrollUp(context);
}
