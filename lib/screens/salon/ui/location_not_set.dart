import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///[colors]
Color colorContainerBg = Colors.white38;
Color colorIcon = Colors.red;

///[size]
double sizeIcon = ScreenUtil().setHeight(200);

/// [radius]
const double radiusContainer = 14;

/// [String]
final strLocationAlert = 'لم تقومي بتحديد موقعك في الخريطة، الرجاء الذهاب لصفحة الاعدادات والضغط على زر تحديد الخريطه';

class WdgtSalonLocationNotSet extends StatelessWidget {
  const WdgtSalonLocationNotSet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorContainerBg,
        ),
        child: Column(
          children: <Widget>[
            Icon(Icons.error_outline, color: colorIcon, size: sizeIcon),
            GWdgtTextTitleDesc(
              string: strLocationAlert,
            )
          ],
        ));
  }
}
