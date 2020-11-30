import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/animated_buttons.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui.dart';
import 'package:beautina_provider/screens/dates/ui/paint.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///When order is submitted by user but outdated [status = 3 ]
class WidgetOutdatedOrder extends StatefulWidget {
  final Order order;

  const WidgetOutdatedOrder({Key key, this.order}) : super(key: key);

  @override
  _WidgetOutdatedOrderState createState() => _WidgetOutdatedOrderState();
}

class _WidgetOutdatedOrderState extends State<WidgetOutdatedOrder> {
  final String providerNotes = '';

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
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
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
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
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
                        function:
                            getFunctionFinishedComplete(widget.order, context),
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
                        animationDuration: Duration(milliseconds: 500),
                        function: getFunctionFinishedIncomplete(
                            widget.order, context),
                      )
                    ],
                  ),
                ),
              ),
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
