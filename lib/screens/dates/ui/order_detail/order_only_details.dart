import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/shared_order_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetOnlyDetailsOrder extends StatefulWidget {
  final Order order;

  const WidgetOnlyDetailsOrder({Key key, this.order}) : super(key: key);

  @override
  _WidgetOnlyDetailsOrderState createState() => _WidgetOnlyDetailsOrderState();
}

class _WidgetOnlyDetailsOrderState extends State<WidgetOnlyDetailsOrder> {
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
          children: <Widget>[WdgtDateSharedOrderDetails(order: widget.order)],
        ),
      ),
    );
  }
}

///[color]
Color colorContainer = Colors.white24;

///[radius]
final double radius = 12;

///[edge]
final edgeContainer = 8.h;
