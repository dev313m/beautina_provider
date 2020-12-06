import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/shared_order_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

///order is canceled by customer or provider [status = 2]

///[color]
Color colorContainer = Colors.white24;

///[radius]
final double radius = 12;

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
