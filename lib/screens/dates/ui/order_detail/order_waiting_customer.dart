import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/shared_order_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

/// order approved by provider [status = 1]
class WidgetWaitingCustomer extends StatefulWidget {
  final Order order;

  const WidgetWaitingCustomer({Key key, this.order}) : super(key: key);

  @override
  _WidgetWaitingCustomerState createState() => _WidgetWaitingCustomerState();
}

class _WidgetWaitingCustomerState extends State<WidgetWaitingCustomer> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenResolution.width,
      decoration: BoxDecoration(
          color: colorContainer, borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: EdgeInsets.all(edgeContainer),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            WdgtDateSharedOrderDetails(order: widget.order),
            RoundedLoadingButton(
              color: colorButtonReject,
              height: sizeButtonHeight,
              // width: 400,
              controller: _buttonController,

              animateOnTap: true,
              borderRadius: radius,
              child: GWdgtTextButton(string: 'رفض'),
              onPressed: () async {
                bool result = false;
                _buttonController.start();
                result = await getFunctionReject(widget.order, context);
                if (result)
                  _buttonController.success();
                else
                  _buttonController.error();
              },
            ),
          ],
        ),
      ),
    );
  }
}

///[size]
double sizeButtonHeight = 100.h;

///[color]
Color colorContainer = Colors.white24;
Color colorButtonReject = ConstDatesColors.cancelBtn;

///[radius]
final double radius = 12;

///[edge]
final edgeContainer = 8.h;
