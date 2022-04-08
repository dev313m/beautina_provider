import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/shared_order_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

/// order approved by provider [status = 1]
class WidgetWaitingCustomer extends StatefulWidget {
  final Order? order;

  const WidgetWaitingCustomer({Key? key, this.order}) : super(key: key);

  @override
  _WidgetWaitingCustomerState createState() => _WidgetWaitingCustomerState();
}

class _WidgetWaitingCustomerState extends State<WidgetWaitingCustomer> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(edgeContainer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center ,
        children: <Widget>[
          Container(
            child: WdgtDateSharedOrderDetails(order: widget.order),
            decoration: BoxDecoration(
                color: colorContainer,
                borderRadius: BorderRadius.circular(radius)),
          ),
          Y(
            height: 0.08.sh,
          ),
          ClipOval(
            child: Container(
              height: 200.h,
              width: 200.h,
              child: RoundedLoadingButton(
                color: Colors.transparent,
                height: 200.h,
                width: 200.h,
                // width: sizeButtonHeight,
                animateOnTap: true,
                borderRadius: radius,
                child: Center(
                    child: Icon(
                  Icons.cancel_outlined,
                  color: AppColors.pinkOpcity,
                  size: 100.sp,
                )),
                controller: _buttonController,

                onPressed: () async {
                  bool result = false;
                  _buttonController.start();

                  // _buttonController.start();
                  result = await getFunctionReject(widget.order!, context);
                  if (result)
                    _buttonController.success();
                  else
                    _buttonController.error();
                  await Future.delayed(Duration(seconds: 1));
                  _buttonController.reset();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///[size]
double sizeButtonHeight = 100.h;

///[color]
Color colorContainer = CalendarColors.orderDetailsBackground;
Color colorButtonReject = ConstDatesColors.cancelBtn;

///[radius]
final double radius = radiusDefault;

///[edge]
final edgeContainer = 8.h;
