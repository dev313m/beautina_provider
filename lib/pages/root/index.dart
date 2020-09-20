import 'dart:async';
import 'package:beauty_order_provider/constants/app_colors.dart';
import 'package:beauty_order_provider/constants/resolution.dart';
import 'package:beauty_order_provider/pages/refresh.dart';
import 'package:beauty_order_provider/pages/root/constants.dart';
import 'package:beauty_order_provider/pages/root/functions.dart';
import 'package:beauty_order_provider/pages/root/shared_variable_root.dart';
import 'package:beauty_order_provider/pages/root/ui.dart';
import 'package:beauty_order_provider/reusables/text.dart';
import 'package:beauty_order_provider/services/notification/push_notification.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPage createState() => _RootPage();
}

class _RootPage extends State<RootPage>
    with AutomaticKeepAliveClientMixin<RootPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // apiStatAppVisit();
  }

  setScreenResolution() {
    ScreenResolution.height = MediaQuery.of(context).size.height;
    ScreenResolution.width = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1496, allowFontScaling: false);

    setScreenResolution();

    super.build(context);
    return Index();
  }

  @override
  bool get wantKeepAlive => true;
}

class Index extends StatefulWidget {
  @override
  _Index createState() => _Index();
}

class _Index extends State<Index>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  PushNotification pu = PushNotification();
  PreloadPageController _pageController;

  int pageIndex = 3;
  int countNotifi = 0;
  Color iconColors = Colors.orangeAccent;
  List<Widget> _pages;

  StreamSubscription<ConnectivityResult> subscription;

  bool noInternet = false;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.index == ConnectivityResult.none.index) {
        noInternet = true;
      } else {
        // refreshApp(context);
        noInternet = false;
      }

      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
    asynInit();
    setPushNotification();
    //gettting the update
    // versionCheck(context);
    _pages = getMainPages();
  }

  asynInit() async {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    // await pu.startForeground(context, () {});
  }

  setPushNotification() async {
    FirebaseMessaging _fcmFore = FirebaseMessaging();
    _fcmFore.getToken().then((token) {
      print('token is: ' + token);
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
        // await Provider.of<SharedRoot>(context).navigateBtwPages(context, 0);
      },
      onLaunch: (Map<String, dynamic> message) async {
        await Future.delayed(Duration(seconds: 1));
        await Provider.of<SharedRoot>(context).navigateBtwPages(context, 1);
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
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

  Future<bool> willPop() async {
    if (Provider.of<SharedRoot>(context).pageController.page != 3) {
      Provider.of<SharedRoot>(context).pageController.jumpToPage(3);

      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double iconSize = height / 30;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: willPop,
        child: Scaffold(
            primary: false,
            resizeToAvoidBottomPadding: false,
            backgroundColor: AppColors.purpleColor,
            body: Stack(
              children: <Widget>[
                // FlareActor(
                //   'assets/rive/favoritebg.flr',
                //   fit: BoxFit.fitHeight,
                //   animation: 'rotate',
                // ),
                PreloadPageView(
                  children: _pages,
                  controller: getPageCntrl(context),
                  preloadPagesCount: 2,
                  physics: AlwaysScrollableScrollPhysics(),

                  ///the oage controller is shared bt all the pages so  they can all use it.
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    if (Provider.of<SharedRoot>(context).hideBars == true)
                      Provider.of<SharedRoot>(context).hideBars = false;

                    setState(() {
                      pageIndex = index;
                    });
                  },
                  pageSnapping: true,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ).createShader(
                            Rect.fromLTWH(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.overlay,
                      child: Container(
                        color: Colors.transparent,
                        height:
                            ScreenUtil().setHeight(ConstRootSizes.navigation),
                        width: ScreenResolution.width,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: Provider.of<SharedRoot>(context).hideBars
                              ? SizedBox()
                              : CurvedNavigationBar(
                                  backgroundColor: Colors.transparent,
                                  index: pageIndex,
                                  height: ScreenUtil()
                                      .setHeight(ConstRootSizes.navigation),
                                  items: <Widget>[
                                    Icon(CommunityMaterialIcons.settings,
                                        size: iconSize,
                                        color: ConstRootColors.icons),
                                    Stack(
                                      overflow: Overflow.visible,
                                      fit: StackFit.passthrough,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.notifications,
                                              size: iconSize,
                                              color: ConstRootColors.icons,
                                            )),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setHeight(40),
                                                  0,
                                                  0,
                                                  ScreenUtil().setHeight(40)),
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Provider.of<SharedRoot>(
                                                                context)
                                                            .notificationList
                                                            .where((n) =>
                                                                n.status == 0)
                                                            .length !=
                                                        0
                                                    ? new Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        constraints:
                                                            BoxConstraints(
                                                          minWidth: ScreenUtil()
                                                              .setWidth(14),
                                                          minHeight:
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                      14),
                                                        ),
                                                        child: ExtendedText(
                                                          string: Provider.of<
                                                                      SharedRoot>(
                                                                  context)
                                                              .notificationList
                                                              .where((n) =>
                                                                  n.status == 0)
                                                              .length
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.date_range,
                                      size: iconSize,
                                      color: ConstRootColors.icons,
                                    ),
                                    // Icon(
                                    //   CommunityMaterialIcons.gift,
                                    //   size: iconSize,
                                    //   color: ConstRootColors.icons,
                                    // ),

                                    Icon(CommunityMaterialIcons.spa_outline,
                                        size: iconSize,
                                        color: ConstRootColors.icons),
                                    // Icon(Icons.live_tv, size: iconSize, color: iconColors),
                                  ],
                                  color: Color(0xff0d3c61),
                                  buttonBackgroundColor: Color(0xff0d3c61),
                                  animationCurve: Curves.easeInOut,
                                  animationDuration:
                                      Duration(milliseconds: 600),
                                  onTap: (index) {
                                    setState(() {
                                      getPageCntrl(context).jumpToPage(index);
                                    });
                                  },
                                ),
                        ),
                      )),
                ),
                noInternet ? WidgetNoConnection() : SizedBox(),
                Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: Provider.of<SharedRoot>(context).hideBars
                            ? SizedBox()
                            : Container(
                                width: double.infinity,
                                height: ScreenUtil().setHeight(170),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color:
                                        AppColors.blueOpcity.withOpacity(0.9)),
                                child: Center(
                                    child: AnimatedSwitcher(
                                  // key: ValueKey('any'),
                                  duration: Duration(milliseconds: 500),
                                  child: getTitleWidget(context),
                                )),
                              ))),
              ],
            )),
      ),
    );
  }

  getTitleWidget(BuildContext context) {
    if (pageIndex == 3)
      return ExtendedText(
        key: ValueKey('value1'),
        string: '~ الصالون ~',
        fontSize: ExtendedText.xbigFont,
      );
    else if (pageIndex == 2)
      return ExtendedText(
        key: ValueKey('value1'),
        string: '~ المواعيد ~',
        fontSize: ExtendedText.xbigFont,
      );
    else if (pageIndex == 1)
      return ExtendedText(
          key: ValueKey('value2'),
          string: '~ الاشعارات ~',
          fontSize: ExtendedText.xbigFont);
    else
      return ExtendedText(
          key: ValueKey('value3'),
          string: '~ الاعدادات ~',
          fontSize: ExtendedText.xbigFont);
  }
}
