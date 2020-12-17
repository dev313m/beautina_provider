import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/shared_order_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

///order is canceled by customer or provider [status = 2]

///[color]
Color colorContainer = CalendarColors.orderDetailsBackground;

///[radius]
final double radius = radiusDefault;

///[edge]
final edgeContainer = 8.h;

class WidgetCanceledOrder extends StatelessWidget {
  final Order order;
  const WidgetCanceledOrder({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: ScreenResolution.width,
      decoration: BoxDecoration(
          color: colorContainer, borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: EdgeInsets.all(edgeContainer),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[WdgtDateSharedOrderDetails(order: order)],
        ),
      ),
    );
  }
}
