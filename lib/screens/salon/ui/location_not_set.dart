import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtSalonLocationNotSet extends StatelessWidget {
  const WdgtSalonLocationNotSet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white30,
        ),
        child: Column(
          children: <Widget>[
            Icon(Icons.error_outline, color: Colors.red, size: ScreenUtil().setHeight(200)),
            Padding(
              child: ExtendedText(
                string: 'لم تقومي بتحديد موقعك في الخريطة، الرجاء الذهاب لصفحة الاعدادات والضغط على زر تحديد الخريطه',
                fontSize: ExtendedText.xbigFont,
              ),
              padding: EdgeInsets.all(8.h),
            )
          ],
        ));
  }
}
