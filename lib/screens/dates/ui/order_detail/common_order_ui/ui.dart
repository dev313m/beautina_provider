import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:spring_button/spring_button.dart';

///for example [صالون [حناء]]
///[string]

final strInfo = 'معلومات الخدمه:';
final strPrice = 'السعر';
final strDate = 'وقت الموعد';
final strLocation = 'الموقع';

///[colors]
Color color = Colors.white54;

class AllSingleServiceWidget extends StatelessWidget {
  final Map<String, dynamic>? services;
  const AllSingleServiceWidget({Key? key, this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      int index = 0;

      return Row(
        textDirection: TextDirection.rtl,
        // verticalDirection: VerticalDirection.down,
        // direction: Axis.horizontal,
        children: services!.keys.map((key) {
          index++;
          if (index == 1)
            return Container(
                padding: EdgeInsets.all(30.w),
                decoration: BoxDecoration(
                  // color: Colors.white12,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: GWdgtTextChip(
                  string: key,
                ));
          else
            return Row(
              children: [
                Container(
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                      // color: Colors.white12,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: GWdgtTextChip(
                      string: key,
                    )),
                CustomDivider(
                  color: Colors.white30,
                  height: 30.h,
                ),
              ],
            );
        }).toList(),
      );
    });
  }
}

class OrderDetails extends StatelessWidget {
  final DateTime? date;
  final int? price;
  final Color? backgroundColor;
  final List<dynamic>? location;
  final String? phoneNum;
  OrderDetails(
      {Key? key,
      this.date,
      this.location,
      this.phoneNum,
      this.price,
      this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return SizedBox();

    return Container(
      // height: 230.h ,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: muteRowCell(
                    price.toString() + " ريال",
                    strPrice,
                    CommunityMaterialIcons.sack,
                    getWhatsappFunction(phoneNum),
                    backgroundColor),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 1,
                child: muteRowCell(
                    getStrTime(date!),
                    date!.day.toString() +
                        "-" +
                        date!.month.toString() +
                        "-" +
                        date!.year.toString(),
                    Icons.date_range,
                    getWhatsappFunction(phoneNum),
                    backgroundColor),
              ),
              SizedBox(
                width: 10.w,
              ),
              if (location != null && location!.length != 0)
                Expanded(
                    flex: 1,
                    child: muteRowCell(
                        ' ',
                        strLocation,
                        CommunityMaterialIcons.map_marker_circle,
                        getLaunchMapFunction(location!),
                        backgroundColor)),
              if (location != null && location!.length != 0)
                SizedBox(
                  width: 10.w,
                ),
              Expanded(
                flex: 1,
                child: muteRowCell(phoneNum, 'رقم الجوال', Icons.phone,
                    getWhatsappFunction(phoneNum), backgroundColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget muteRowCell(String? desc, String type, IconData icon, Function function,
    Color? backgroundColor) {
  return SpringButton(
    SpringButtonType.OnlyScale,
    Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),

      // w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundColor),
      child: new Column(
        children: <Widget>[
          IconButton(
            icon: Icon(
              icon,
              size: 80.sp,
              color: color,
            ),
            onPressed: () async {},
            splashColor: color,
            color: color,
            tooltip: type,
          ),
          new GWdgtTextSmall(
            string: '$desc',
            // fontColor: Colors.orangeAccent,
          ),
          new GWdgtTextSmall(
            string: type,
            // fontColor: Colors.orangeAccent,
          )
        ],
      ),
    ),
    onTap: () async {
      await function();
    },
    scaleCoefficient: 0.87,
  );
}

Widget dateRow(
    DateTime dateTime, String type, IconData icon, Function function) {
  return SpringButton(
    SpringButtonType.OnlyScale,
    Container(
      padding: EdgeInsets.symmetric(vertical: 44.h),

      // w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: Colors.black38),
      child: new Column(
        children: <Widget>[
          IconButton(
            icon: Icon(
              icon,
              // size: ScreenUtil().setSp(40),
              color: color,
            ),
            onPressed: () async {},
            splashColor: color,
            color: color,
            tooltip: type,
          ),
          new RichText(
              text: TextSpan(children: [
            TextSpan(text: dateTime.hour.toString()),
            TextSpan(text: ":"),
            TextSpan(text: dateTime.minute.toString())
          ]))
          // new GWdgtTextSmall(
          //   string: type,
          //   // fontColor: Colors.orangeAccent,
          // )
        ],
      ),
    ),
    onTap: () async {
      await function();
    },
    scaleCoefficient: 0.87,
  );
}

class WdgtDateCalendarWatch extends StatelessWidget {
  final DateTime? dateTime;
  final String? type;
  final IconData? icon;
  final Color? backgroundColor;
  final Function? function;
  const WdgtDateCalendarWatch(
      {Key? key,
      this.dateTime,
      this.function,
      this.icon,
      this.type,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      Container(
        padding: EdgeInsets.symmetric(vertical: 44.h),

        // w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor),
        child: new Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                icon,
                // size: ScreenUtil().setSp(40),
                color: color,
              ),
              onPressed: () async {},
              splashColor: color,
              color: color,
              tooltip: type,
            ),
            new RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: dateTime!.hour.toString(),
                  style: TextStyle(fontSize: 50.sp, color: Colors.amber)),
              TextSpan(text: ":", style: TextStyle(fontSize: 30.sp)),
              TextSpan(
                  text: dateTime!.minute.toString(),
                  style:
                      TextStyle(fontSize: 50.sp, color: Colors.lightBlueAccent))
            ]))
            // new GWdgtTextSmall(
            //   string: type,
            //   // fontColor: Colors.orangeAccent,
            // )
          ],
        ),
      ),
      onTap: () async {
        await function!();
      },
      scaleCoefficient: 0.87,
    );
  }
}

final double radius = radiusDefault;

String getStrTime(DateTime date) {
  return date.hour > 12
      ? '${date.hour}:${date.minute} م'
      : '${date.hour}:${date.minute} ص';
}
