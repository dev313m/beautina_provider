import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:flare_flutter/flare_actor.dart';

///[colors]
Color colorContainerBg = Colors.black54;
Color colorIcon = Color(0xff862a5c);

///[size]
double sizeIcon = 400.sp;

/// [radius]
double radiusContainer = radiusDefault;

/// [String]
final strLocationAlert =
    'لم تقومي بتحديد موقعك في الخريطة، الرجاء الذهاب لصفحة الاعدادات والضغط على زر تحديد الخريطه';

class WdgtSalonLocationNotSet extends StatelessWidget {
  const WdgtSalonLocationNotSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusContainer),
          color: colorContainerBg,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 480.h,
              child: FlareActor(
                'assets/rive/error.flr',
                fit: BoxFit.contain,
                animation: 'idle',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0.h),
              child: GWdgtTextTitleDesc(
                string: strLocationAlert,
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ));
  }
}
