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
import 'package:beautina_provider/utils/size/edge_padding.dart';

///When order is submitted by user but outdated [status = 3 ]
class WidgetOutdatedOrder extends StatefulWidget {
  final Order order;

  const WidgetOutdatedOrder({Key key, this.order}) : super(key: key);

  @override
  _WidgetOutdatedOrderState createState() => _WidgetOutdatedOrderState();
}

class _WidgetOutdatedOrderState extends State<WidgetOutdatedOrder> {
  final String providerNotes = '';
  final RoundedLoadingButtonController _cancelButtonController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _submitButtonController =
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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RoundedLoadingButton(
                      color: colorButtonAccept,
                      height: 250.h,
                      // width: sizeButtonHeight,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GWdgtTextButton(
                              string: "تم عمل الخدمة بنجاح",
                            ),
                            Icon(Icons.done, color: Colors.white54),
                          ],
                        ),
                      ),
                      controller: _submitButtonController,
                      animateOnTap: true,
                      // borderRadius: radius,
                      onPressed: () async {
                        bool result = false;
                        _submitButtonController.start();

                        // _buttonController.start();
                        result = await getFunctionFinishedComplete(
                            widget.order, context);
                        if (result)
                          _submitButtonController.success();
                        else
                          _submitButtonController.error();

                        await Future.delayed(Duration(seconds: 1));
                        _submitButtonController.reset();
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: RoundedLoadingButton(
                      color: colorButtonReject,
                      height: 250.h,
                      // width: sizeButtonHeight,
                      controller: _cancelButtonController,
                      animateOnTap: true,
                      // borderRadius: radius,
                      child: GWdgtTextButton(string: "لم يتم عمل الخدمة بنجاح"),
                      onPressed: () async {
                        bool result = false;
                        _cancelButtonController.start();

                        // _buttonController.start();
                        result = await getFunctionFinishedIncomplete(
                            widget.order, context);
                        if (result)
                          _cancelButtonController.success();
                        else
                          _cancelButtonController.error();
                        await Future.delayed(Duration(seconds: 1));
                        _cancelButtonController.reset();
                      },
                    ),
                  ),
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
Color colorContainer = CalendarColors.orderDetailsBackground;

Color colorButtonReject = ConstDatesColors.cancelBtn;
Color colorButtonAccept = ConstDatesColors.confirmBtn;

///[radius]
final double radius = radiusDefault;

///[edge]
final edgeContainer = 8.h;
