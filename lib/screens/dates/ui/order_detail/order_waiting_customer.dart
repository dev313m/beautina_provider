import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/animated_buttons.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/screens/dates/ui/paint.dart';
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
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Container(
        width: ScreenResolution.width,
        decoration: BoxDecoration(
            color: AppColors.blueOpcity,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: ScreenResolution.width,
                height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  color: ConstDatesColors.orderContainerTitle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: ExtendedText(
                  string:
                      '${getOrderStatus(widget.order.status)} (${widget.order.client_name})',
                  fontSize: ExtendedText.bigFont,
                  // style: TextStyle(color: Colors.white),
                )),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              CustomPaint(
                willChange: false,
                isComplex: true,
                // willChange: false,
                // isComplex: false,
                size: Size(
                    ScreenUtil().setWidth(650), ScreenUtil().setHeight(130)),
                painter: MyPainter(step: getStep(widget.order.status)),
              ),
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AllSingleServiceWidget(
                        services: widget.order.services,
                      ),
                      // ...widget.order.services.map((service) {
                      //   return singleService(service);
                      // }).toList(),
                      SizedBox(
                        width: ScreenUtil().setWidth(100),
                      ),
                      ExtendedText(
                        string: 'الخدمات المطلوبة:',
                        fontSize: ExtendedText.bigFont,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),

              ///[todo] add it later location feature
              // Container(
              //   width: double.infinity,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     reverse: true,
              //     child: Row(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         ToggleButtons(
              //             children: [ExtendedText(string: 'بيت الزبون'), ExtendedText(string: 'مكاني'), ExtendedText(string: 'الكل')],
              //             borderRadius: BorderRadius.circular(12),
              //             onPressed: (index) {},
              //             isSelected: [false, false, false]..[widget.order.who_come] = true),
              //         // ...widget.order.services.map((service) {
              //         //   return singleService(service);
              //         // }).toList(),
              //         SizedBox(
              //           width: ScreenUtil().setWidth(100),
              //         ),
              //         ExtendedText(
              //           string: 'مكان العملية:',
              //           fontSize: ExtendedText.bigFont,
              //           textDirection: TextDirection.rtl,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              OrderDetails(
                date: widget.order.client_order_date,
                location: widget.order.provider_location,
                phoneNum: widget.order.provider_phone,
                price: widget.order.total_price,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Wrap(
                // crossAxisAlignment: WrapCrossAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  ExtendedText(
                    string: 'ملاحظاتي:',
                    fontSize: ExtendedText.bigFont,
                    textDirection: TextDirection.rtl,
                  ),
                  Container(
                    child: ExtendedText(
                      string: widget.order.order_info == ''
                          ? 'لايوجد'
                          : widget.order.order_info,
                      fontSize: ExtendedText.bigFont,
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Wrap(
                // crossAxisAlignment: WrapCrossAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  ExtendedText(
                    string: 'ملاحظات الخبيرة:',
                    fontSize: ExtendedText.bigFont,
                    textDirection: TextDirection.rtl,
                  ),
                  widget.order.provider_notes == ''
                      ? Container(
                          child: ExtendedText(
                            string: widget.order.provider_notes == ''
                                ? 'لايوجد'
                                : widget.order.provider_notes,
                            fontSize: ExtendedText.bigFont,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              RoundedLoadingButton(
                color: ConstDatesColors.cancelBtn,
                height: ScreenUtil().setHeight(100),
                width: 400,
                controller: _buttonController,
                animateOnTap: true,
                borderRadius: 12,
                child: Text('رفض'),
                onPressed: () async {
                  bool result = false;
                  _buttonController.start();

                  // _buttonController.start();
                  result = await getFunctionReject(widget.order, context);
                  if (result)
                    _buttonController.success();
                  else
                    _buttonController.error();
                },
              ),
              // AnimatedSubmitButton(
              //   color: ConstDatesColors.cancelBtn,
              //   height: ScreenUtil().setHeight(100),
              //   width: 500,
              //   insideWidget: ExtendedText(
              //     string: ConstDateStrings.cancel,
              //     fontSize: ExtendedText.bigFont,
              //   ),
              //   splashColor: AppColors.blue,
              //   animationDuration: Duration(milliseconds: 500),
              //   function: getFunctionReject(widget.order, context),
              // ),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
