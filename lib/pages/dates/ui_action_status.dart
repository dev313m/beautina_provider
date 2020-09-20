import 'package:beauty_order_provider/constants/app_colors.dart';
import 'package:beauty_order_provider/constants/duration.dart';
import 'package:beauty_order_provider/constants/resolution.dart';
import 'package:beauty_order_provider/models/order.dart';
import 'package:beauty_order_provider/pages/dates/constants.dart';
import 'package:beauty_order_provider/pages/dates/functions.dart';
import 'package:beauty_order_provider/pages/dates/ui.dart';
import 'package:beauty_order_provider/reusables/animated_buttons.dart';
import 'package:beauty_order_provider/reusables/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetAction extends StatelessWidget {
  final Order order;
  const WidgetAction({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (order.status == 0) //new order
      return WidgetNewOrder(order: order);
    else if (order.status == 1) // order approved by provider
      return WidgetWaitingCustomer(order: order);
    else if (order.status == 2 ||
        order.status == 4) //order is canceled by customer
      return WidgetCanceledOrder(order: order);
    else if (order.status == 3) // order is confirmed by costomer
    {
      if (order.client_order_date.month == DateTime.now().month &&
          DateTime.now().day == order.client_order_date.day)
        return WidgetFinish(
          order: order,
        );
      return WidgetConfirmedOrder(order: order);
    } else if (order.status == 5 ||
        order.status == 6 ||
        order.status == 7 ||
        order.status == 8) return WidgetOnlyDisplay(order: order);
    return SizedBox();
  }
}

class WidgetWaitingCustomer extends StatelessWidget {
  final Order order;

  const WidgetWaitingCustomer({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSubmitButton(
      color: ConstDatesColors.cancelBtn,
      height: ScreenUtil().setHeight(100),
      width: ScreenResolution.width,
      insideWidget: ExtendedText(
        string: ConstDateStrings.cancel,
        fontSize: ExtendedText.bigFont,
      ),
      splashColor: AppColors.blue,
      animationDuration: Duration(milliseconds: durationCalender),
      function: getFunctionReject(order, context),
    );
  }
}

class WidgetConfirmedOrder extends StatelessWidget {
  final Order order;

  const WidgetConfirmedOrder({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSubmitButton(
      color: ConstDatesColors.cancelBtn,
      height: ScreenUtil().setHeight(100),
      width: ScreenResolution.width,
      insideWidget: ExtendedText(
        string: ConstDateStrings.cancel,
        fontSize: ExtendedText.bigFont,
      ),
      splashColor: AppColors.blue,
      animationDuration: Duration(milliseconds: durationCalender),
      function: getFunctionReject(order, context),
    );
  }
}

class WidgetNewOrder extends StatelessWidget {
  final Order order;
  final String providerNotes = '';

  const WidgetNewOrder({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: TextField(
                maxLength: 250,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                onChanged: (str) {
                  order.provider_notes = str;
                },
                decoration: InputDecoration(
                  hintText: 'ملاحظات (اختياري)',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  icon: Icon(CommunityMaterialIcons.pen),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            AnimatedSubmitButton(
              color: ConstDatesColors.confirmBtn,
              height: ScreenUtil().setHeight(100),
              width: ScreenResolution.width,
              insideWidget: ExtendedText(
                string: 'قبول',
                fontSize: ExtendedText.bigFont,
              ),
              splashColor: Colors.teal,
              animationDuration: Duration(milliseconds: durationCalender),
              function: getFunctionAccept(order, context),
            ),
            AnimatedSubmitButton(
              color: ConstDatesColors.cancelBtn,
              height: ScreenUtil().setHeight(100),
              width: ScreenResolution.width,
              insideWidget: ExtendedText(
                string: 'رفض',
                fontSize: ExtendedText.bigFont,
              ),
              splashColor: AppColors.blue,
              animationDuration: Duration(milliseconds: 700),
              function: getFunctionReject(order, context),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetOnlyDisplay extends StatelessWidget {
  final Order order;

  const WidgetOnlyDisplay({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class WidgetCanceledOrder extends StatelessWidget {
  final Order order;

  const WidgetCanceledOrder({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class WidgetFinish extends StatelessWidget {
  final Order order;
  final String providerNotes = '';

  const WidgetFinish({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: TextField(
                maxLength: 250,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                onChanged: (str) {
                  order.provider_notes = str;
                },
                decoration: InputDecoration(
                  hintText: 'ملاحظات (اختياري)',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  icon: Icon(CommunityMaterialIcons.pen),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            AnimatedSubmitButton(
              color: ConstDatesColors.confirmBtn,
              height: ScreenUtil().setHeight(100),
              width: ScreenResolution.width,
              insideWidget: ExtendedText(
                string: 'تم عمل الخدمة بنجاح',
                fontSize: ExtendedText.bigFont,
              ),
              splashColor: Colors.teal,
              animationDuration: Duration(milliseconds: 700),
              function: getFunctionFinishedComplete(order, context),
            ),
            AnimatedSubmitButton(
              color: ConstDatesColors.cancelBtn,
              height: ScreenUtil().setHeight(100),
              width: ScreenResolution.width,
              insideWidget: ExtendedText(
                string: 'لم يتم عمل الخدمه بنجاح',
                fontSize: ExtendedText.bigFont,
              ),
              splashColor: AppColors.blue,
              animationDuration: Duration(milliseconds: durationCalender),
              function: getFunctionFinishedIncomplete(order, context),
            )
          ],
        ),
      ),
    );
  }
}
