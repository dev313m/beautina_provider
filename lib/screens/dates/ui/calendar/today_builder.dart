import 'package:beautina_provider/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[sizes]
final sizeDayHeight = 200.h;
final sizeDayWidth = 200.h;

///[radius]
final double radius = 12;

///[colors]

Color colorDay =AppColors.pinkBright .withOpacity(0.3);

///[edge]
double edgeDayToContainer = 4.w;
double edgeDayStr = 15.w;

class WdgtDateCalendarTodayBuilder extends StatelessWidget {
  final DateTime? date;
  const WdgtDateCalendarTodayBuilder({Key? key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorDay, borderRadius: BorderRadius.circular(radius)),
      margin: EdgeInsets.all(edgeDayToContainer),
      padding: EdgeInsets.only(top: edgeDayStr, left: edgeDayStr),
      width: sizeDayWidth,
      height: sizeDayHeight,
      child: GWdgtTextCalendarDay(
        string: 'اليوم: ${date!.day} ',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
      ),
    );
  }
}
