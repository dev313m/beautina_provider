import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:beautina_provider/constants/app_colors.dart';

///[sizes]
final sizeDayHeight = 200.h;
final sizeDayWidth = 200.h;

///[radius]
final double radius = 25;

///[colors]
Color colorNoEvent = Colors.amber.withOpacity(0.1);
Color colorEvent = CalendarColors.eventColor;
Color colorDay = Colors.amber.withOpacity(0.6);

///[edge]
double edgeDayToContainer = 4.w;
double edgeDayStr = 15.w;

class WdgtDateCalendarDayBuilder extends StatelessWidget {
  final List? list;
  final DateTime? date;

  const WdgtDateCalendarDayBuilder({Key? key, this.date, this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(

                ///if there is no event then add orginal color
                color: list!
                            .where((item) =>
                                item.status == 0 ||
                                item.status == 1 ||
                                item.status == 3)
                            .toList()
                            .length ==
                        0
                    ? colorNoEvent
                    : colorEvent,
                borderRadius: BorderRadius.circular(radius)),
            margin: EdgeInsets.all(edgeDayToContainer),
            // padding: EdgeInsets.only(top: edgeDayStr, left: edgeDayStr),
            width: sizeDayHeight,
            height: sizeDayHeight,
            child: Center(
              child: GWdgtTextCalendarDay(
                string: '${date!.day}',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                color: Colors.amber.withOpacity(0.7),
                // style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          ),
        ),
        // if (list!.where((element) => element.status == -1).length > 0)
        //   Align(
        //     alignment: Alignment.center,
        //     child: Icon(CommunityMaterialIcons.lock),
        //   )
      ],
    );
  }
}
