import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[sizes]
final sizeDayHeight = 100.h;
final sizeDayWidth = 100.h;

///[radius]
final double radius = 12;

///[colors]

Color colorDay = Colors.white38;

///[edge]
double edgeDayToContainer = 4.h;
double edgeDayStr = 10.w;

class WdgtDateCalendarTodayBuilder extends StatelessWidget {
  final DateTime date;
  const WdgtDateCalendarTodayBuilder({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorDay, borderRadius: BorderRadius.circular(radius)),
      margin: EdgeInsets.all(edgeDayToContainer),
      padding: EdgeInsets.only(top: edgeDayStr, left: edgeDayStr),
      width: sizeDayWidth,
      height: sizeDayHeight,
      child: GWdgtTextCalendarDay(
        string: 'اليوم: ${date.day} ',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
      ),
    );
  }
}
