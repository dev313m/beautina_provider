import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtDateCalendarEventMarker extends StatelessWidget {
  final calendarController;
  final DateTime date;
  final List events;
  final Color color;
  const WdgtDateCalendarEventMarker(
      {Key key, this.date, this.calendarController, this.events, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(30),
      height: ScreenUtil().setWidth(30),
      child: ClipOval(
        child: AnimatedContainer(
          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            color: calendarController.isSelected(date)
                ? color
                : calendarController.isToday(date)
                    ? Colors.brown[300]
                    : color,
          ),
          // width: ScreenUtil().setWidth(16),
          // height: ScreenUtil().setWidth(16),
          child: Center(
            child: ExtendedText(
              string: '${events.length}',
            ),
          ),
        ),
      ),
    );
  }
}

///[colors]
const Color colorEventPressed = Colors.brown;
