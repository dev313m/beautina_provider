import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[sizes]
final sizeDayHeight = 200.h;
final sizeDayWidth = 200.h;

///[radius]
final double radius = 12;

///[colors]

Color colorDay = Colors.white54;

///[edge]
double edgeDayToContainer = 20.w;
double edgeDayStr = 35.w;

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
                color: colorDay,
                borderRadius: BorderRadius.circular(radius)),
            // margin: const EdgeInsets.all(4.0),
            padding: EdgeInsets.only(
                top: edgeDayToContainer, left: edgeDayToContainer),
            width: sizeDayWidth,
            height: sizeDayHeight,
            child: (widget.date.day == DateTime.now().day &&
                    DateTime.now().month == widget.date.month)
                ? Center(
                  child: GWdgtTextCalendarDay(
                      string: "اليوم",
                    ),
                )
                : GWdgtTextCalendarDay(
                    string: '${widget.date.day}',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
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
