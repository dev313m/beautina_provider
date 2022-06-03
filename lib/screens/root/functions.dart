import 'package:beautina_provider/core/controller/refresh_controller.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/refresh.dart';
import 'package:beautina_provider/screens/root/ui/ui.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/services/remote_config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';

/// Version checker between the current and the http request of the saved one in server
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

    RemoteConfigService remote = await (RemoteConfigService.getInstance()
        as FutureOr<RemoteConfigService>);
    await remote.initialize();
    final String nowVersion = remote.getStringValue;

    double newVersion = double.parse(nowVersion.trim().replaceAll(".", ""));
    if (newVersion > currentVersion) {
      onAlertWithCustomContentPressed(context);
    }
  } on Exception catch (exception) {
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
  VMRootUiTest vmRootUi = Get.find<VMRootUiTest>();
  VMRootDataTest vmRootData = Get.find<VMRootDataTest>();
  vmRootUi.pageController.addListener(() async {
    if (vmRootUi.pageController.page!.toInt() == 1.0) {
      vmRootUi.isVisitedPage = true;
    } else if (vmRootUi.isVisitedPage) {
      vmRootUi.isVisitedPage = false;
      await vmRootData.notificationHelper!.initializeDatabase().then((d) {
        vmRootData.notificationHelper!
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
      Get.find<VMRootUiTest>().isNoInternet = true;
      // isNoInternet = true;
    } else {
      Get.find<VMRootUiTest>().isNoInternet = false;

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
  if (Get.find<VMRootUiTest>().pageController.page!.round() != 4) {
    Get.find<VMRootUiTest>().pageController.jumpToPage(4);

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
  Get.find<VMRootUiTest>().hideBars = false;
};

///Show bar when scroll up

Function onScrollUp = (BuildContext context) {
  Get.find<VMRootUiTest>().hideBars = true;
};

///Take an action when scrolling down or up
onScrollAction(ScrollController scrollController, BuildContext context,
    {Function? onScrolldown, Function? onScrollUp}) {
  bool hideBars = Get.find<VMRootUiTest>().hideBars;

  ///if scrolilng toward up [and] hidebars is [true] hidden
  if (scrollController.position.userScrollDirection ==
      ScrollDirection.reverse) {
    if (!hideBars) onScrollUp!(context);
  }

  /// if scrolling towards down and hidebars is [false] shown
  else if (hideBars) onScrolldown!(context);
}

///This function updates beautyProvider[user]
updateUserData(
    BuildContext context, ModelBeautyProvider updatedBeautyProvider) async {}

getLaunchMapFunction(List<dynamic> geoPoint) {
  if (geoPoint.length == 0 || geoPoint == null)
    return () {
      showToast("لم يتم تحديد الموقع :(");
    };
  Function f = () async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${geoPoint[0]},${geoPoint[1]}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  };
  return f;
}

Function getWhatsappFunction(String? s) {
  String url = 'tel://$s';
  String whatsappUrl = "whatsapp://send?phone=$s";
  Function f = () async {
    await canLaunch(whatsappUrl) ? launch(whatsappUrl) : launch(url);
  };

  return f;
}

gFunShareAccount(String? username) {
  Share.share(' https://beautina.app/$username خدماتنا على هذا الرابط',
      subject: '');
}

gFunCopyText(String text) async {
  await FlutterClipboard.copy(text);
  showToast('تم نسخ النص');
}

String convertArabicToEnglish(String number) {
  number = number.replaceFirst('۱', '1');
  number = number.replaceFirst('۲', '2');
  number = number.replaceFirst('۳', '3');
  number = number.replaceFirst('٤', '4');
  number = number.replaceFirst('٥', '5');
  number = number.replaceFirst('٦', '6');
  number = number.replaceFirst('٧', '7');
  number = number.replaceFirst('۸', '8');
  number = number.replaceFirst('۹', '9');
  return number;
}
