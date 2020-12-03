import 'dart:io';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WdgtRootBottomBar extends StatefulWidget {
  WdgtRootBottomBar({Key key}) : super(key: key);

  @override
  _WdgtRootBottomBarState createState() => _WdgtRootBottomBarState();
}

class _WdgtRootBottomBarState extends State<WdgtRootBottomBar> {
  @override
  Widget build(BuildContext context) {
    VMRootUi vmRootUi = Provider.of<VMRootUi>(context);
    VMRootData vmRootData = Provider.of<VMRootData>(context);

    double height = MediaQuery.of(context).size.height;
    double iconSize = height / 30;

    EdgeInsets si = MediaQuery.of(context).padding;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.transparent,
        height: ConstRootSizes.navigation.h + 90.h,
        width: ScreenResolution.width,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: vmRootUi.hideBars
              ? SizedBox()
              : CurvedNavigationBar(
                  backgroundColor: Colors.transparent,
                  index: vmRootUi.pageIndex,
                  height:
                      ScreenUtil().setHeight(ConstRootSizes.navigation + 75.h),
                  items: <Widget>[
                    Icon(CommunityMaterialIcons.settings,
                        size: iconSize, color: ConstRootColors.icons),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setHeight(40),
                                  0,
                                  0,
                                  ScreenUtil().setHeight(40)),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: vmRootData.notificationList
                                            .where((n) => n.status == 0)
                                            .length !=
                                        0
                                    ? new Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: ScreenUtil().setWidth(14),
                                          minHeight: ScreenUtil().setHeight(14),
                                        ),
                                        child: ExtendedText(
                                          string:
                                              Provider.of<VMRootData>(context)
                                                  .notificationList
                                                  .where((n) => n.status == 0)
                                                  .length
                                                  .toString(),
                                          textAlign: TextAlign.center,
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
                        size: iconSize, color: ConstRootColors.icons),
                    // Icon(Icons.live_tv, size: iconSize, color: iconColors),
                  ],
                  color: Color(0xff0d3c61),
                  buttonBackgroundColor: Color(0xff0d3c61),
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 600),
                  onTap: (index) {
                    setState(() {
                      vmRootUi.pageController.jumpToPage(index);
                    });
                  },
                ),
        ),
      ),
    );
  }
}
