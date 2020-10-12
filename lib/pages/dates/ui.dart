import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/pages/dates/constants.dart';
import 'package:beautina_provider/pages/dates/functions.dart';
import 'package:beautina_provider/pages/dates/paint.dart';
import 'package:beautina_provider/pages/dates/shared_variables_order.dart';
import 'package:beautina_provider/pages/dates/ui_action_status.dart';
import 'package:beautina_provider/pages/my_salon/beauty_provider_page/functions.dart';
import 'package:beautina_provider/pages/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/pages/root/constants.dart';
import 'package:beautina_provider/pages/root/shared_variable_root.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/animated_buttons.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class JustOrderWidget extends StatefulWidget {
  final Order order;
  JustOrderWidget({Key key, this.order}) : super(key: key);

  _JustOrderWidgetState createState() => _JustOrderWidgetState();
}

class _JustOrderWidgetState extends State<JustOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Container(
        width: ScreenResolution.width,
        decoration:
            BoxDecoration(color: AppColors.blueOpcity, borderRadius: BorderRadius.circular(20)),
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
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                    child: ExtendedText(
                  string: '${getOrderStatus(widget.order.status)} (${widget.order.client_name})',
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
                size: Size(ScreenUtil().setWidth(650), ScreenUtil().setHeight(130)),
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
              //             borderRadius: BorderRadius.circular(9),
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
                      string: widget.order.order_info == '' ? 'لايوجد' : widget.order.order_info,
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
              WidgetAction(order: widget.order),
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

class AllSingleServiceWidget extends StatelessWidget {
  final Map<String, dynamic> services;
  const AllSingleServiceWidget({Key key, this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      List<String> list = [];
      Map<String, dynamic> mapper = Provider.of<SharedSalon>(context).providedServices;

      services.forEach((k, v) {
        v.forEach((kk, vv) {
          if (k == 'other')
            list.add(kk.toString());
          else
            try {
              list.add(mapper['services'][k]['items'][kk]['ar']);
            } catch (e) {
              list.add(k);
            }
        });
      });
      return Container(
        width: ScreenUtil().setWidth(500),
        child: Wrap(
          textDirection: TextDirection.rtl,
          // verticalDirection: VerticalDirection.down,
          // direction: Axis.horizontal,
          children: list
              .map((f) => Chip(
                      label: ExtendedText(
                    string: f,
                    fontColor: Colors.black,
                  )))
              .toList(),
        ),
      );
    });
  }
}

class OrderDetails extends StatelessWidget {
  final DateTime date;
  final int price;
  final List<dynamic> location;
  final String phoneNum;
  OrderDetails({Key key, this.date, this.location, this.phoneNum, this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            muteRowCell(phoneNum, 'تحدث الان', Icons.message, ConstDatesColors.details,
                getWhatsappFunction(phoneNum)),
            muteRowCell('', 'ذهاب الآن', Icons.edit_location, ConstDatesColors.details,
                getLaunchMapFunction(location)),
            muteRowCell(price.toString() + ' SR', 'السعر', Icons.attach_money,
                ConstDatesColors.details, () {}),
            muteRowCell(getDateString(date), 'وقت الموعد', Icons.date_range,
                ConstDatesColors.details, getWhatsappFunction(phoneNum)),
            Text(
              'معلومات الخدمه:',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: ExtendedText.brightColor),
            ),
          ],
        ),
      ],
    );
  }
}

Widget darkenWidget(int status) {
  if (status != 0 && status != 1 && status != 3)
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        height: ScreenResolution.height / 2.2,
      ),
    );
  return SizedBox();
}

class WAvailablilityChanger extends StatefulWidget {
  final DateTime changableAvailableDate;

  const WAvailablilityChanger({
    Key key,
    this.changableAvailableDate,
  }) : super(key: key);

  @override
  _WAvailablilityChangerState createState() => _WAvailablilityChangerState();
}

class _WAvailablilityChangerState extends State<WAvailablilityChanger> {
  bool available = true;
  bool isLoading = false;
  bool isAvailabilityChecked = false;
  @override
  void initState() {
    super.initState();
    checkAvalability(widget.changableAvailableDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.sp,

      // decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ExtendedText(
            string: ' اضغطي هنا لفتح-ايقاف استلام الطلبات:             ',
            textAlign: TextAlign.start,
            textDirection: TextDirection.rtl,
            fontSize: ExtendedText.defaultFont,
          ),
          Container(
            height: 200.sp,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                // width: 400,

                height: 200.sp,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */
                      ModelBeautyProvider mbp = await sharedUserProviderGetInfo();

                      //Clear old dates
                      List<Map<String, DateTime>> newBusyDates = clearOldBusyDates(mbp.busyDates);
                      //update busy dates
                      newBusyDates = changeAvaDates(widget.changableAvailableDate, mbp);

                      await apiBeautyProviderUpdate(mbp..busyDates = newBusyDates);

                      Provider.of<SharedSalon>(context).beautyProvider = mbp;
                      Provider.of<SharedSalon>(context).beautyProvider =
                          await sharedUserProviderGetInfo();

                      isAvailabilityChecked = false;
                      checkAvalability(widget.changableAvailableDate);
                    } catch (e) {
                      showToast('حدث خطأ اثناء التحديث');
                    }
                    isLoading = false;

                    setState(() {});
                  },
                  child: Stack(
                    children: <Widget>[
                      FlareActor(
                        'assets/rive/lock.flr',
                        animation: available ? 'unlock' : 'lock',
                        shouldClip: false,
                        snapToEnd: false,
                        // artboard: available ? 'open' : 'closed',
                        // animation: available ? 'open' : 'closed',

                        // controller: ,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: isLoading ? Loading() : SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, DateTime>> changeAvaDates(
      DateTime requiredDate, ModelBeautyProvider modelBeautyProvider) {
    List<Map<String, DateTime>> newBusyDates;
    DateTime fixedDate = DateTime(requiredDate.year, requiredDate.month, requiredDate.day);

    ///
    ///This is to remove any old date
    ///
    if (available)
      newBusyDates = modelBeautyProvider.busyDates
        ..add({'from': fixedDate, 'to': fixedDate.add(Duration(days: 1))});
    else
      newBusyDates = modelBeautyProvider.busyDates
        ..removeWhere((element) {
          if (element['from'].year == requiredDate.year &&
              element['from'].month == requiredDate.month &&
              element['from'].day == requiredDate.day) return true;
          return false;
        });

    return newBusyDates;
  }

  List<Map<String, DateTime>> clearOldBusyDates(List<Map<String, DateTime>> listDates) {
    DateTime dayTimeNow = DateTime.now();
    for (int i = 0; i < listDates.length; i++) {
      if (listDates[i]['from'].isBefore(dayTimeNow)) listDates.removeAt(i);
    }

    return listDates;
  }

  Future<void> removeAllOldDates() async {}

  //THis method checks availablity and if it was check for better performance we do a flag
  Future<bool> checkAvalability(DateTime requiredDate) async {
    if (isAvailabilityChecked) return available;
    bool availableDate = true;
    await Future.delayed(Duration(milliseconds: 300));
    ModelBeautyProvider beautyProvider = Provider.of<SharedSalon>(context).beautyProvider;
    List<Map<String, DateTime>> busyDates = beautyProvider.busyDates;
    busyDates.forEach((element) {
      if (requiredDate.isAfter(element['from'].subtract(Duration(minutes: 1))) &&
          requiredDate.isBefore(element['to'])) availableDate = false;
    });
    isAvailabilityChecked = true;
    setState(() {
      available = availableDate;
    });
    return availableDate;
  }
}
