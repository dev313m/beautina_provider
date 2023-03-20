import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[sizes]
final sizeBadge = 30.h;

///[edge]
double edgeBadgeText = 5.h;

class WdgtDateCalendarEventMarker extends StatelessWidget {
  final calendarController;
  final DateTime? date;
  final List? events;
  final Color? color;
  const WdgtDateCalendarEventMarker(
      {Key? key, this.date, this.calendarController, this.events, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeBadge,
      height: sizeBadge,
      child: ClipOval(
        child: AnimatedContainer(
          padding: EdgeInsets.all(ScreenUtil().setWidth(edgeBadgeText)),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            color: color,
          ),
          // width: ScreenUtil().setWidth(16),
          // height: ScreenUtil().setWidth(16),
          child: Center(
            child: GWdgtTextBadge(
              string: '${events!.length}',
            ),
          ),
        ),
      ),
    );
  }
}
