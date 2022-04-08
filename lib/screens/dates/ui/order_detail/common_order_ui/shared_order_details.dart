import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spring_button/spring_button.dart';

///[size]
double sizeTitle = 80.h;

///[edge]

double edgeContainer = 4.w;

///[color]

Color colorContainer = Colors.white12;
Color colorTitleContainer = ConstDatesColors.orderContainerTitle;

///[string]

final strRequestedServices = 'الخدمات المطلوبة:';
final strProviderNotes = 'ملاحظات الخبيرة:';
final strEmpty = 'لايوجد';
final strNotes = 'ملاحظات الطلب:';

///[radius]
final double radius = radiusDefault;

class WdgtDateSharedOrderDetails extends StatelessWidget {
  final Order? order;
  const WdgtDateSharedOrderDetails({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: ScreenResolution.width,
          height: sizeTitle,
          decoration: BoxDecoration(
            // color: colorTitleContainer,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
              child: GWdgtTextTitle(
            string: '${getOrderStatus(order!.status)} (${order!.client_name})',
            // fontSize: ExtendedText.bigFont,
            // style: TextStyle(color: Colors.white),
          )),
        ),

        // Y(
        //   height: BoxHeight.heightBtwTitle,
        // ),

        // Directionality(
        //   textDirection: TextDirection.rtl,
        //   child: SpringButton(
        //     SpringButtonType.OnlyScale,
        //     Container(
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(radius),
        //           color: colorContainer),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Padding(
        //             padding:  EdgeInsets.all(edgeText),
        //             child: GWdgtTextTitleDesc(
        //               string: 'مرحلة الطلب:',
        //               textAlign: TextAlign.right,
        //             ),
        //           ),
        //           Container(
        //             height: 253.h,
        //             child: Steps(
        //               steps: [
        //                 {
        //                   'color': Colors.white,
        //                   'background': Colors.blue,
        //                   'label': '1',
        //                   'content': Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       GWdgtTextDescDesc(
        //                         string: 'طلب جديد',
        //                         // color: Colors.black,
        //                       ),
        //                     ],
        //                   ),
        //                 },
        //                 {
        //                   'color': Colors.white,
        //                   'background': getStepTwo(order.status)['color'],
        //                   'label': '2',
        //                   'content': Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       GWdgtTextDescDesc(
        //                         string: 'قبول الطلب',
        //                         // color: Colors.black,
        //                       ),
        //                     ],
        //                   ),
        //                 },
        //                 {
        //                   'color': Colors.white,
        //                   'background': getStepThree(order.status)['color'],
        //                   'label': '3',
        //                   'content': Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       GWdgtTextDescDesc(
        //                         string: 'تأكيد الزبون',
        //                         // color: Colors.black,
        //                       ),
        //                     ],
        //                   ),
        //                 },
        //               ],
        //               path: {'color': Colors.white30, 'width': 2.0},
        //               direction: Axis.horizontal,
        //               size: 56.w,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     scaleCoefficient: 0.9,
        //     onTap: () {},
        //   ),
        // ),

        Y(
          height: BoxHeight.heightBtwContainers,
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
        //             isSelected: [false, false, false]..[order.who_come] = true),
        //         // ...order.services.map((service) {
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

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edgeText),
              child: GWdgtTextTitleDesc(string: 'معلومات الطلب:'),
            ),
            Container(
              child: OrderDetails(
                  date: order!.client_order_date,
                  location: order!.client_location,
                  phoneNum: order!.client_phone,
                  price: order!.total_price,
                  backgroundColor: colorContainer),
            ),
          ],
        ),

        Y(
          height: BoxHeight.heightBtwContainers,
        ),
        Container(
          width: double.infinity,
          child: Row(
            children: [
              if (order!.order_info != '')
                Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Y(
                        height: 50.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edgeText),
                        child: GWdgtTextTitleDesc(
                          string: strNotes,
                          // fontSize: ExtendedText.bigFont,
                          // textDirection: TextDirection.rtl,
                        ),
                      ),
                      Y(),
                      SpringButton(
                        SpringButtonType.OnlyScale,
                        Container(
                          height: 230.h,
                          width: double.infinity,
                          padding: EdgeInsets.all(edgeContainer),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(edgeText + 10.h),
                                child: GWdgtTextDescDesc(
                                  string: order!.order_info == ''
                                      ? strEmpty
                                      : order!.order_info,
                                  // fontSize: ExtendedText.bigFont,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: colorContainer),
                        ),
                        key: GlobalKey(),
                        scaleCoefficient: 0.9,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Y(), Y(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edgeText),
              child: GWdgtTextTitleDesc(
                string: 'الخدمات المطلوبه',
                // fontSize: ExtendedText.bigFont,
                // textDirection: TextDirection.rtl,
              ),
            ),
            Y(), 
            Container(
              height: 230.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: colorContainer,
                  borderRadius: BorderRadius.circular(radius)),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: AllSingleServiceWidget(
                    services: order!.services,
                  ),
                ),
              ),
            ),
          ],
        ),

        Y(
          height: BoxHeight.heightBtwTitle,
        ),

        Container(
          width: double.infinity,
          child: Row(
            children: [
              if (order!.provider_notes != '')
                Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Y(
                        height: 50.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edgeText),
                        child: GWdgtTextTitleDesc(
                          string: strNotes,
                          // fontSize: ExtendedText.bigFont,
                          // textDirection: TextDirection.rtl,
                        ),
                      ),
                      Y(),
                      SpringButton(
                        SpringButtonType.OnlyScale,
                        Container(
                          height: 230.h,
                          width: double.infinity,
                          padding: EdgeInsets.all(edgeContainer),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(edgeText + 10.h),
                                child: GWdgtTextDescDesc(
                                  string: order!.provider_notes == ''
                                      ? strEmpty
                                      : order!.provider_notes,
                                  // fontSize: ExtendedText.bigFont,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: colorContainer),
                        ),
                        key: GlobalKey(),
                        scaleCoefficient: 0.9,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        /// if the provider didn't support any notes
      ],
    );
  }
}

Map<String, dynamic> getStepTwo(int status) {
  if (status == 1 || status == 3) return {'bool': true, 'color': Colors.blue};
  return {'bool': true, 'color': Colors.blue[200]};
}

Map<String, dynamic> getStepThree(int status) {
  if (status == 3) return {'bool': true, 'color': Colors.blue};
  return {'bool': true, 'color': Colors.blue[200]};
}

// final Color colorStep = ;
