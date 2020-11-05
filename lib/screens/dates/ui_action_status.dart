import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui.dart';
import 'package:beautina_provider/reusables/animated_buttons.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_picker/Picker.dart';
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

class WidgetNewOrder extends StatefulWidget {
  final Order order;

  const WidgetNewOrder({Key key, this.order}) : super(key: key);

  @override
  _WidgetNewOrderState createState() => _WidgetNewOrderState();
}

class _WidgetNewOrderState extends State<WidgetNewOrder> {
  final String providerNotes = '';
  TextEditingController durationTextFieldController =
      TextEditingController(text: 'لم يتم التحديد');

  Duration orderDuration = Duration();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(0)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                maxLength: 250,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                onChanged: (str) {
                  widget.order.provider_notes = str;
                },
                decoration: InputDecoration(
                  hintText: 'ملاحظات (اختياري)',
                  filled: true,
                  fillColor: Colors.white24,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  icon: Icon(CommunityMaterialIcons.pen),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // fillColor: Colors.white,
                ),
              ),
            ),
            Container(
                width: double.infinity,
                child: ExtendedText(
                    string: 'المدة المتوقعة للطلب:  ',
                    textAlign: TextAlign.right)),
            Container(
              // width: 200.w,
              child: TextField(
                controller: durationTextFieldController,
                readOnly: true,
                onTap: () {
                  Picker picker;

                  picker = Picker(
                      // backgroundColor: Colors.pink.withOpacity(0.3),
                      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
                        const NumberPickerColumn(
                            begin: 0, end: 60, suffix: Text(' دق'), jump: 15),
                        const NumberPickerColumn(
                            begin: 0,
                            end: 12,
                            suffix: Text(' ساعات'),
                            columnFlex: 2),
                      ]),
                      delimiter: <PickerDelimiter>[
                        PickerDelimiter(
                          child: Container(
                            width: 30.0.h,
                            alignment: Alignment.center,
                            child: Icon(Icons.more_vert),
                          ),
                        )
                      ],
                      hideHeader: false,
                      confirmTextStyle: TextStyle(
                          inherit: false, color: Colors.red, fontSize: 22),
                      // title: Text(
                      //   'الوقت المتوقع لإنهاء الخدمة',
                      //   textAlign: TextAlign.right,
                      // ),
                      containerColor: Colors.pink,
                      selectedTextStyle: TextStyle(color: Colors.blue),
                      onConfirm: (Picker picker, List<int> value) {
                        // You get your duration here
                        orderDuration = Duration(
                            hours: picker.getSelectedValues()[1],
                            minutes: picker.getSelectedValues()[0]);
                        // picker.doCancel(context);
                        durationTextFieldController.text =
                            " ${(orderDuration.inHours).toString()} ساعة ${(orderDuration.inMinutes.remainder(60)).toString()} دقيقة ";
                        // showToast(orderDuration.inMinutes.toString());

                        widget.order.order_duration =
                            orderDuration.inMinutes.toDouble();
                        setState(() {});
                      },
                      cancel: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          picker.doCancel(context);
                        },
                      ),
                      confirm: IconButton(
                        icon: Icon(
                          Icons.done,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          picker.doConfirm(context);
                        },
                      ),
                      cancelTextStyle: TextStyle(color: Colors.red),
                      textStyle: TextStyle(color: Colors.blue));
                  picker.showModal(context);
                },
                decoration: InputDecoration(
                  hintText:
                      ' ${(orderDuration.inHours).toString()} ساعة ${(orderDuration.inMinutes.remainder(60)).toString()} دقيقة ',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  icon: Icon(CommunityMaterialIcons.watch),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.white70,
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Row(
              children: [
                Expanded(
                  child: AnimatedSubmitButton(
                    color: ConstDatesColors.confirmBtn,
                    height: ScreenUtil().setHeight(100),
                    width: ScreenResolution.width / 3,
                    insideWidget: ExtendedText(
                      string: 'قبول',
                      fontSize: ExtendedText.bigFont,
                    ),
                    splashColor: Colors.teal,
                    animationDuration: Duration(milliseconds: durationCalender),
                    function: getFunctionAccept(widget.order, context),
                  ),
                ),
                Expanded(
                  child: AnimatedSubmitButton(
                    color: ConstDatesColors.cancelBtn,
                    height: ScreenUtil().setHeight(100),
                    width: ScreenResolution.width / 3,
                    insideWidget: ExtendedText(
                      string: 'رفض',
                      fontSize: ExtendedText.bigFont,
                    ),
                    splashColor: AppColors.blue,
                    animationDuration: Duration(milliseconds: 700),
                    function: getFunctionReject(widget.order, context),
                  ),
                )
              ],
            ),
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
              borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
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
