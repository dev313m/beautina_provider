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

///When order is submitted by user but outdated [status = 3 ]
class WidgetOutdatedOrder extends StatefulWidget {
  final Order order;

  const WidgetOutdatedOrder({Key key, this.order}) : super(key: key);

  @override
  _WidgetOutdatedOrderState createState() => _WidgetOutdatedOrderState();
}

class _WidgetOutdatedOrderState extends State<WidgetOutdatedOrder> {
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final String providerNotes = '';

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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: <Widget>[
                  RoundedLoadingButton(
                      color: ConstDatesColors.cancelBtn,
                      height: sizeButtonHeight,
                      width: sizeButtonHeight,
                      controller: _buttonController,
                      animateOnTap: true,
                      borderRadius: radius,
                      child: GWdgtTextButton(string: "تم عمل الخدمة بنجاح"),
                      onPressed: () async {
                        bool result = false;
                        _buttonController.start();

                        // _buttonController.start();
                        result = await getFunctionFinishedComplete(
                            widget.order, context);

                        if (result)
                          _buttonController.success();
                        else
                          _buttonController.error();
                      }),
                  RoundedLoadingButton(
                      color: ConstDatesColors.cancelBtn,
                      height: sizeButtonHeight,
                      width: sizeButtonHeight,
                      controller: _buttonController,
                      animateOnTap: true,
                      borderRadius: radius,
                      child: GWdgtTextButton(string: "لم يتم عمل الخدمة بنجاح"),
                      onPressed: () async {
                        bool result = false;
                        _buttonController.start();

                        // _buttonController.start();
                        result = await getFunctionFinishedIncomplete(
                            widget.order, context);

                        if (result)
                          _buttonController.success();
                        else
                          _buttonController.error();
                      })
                ],
              ),
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
Color colorButtonAccept = ConstDatesColors.confirmBtn;

///[radius]
final double radius = 12;

///[edge]
final edgeContainer = 8.h;
