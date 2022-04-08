import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/utils/ui/text.dart';
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

double radius = radiusDefault;
