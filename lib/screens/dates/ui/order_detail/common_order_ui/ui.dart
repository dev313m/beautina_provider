import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/paint.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

// class JustOrderWidget extends StatefulWidget {
//   final Order order;
//   JustOrderWidget({Key key, this.order}) : super(key: key);

//   _JustOrderWidgetState createState() => _JustOrderWidgetState();
// }

// class _JustOrderWidgetState extends State<JustOrderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 4),
//       child: Container(
//         width: ScreenResolution.width,
//         decoration: BoxDecoration(
//             color: AppColors.blueOpcity,
//             borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Container(
//                 width: ScreenResolution.width,
//                 height: ScreenUtil().setHeight(100),
//                 decoration: BoxDecoration(
//                   color: ConstDatesColors.orderContainerTitle,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                     child: ExtendedText(
//                   string:
//                       '${getOrderStatus(widget.order.status)} (${widget.order.client_name})',
//                   fontSize: ExtendedText.bigFont,
//                   // style: TextStyle(color: Colors.white),
//                 )),
//               ),
//               SizedBox(height: ScreenUtil().setHeight(30)),
//               CustomPaint(
//                 willChange: false,
//                 isComplex: true,
//                 // willChange: false,
//                 // isComplex: false,
//                 size: Size(
//                     ScreenUtil().setWidth(650), ScreenUtil().setHeight(130)),
//                 painter: MyPainter(step: getStep(widget.order.status)),
//               ),
//               Container(
//                 width: double.infinity,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   reverse: true,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       AllSingleServiceWidget(
//                         services: widget.order.services,
//                       ),
//                       // ...widget.order.services.map((service) {
//                       //   return singleService(service);
//                       // }).toList(),
//                       SizedBox(
//                         width: ScreenUtil().setWidth(100),
//                       ),
//                       ExtendedText(
//                         string: 'الخدمات المطلوبة:',
//                         fontSize: ExtendedText.bigFont,
//                         textDirection: TextDirection.rtl,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(10),
//               ),

//               ///[todo] add it later location feature
//               // Container(
//               //   width: double.infinity,
//               //   child: SingleChildScrollView(
//               //     scrollDirection: Axis.horizontal,
//               //     reverse: true,
//               //     child: Row(
//               //       mainAxisSize: MainAxisSize.max,
//               //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //       children: <Widget>[
//               //         ToggleButtons(
//               //             children: [ExtendedText(string: 'بيت الزبون'), ExtendedText(string: 'مكاني'), ExtendedText(string: 'الكل')],
//               //             borderRadius: BorderRadius.circular(12),
//               //             onPressed: (index) {},
//               //             isSelected: [false, false, false]..[widget.order.who_come] = true),
//               //         // ...widget.order.services.map((service) {
//               //         //   return singleService(service);
//               //         // }).toList(),
//               //         SizedBox(
//               //           width: ScreenUtil().setWidth(100),
//               //         ),
//               //         ExtendedText(
//               //           string: 'مكان العملية:',
//               //           fontSize: ExtendedText.bigFont,
//               //           textDirection: TextDirection.rtl,
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               OrderDetails(
//                 date: widget.order.client_order_date,
//                 location: widget.order.provider_location,
//                 phoneNum: widget.order.provider_phone,
//                 price: widget.order.total_price,
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(20),
//               ),
//               Wrap(
//                 // crossAxisAlignment: WrapCrossAlignment.start,
//                 textDirection: TextDirection.rtl,
//                 children: <Widget>[
//                   ExtendedText(
//                     string: 'ملاحظاتي:',
//                     fontSize: ExtendedText.bigFont,
//                     textDirection: TextDirection.rtl,
//                   ),
//                   Container(
//                     child: ExtendedText(
//                       string: widget.order.order_info == ''
//                           ? 'لايوجد'
//                           : widget.order.order_info,
//                       fontSize: ExtendedText.bigFont,
//                     ),
//                   ),
//                   SizedBox(width: ScreenUtil().setWidth(10)),
//                 ],
//               ),
//               SizedBox(
//                 height: ScreenUtil().setHeight(10),
//               ),
//               Wrap(
//                 // crossAxisAlignment: WrapCrossAlignment.start,
//                 textDirection: TextDirection.rtl,
//                 children: <Widget>[
//                   ExtendedText(
//                     string: 'ملاحظات الخبيرة:',
//                     fontSize: ExtendedText.bigFont,
//                     textDirection: TextDirection.rtl,
//                   ),
//                   widget.order.provider_notes == ''
//                       ? Container(
//                           child: ExtendedText(
//                             string: widget.order.provider_notes == ''
//                                 ? 'لايوجد'
//                                 : widget.order.provider_notes,
//                             fontSize: ExtendedText.bigFont,
//                           ),
//                         )
//                       : SizedBox(),
//                   SizedBox(width: ScreenUtil().setWidth(10)),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               WdgtDateOrderDetails(order: widget.order),
//               SizedBox(
//                 height: 80.h,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class AllSingleServiceWidget extends StatelessWidget {
  final Map<String, dynamic> services;
  const AllSingleServiceWidget({Key key, this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      List<String> list = [];
      Map<String, dynamic> mapper = Provider.of<VMSalonData>(context).providedServices;

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
    return SizedBox();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            muteRowCell(phoneNum, 'تحدث الان', Icons.message, ConstDatesColors.details, getWhatsappFunction(phoneNum)),
            muteRowCell('', 'ذهاب الآن', Icons.edit_location, ConstDatesColors.details, getLaunchMapFunction(location)),
            muteRowCell(price.toString() + ' SR', 'السعر', Icons.attach_money, ConstDatesColors.details, () {}),
            muteRowCell(getDateString(date), 'وقت الموعد', Icons.date_range, ConstDatesColors.details, getWhatsappFunction(phoneNum)),
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        height: ScreenResolution.height / 2.2,
      ),
    );
  return SizedBox();
}
