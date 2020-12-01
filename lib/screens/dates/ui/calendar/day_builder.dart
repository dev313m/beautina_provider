import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtDateCalendarDayBuilder extends StatelessWidget {
  final List list;
  final DateTime date;

  const WdgtDateCalendarDayBuilder({Key key, this.date, this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: list
                          .where((item) =>
                              item.status == 0 ||
                              item.status == 1 ||
                              item.status == 3)
                          .toList()
                          .length ==
                      0
                  ? CalendarColors.empty
                  : CalendarColors.eventColor,
              borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setHeight(100),
          child: ExtendedText(
            string: '${date.day}',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            fontSize: ExtendedText.bigFont,
            fontColor: Colors.white38,
            // style: TextStyle().copyWith(fontSize: 16.0),
          ),
        ),
        if (list.where((element) => element.status == -1).length > 0)
          Align(
            alignment: Alignment.center,
            child: Icon(CommunityMaterialIcons.lock),
          )
      ],
    );
  }
}
