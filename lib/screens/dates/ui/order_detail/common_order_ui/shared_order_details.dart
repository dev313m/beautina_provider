import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/screens/dates/ui/paint.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spring_button/spring_button.dart';
import 'package:steps/steps.dart';

///[size]
double sizeTitle = 80.h;

///[edge]

double edgeContainer = 4.w;

///[color]

Color colorContainer = Colors.white24;
Color colorTitleContainer = ConstDatesColors.orderContainerTitle;

///[string]

final strRequestedServices = 'الخدمات المطلوبة:';
final strProviderNotes = 'ملاحظات الخبيرة:';
final strEmpty = 'لايوجد';
final strNotes = 'ملاحظات الطلب:';

///[radius]
final double radius = radiusDefault;

class WdgtDateSharedOrderDetails extends StatelessWidget {
  final Order order;
  const WdgtDateSharedOrderDetails({Key key, this.order}) : super(key: key);

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
            string: '${getOrderStatus(order.status)} من (${order.client_name})',
            // fontSize: ExtendedText.bigFont,
            // style: TextStyle(color: Colors.white),
          )),
        ),
        Y(
          height: BoxHeight.heightBtwTitle,
        ),

        SpringButton(
          SpringButtonType.OnlyScale,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Colors.black54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GWdgtTextTitleDesc(
                  string: 'مرحلة الطلب:',
                  textAlign: TextAlign.right,
                ),
                Container(
                  height: 200.h,
                  child: Steps(
                    steps: [
                      {
                        'color': Colors.white,
                        'background': Colors.lightBlue.shade200,
                        'label': '1',
                        'content': Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GWdgtTextDescDesc(
                              string: 'طلب جديد',
                              // color: Colors.black,
                            ),
                          ],
                        ),
                      },
                      {
                        'color': Colors.white,
                        'background': Colors.lightBlue,
                        'label': '2',
                        'content': Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GWdgtTextDescDesc(
                              string: 'قبول الطلب',
                              // color: Colors.black,
                            ),
                          ],
                        ),
                      },
                      {
                        'color': Colors.white,
                        'background': Colors.lightBlue.shade200,
                        'label': '3',
                        'content': Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GWdgtTextDescDesc(
                              string: 'تأكيد الزبون',
                              // color: Colors.black,
                            ),
                          ],
                        ),
                      },
                    ],
                    path: {'color': Colors.white30, 'width': 2.0},
                    direction: Axis.horizontal,
                    size: 56.w,
                  ),
                ),
              ],
            ),
          ),
          scaleCoefficient: 0.9,
          onTap: () {},
        ),

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
        OrderDetails(
          date: order.client_order_date,
          location: order.client_location,
          phoneNum: order.provider_phone,
          price: order.total_price,
        ),
        Y(
          height: BoxHeight.heightBtwContainers,
        ),
        Container(
          width: double.infinity,
          height: 280.h,

          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(radius)
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Wrap(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AllSingleServiceWidget(
                  services: order.services,
                ),
                GWdgtTextTitleDesc(
                  string: strRequestedServices,
                  // fontSize: ExtendedText.bigFont,
                  // textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ),

        ///if there is notes dont show to user
        if (order.order_info != '')
          Wrap(
            // crossAxisAlignment: WrapCrossAlignment.start,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              GWdgtTextTitleDesc(
                string: strNotes,
                // fontSize: ExtendedText.bigFont,
                // textDirection: TextDirection.rtl,
              ),
              Container(
                child: GWdgtTextTitleDesc(
                  string: order.order_info == '' ? strEmpty : order.order_info,
                  // fontSize: ExtendedText.bigFont,
                ),
              ),
            ],
          ),
        Y(
          height: BoxHeight.heightBtwContainers,
        ),

        /// if the provider didn't support any notes
        if (order.provider_notes != '')
          Wrap(
            // crossAxisAlignment: WrapCrossAlignment.start,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              GWdgtTextTitleDesc(
                string: strProviderNotes,
              ),
              order.provider_notes == ''
                  ? Container(
                      child: GWdgtTextTitleDesc(
                        string: order.provider_notes == ''
                            ? strEmpty
                            : order.provider_notes,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
      ],
    );
  }
}

bool getStepTwo(int status) {
  if (status == 1 || status == 3) return true;
  return false;
}

bool getStepThree(int status) {
  if (status == 3) return true;
  return false;
}
