import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/shared_order_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/screens/dates/ui/page_single_order_detail.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

///new order [status = 0]
class WidgetNewOrder extends StatefulWidget {
  final Order order;

  const WidgetNewOrder({Key key, this.order}) : super(key: key);

  @override
  _WidgetNewOrderState createState() => _WidgetNewOrderState();
}

class _WidgetNewOrderState extends State<WidgetNewOrder> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final String providerNotes = '';
  TextEditingController durationTextFieldController =
      TextEditingController(text: 'لم يتم التحديد');

  Duration orderDuration = Duration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenResolution.width,
      decoration: BoxDecoration(
          color: colorBackground, borderRadius: BorderRadius.circular(radius)),
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
                  ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: BeautyTextfield(
                        maxLines: 3,
                        isBox: true,
                        maxLength: 250,
                        onChanged: (str) {
                          widget.order.provider_notes = str;
                        },
                        prefixIcon: Icon(
                          CommunityMaterialIcons.ticket,
                          color: AppColors.pinkBright,
                        ),

                        // placeholder: ,
                        placeholder: 'ملاحظات',
                        // textStyle: TextStyle(color: AppColors.pinkBright),
                        inputType: TextInputType.text,
                      )),
                  Container(
                    // width: 200.w,
                    child: BeautyTextfield(
                      // prefixText: durationTextFieldController.text,
                      placeholder: durationTextFieldController.text,
                      helperText: 'المدة المتوقعة للطلب:  ',
                      readOnly: true,
                      prefixIcon: Icon(CommunityMaterialIcons.watch),
                      onTap: () {
                        Picker picker;

                        picker = Picker(
                            // backgroundColor: Colors.pink.withOpacity(0.3),
                            adapter:
                                NumberPickerAdapter(data: <NumberPickerColumn>[
                              const NumberPickerColumn(
                                  begin: 0,
                                  end: 60,
                                  suffix: Text(' دق'),
                                  jump: 15),
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
                                inherit: false,
                                color: Colors.red,
                                fontSize: 22),
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
                      inputType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Row(
                    children: [
                      RoundedLoadingButton(
                        color: colorButtonAccept,
                        height: sizeButtonHeight,
                        width: sizeButtonHeight,
                        child: GWdgtTextButton(
                          string: 'قبول',
                        ),
                        controller: _buttonController,
                        animateOnTap: true,
                        borderRadius: radius,
                        onPressed: () async {
                          bool result = false;
                          _buttonController.start();

                          // _buttonController.start();
                          result =
                              await getFunctionAccept(widget.order, context);
                          if (result)
                            _buttonController.success();
                          else
                            _buttonController.error();
                        },
                      ),
                      RoundedLoadingButton(
                        color: colorButtonReject,
                        height: sizeButtonHeight,
                        width: sizeButtonHeight,
                        controller: _buttonController,
                        animateOnTap: true,
                        borderRadius: radius,
                        child: GWdgtTextButton(string:'رفض'),
                        onPressed: () async {
                          bool result = false;
                          _buttonController.start();

                          // _buttonController.start();
                          result =
                              await getFunctionReject(widget.order, context);
                          if (result)
                            _buttonController.success();
                          else
                            _buttonController.error();
                        },
                      ),
                    ],
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
Color colorContainer = Colors.white24;
Color colorButtonReject = ConstDatesColors.cancelBtn;
Color colorButtonAccept = ConstDatesColors.confirmBtn;

///[radius]
final double radius = 12;

///[edge]
final edgeContainer = 8.h;
