import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtRootTopBar extends StatefulWidget {
  WdgtRootTopBar({Key? key}) : super(key: key);

  @override
  _WdgtRootTopBarState createState() => _WdgtRootTopBarState();
}

class _WdgtRootTopBarState extends State<WdgtRootTopBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius)),
          child: Container(
            height: heightTopBar,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 60.h),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  color: AppColors.blueOpcity.withOpacity(0.9)),
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: getTitleWidget(
                      context, Get.find<VMRootUiTest>().pageIndex),
                ),
              ),
            ),
          ),
        ));
  }

  getTitleWidget(BuildContext context, pageIndex) {
    if (pageIndex == 4)
      return GWdgtTextNavTitle(
        key: ValueKey('value0'),
        string: '~ خدمات الصالون ~',
      );
    else if (pageIndex == 3)
      return GWdgtTextNavTitle(
        key: ValueKey('value1'),
        string: '~ الطلبات ~',
      );
    else if (pageIndex == 2)
      return GWdgtTextNavTitle(
        key: ValueKey('value2'),
        string: '~ العروض والجوائز ~',
      );
    else if (pageIndex == 1)
      return GWdgtTextNavTitle(
        key: ValueKey('value2'),
        string: '~ الاشعارات ~',
      );
    else
      return GWdgtTextNavTitle(
        key: ValueKey('value3'),
        string: '~ اعدادات الحساب ~',
      );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          // padding: EdgeInsets.only(top:106.h),
          height: ScreenUtil().setHeight(420),
          child: Material(
              borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: AppColors.blue,
              child: Column(
                children: [
                  // Y(height: 96.h),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          "assets/images/official_logo_e.png",
                        ),
                      ),
                      SizedBox(width: 20 * 0.75),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GWdgtTextNavTitle(
                            string: 'بيوتينا',
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Obx(() {
                        return Container(
                          height: 120.h,
                          width: 120.h,
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: Icon(CupertinoIcons.chat_bubble),
                                    iconSize: 60.sp,
                                    onPressed: () async {
                                      // Get.to(() => PageChatRooms(
                                      //   providerId: null,
                                      //   providerToken: null,
                                      // ));
                                    },
                                  )),
                              // if (Get.find<VMChatRooms>().chatRooms.value !=
                              //     null)
                              //   Column(
                              //     mainAxisSize: MainAxisSize.min,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: <Widget>[
                              //       Padding(
                              //         padding: EdgeInsets.fromLTRB(
                              //             ScreenUtil().setHeight(40),
                              //             0,
                              //             0,
                              //             ScreenUtil().setHeight(40)),
                              //         child: Align(
                              //             alignment: Alignment.topCenter,
                              //             child: GWdgtBadge(
                              //               number: Get.find<VMChatRooms>()
                              //                   .newMessages
                              //                   .value,
                              //             )),
                              //       ),
                              //     ],
                              //   )
                            ],
                          ),
                        );
                      }),
                      // IconButton(
                      //   icon: Icon(CupertinoIcons.chat_bubble),
                      //   iconSize: 60.sp,
                      //   onPressed: () async {
                      //     Get.to(() => PageChatRooms());
                      //   },
                      // ),
                      IconButton(
                        icon: Icon(CupertinoIcons.bell),
                        onPressed: () async {
                          // Get.to(() => PageNotification());
                        },
                        iconSize: 60.sp,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                ],
              ))),
    );
  }
}

double radius = radiusDefault;
