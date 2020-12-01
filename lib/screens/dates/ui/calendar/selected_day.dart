import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtDateCalendarSelectedDay extends StatefulWidget {
  final DateTime date;
  final List list;
  final AnimationController animationController;
  const WdgtDateCalendarSelectedDay(
      {Key key, this.date, this.list, this.animationController})
      : super(key: key);

  @override
  _WdgtDateCalendarSelectedDayState createState() =>
      _WdgtDateCalendarSelectedDayState();
}

class _WdgtDateCalendarSelectedDayState
    extends State<WdgtDateCalendarSelectedDay> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(widget.animationController),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: CalendarColors.todayContainer,
                borderRadius: BorderRadius.circular(12)),
            // margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setHeight(100),
            child: ExtendedText(
              string: '${widget.date.day}',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              fontSize: ExtendedText.bigFont,
              fontColor: Colors.white,
              // style: TextStyle().copyWith(fontSize: 16.0),
            ),
          ),
          if (widget.list != null)
            if (widget.list.where((element) => element.status == -1).length > 0)
              Align(
                alignment: Alignment.center,
                child: Icon(CommunityMaterialIcons.lock),
              )
        ],
      ),
    );
  }
}
