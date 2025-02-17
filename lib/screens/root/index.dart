import 'dart:async';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/dates/index.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/screens/salon/index.dart';
import 'package:beautina_provider/screens/notification/index.dart';
import 'package:beautina_provider/screens/refresh.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/root/ui/no_internet.dart';
import 'package:beautina_provider/screens/root/ui/root_bottom_bar.dart';
import 'package:beautina_provider/screens/root/ui/root_top_bar.dart';
import 'package:beautina_provider/screens/settings/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/screens/gift/index.dart';

class PageRoot extends StatefulWidget {
  @override
  _PageRoot createState() => _PageRoot();
}

class _PageRoot extends State<PageRoot>
    with
        SingleTickerProviderStateMixin,
        WidgetsBindingObserver,
        AutomaticKeepAliveClientMixin<PageRoot> {
  List<Widget> _pages;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    contextReadyAwaiter();
    initTimeString();
    setPushNotification();

    _pages = [
      PageSettings(),
      PageNotification(),
      PageGift(),

      PageDate(),
      // PagePackage(),

      PageSalon(),
    ];
  }

  /// Await buildcontext before calling dependent functions
  /// If was not wating all of the below function would have bugs and errors
  contextReadyAwaiter() async {
    await Future.delayed(Duration(milliseconds: 300));
    onNotificationPageVisited(context);
    versionCheck(context);
    listenToInternet(context);
  }

  @override
  void dispose() {
    Get.find<VMRootUiTest>().dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    lifeCycleChangeAction(state, context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ///This must be set to initialize sizes of screenutil
    ScreenUtil.init(context,
        designSize: Size(1080, 2340), allowFontScaling: true);

    /// This widget is when pressing on the screen the keyboard is removed
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: () async {
          return willExitApp(context);
        },
        child: Scaffold(
            primary: false,
            // resizeToAvoidBottomPadding: false,
            // resizeToAvoidBottomInset: true,
            // resizeToAvoidBottomPadding: false,
            backgroundColor: scafoldBackgroundColor,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                closeKeyboard(context);
              },
              child: Stack(
                children: <Widget>[
                      PreloadPageView(
                        children: _pages,
                        controller: Get.find<VMRootUiTest>().pageController,
                        preloadPagesCount: 2,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          if (Get.find<VMRootUiTest>().hideBars == true)
                            Get.find<VMRootUiTest>().hideBars = false;

                          // setState(() {
                          //   vmRootUi.pageIndex = index;
                          // });
                          Get.find<VMRootUiTest>().pageIndex = index;
                        },
                        pageSnapping: true,
                      ),
                  WdgtRootBottomBar(),
                  GetBuilder<VMRootUiTest>(builder: (vMRootUiTest) {
                    return vMRootUiTest.isNoInternet
                        ? WidgetNoConnection()
                        : SizedBox();
                  }),
                  GetBuilder<VMRootUiTest>(builder: (vMRootUiTest) {
                    return AnimatedSwitcher(
                    child: vMRootUiTest.hideBars ? SizedBox() : WdgtRootTopBar(),
                    duration: Duration(milliseconds: 303),
                  );
                  }),
 
                ],
              ),
            )),
      ),
    );
  }

  /// Get permission
  getNotificationPermission() async {}

  /// Get notifications settings for android and IOS

  setPushNotification() async {
    FirebaseMessaging _fcmFore = FirebaseMessaging();
    _fcmFore.getToken().then((token) {
      print('token is: ' + token);
    });

    await Future.delayed(Duration(seconds: 3));
    _fcmFore.requestNotificationPermissions(IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false));
    _fcmFore.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _fcmFore.configure(
      onMessage: (Map<String, dynamic> message) async {
        // await onNotificationMessage(message['data']['doc_id']);
        print(message);
        refreshResume(context);
        // pagesRefresh(context);
      },
      onResume: (Map<String, dynamic> message) async {
        refreshResume(context);
        // await Provider.of<VMRootData>(context).navigateBtwPages(context, 0);
      },
      // onBackgroundMessage: (Map<String, dynamic> message) async {
      //   refreshResume(context);
      //   // await Provider.of<VMRootData>(context).navigateBtwPages(context, 0);
      // },
      onLaunch: (Map<String, dynamic> message) async {
        await Future.delayed(Duration(seconds: onNotificationClickDuration));
        Get.find<VMRootUiTest>().pageController.jumpTo(1);
      },
    );
  }
}

/// [Durations] */
const int onNotificationClickDuration = 1;

///[Colors] */
///
final Color scafoldBackgroundColor = AppColors.purpleColor;
