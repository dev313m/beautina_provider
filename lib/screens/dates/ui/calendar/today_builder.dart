import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtDateCalendarTodayBuilder extends StatelessWidget {
  final DateTime date;
  const WdgtDateCalendarTodayBuilder({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CalendarColors.todayContainer,
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(100),
      child: ExtendedText(
        string: 'اليوم: ${date.day} ',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
        fontSize: ExtendedText.bigFont,
        fontColor: Colors.black54,
      ),
    );
  }
}
