import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/current.dart';

///[colors]
Color colorContainerBg = Colors.white38;
Color colorIcon = Colors.red;

///[size]
double sizeIcon = 400.sp;

/// [radius]
double radiusContainer = radiusDefault;

/// [String]
final strLocationAlert = 'لم تقومي بتحديد موقعك في الخريطة، الرجاء الذهاب لصفحة الاعدادات والضغط على زر تحديد الخريطه';

class WdgtSalonLocationNotSet extends StatelessWidget {
  const WdgtSalonLocationNotSet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusContainer),
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
