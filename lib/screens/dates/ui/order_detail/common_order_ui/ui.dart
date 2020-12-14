import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///for example [صالون [حناء]]
///[string]

final strInfo = 'معلومات الخدمه:';
final strPrice = 'السعر';
final strDate = 'وقت الموعد';

///[colors]
Color color = Colors.yellow;

class AllSingleServiceWidget extends StatelessWidget {
  final Map<String, dynamic> services;
  const AllSingleServiceWidget({Key key, this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      List<String> list = [];
      Map<String, dynamic> mapper =
          Provider.of<VMSalonData>(context).providedServices;

      services.forEach((k, v) {
        v.forEach((kk, vv) {
          if (k == 'other')
            list.add(kk.toString());
          else
            try {
              list.add(mapper['services'][k]['items'][kk]['ar']);
            } catch (e) {
              list.add(k);
            }
        });
      });
      return Wrap(
        textDirection: TextDirection.rtl,
        // verticalDirection: VerticalDirection.down,
        // direction: Axis.horizontal,
        children: list
            .map((f) => Chip(
                    label: GWdgtTextChip(
                  string: f,
                )))
            .toList(),
      );
    });
  }
}

class OrderDetails extends StatelessWidget {
  final DateTime date;
  final int price;
  final List<dynamic> location;
  final String phoneNum;
  OrderDetails({Key key, this.date, this.location, this.phoneNum, this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return SizedBox();

    return Container(
      width: 900,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: muteRowCell(getDateString(date), strDate, Icons.date_range,
                getWhatsappFunction(phoneNum)),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 1,
            child: muteRowCell(
                price.toString() + ' SR', strPrice, Icons.attach_money, () {}),
          ),
        ],
      ),
    );
  }
}

Widget muteRowCell(
    String count, String type, IconData icon, Function function) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 44.h),
    // w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), color: Colors.black38),
    child: new Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            icon,
            // size: ScreenUtil().setSp(40),
            color: color,
          ),
          onPressed: () async {
            await function();
          },
          splashColor: color,
          color: color,
          tooltip: type,
        ),
        new GWdgtTextSmall(
          string: '$count',
          // fontColor: Colors.orangeAccent,
        ),
        new GWdgtTextSmall(
          string: type,
          // fontColor: Colors.orangeAccent,
        )
      ],
    ),
  );
}
