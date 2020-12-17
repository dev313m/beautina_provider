import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/dates/ui/page_single_order_detail.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spring_button/spring_button.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

///[String]
final strDetail = 'التفاصيل';

///[radius]
final double radiusContainer = radiusDefault;

///[color]
final Color colorContainer = ConstDatesColors.littleList.withAlpha(200);
final Color colorBtn = Colors.white38;

///[edge]
double paddingContainer = 8.h;

///[size]
final sizeBtnHeight = 200.h;
final sizeBtnWidth = 200.w;

class WdgtDateOrderList extends StatefulWidget {
  final String hero;
  WdgtDateOrderList({Key key, this.hero}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<WdgtDateOrderList> {
  List<Order> ordersList;

  @override
  Widget build(BuildContext context) {
    ordersList = Provider.of<VmDateData>(context).listOfDay;
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: ordersList.length == 0
          ? SizedBox()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: ordersList.length,
              // cacheExtent: 8,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusContainer),
                    color: colorContainer,
                  ),
                  // height: ScreenUtil().setHeight(210),
                  child: Padding(
                    padding: EdgeInsets.all(paddingContainer),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CupertinoButton(
                            padding: EdgeInsets.all(0),
                            // SpringButtonType.OnlyScale,
                            child: Hero(
                              tag: ordersList[index].doc_id + 'ok',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorBtn,
                                  borderRadius:
                                      BorderRadius.circular(radiusContainer),
                                ),
                                child: Icon(
                                  Icons.navigate_before,
                                  color: Colors.white,
                                ),
                                width: sizeBtnWidth,
                                height: sizeBtnHeight,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => WdgtDatePageSingleOrderDetail(
                                    orderId: Provider.of<VmDateData>(context)
                                        .listOfDay[index]
                                        .doc_id,
                                    heroTag: ordersList[index].doc_id),
                              ));
                            }),
                        SizedBox(
                          width: 10.w,
                        ),
                        SpringButton(
                          SpringButtonType.OnlyScale,
                          Container(
                            // padding: EdgeInsets.symmetric(vertical: 44.h),
                            width: sizeBtnHeight,
                            height: sizeBtnHeight,
                            // w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radius),
                                color: Colors.green[900]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  CommunityMaterialIcons.sack,
                                  size: 80.sp,
                                  color: Colors.white70,
                                ),
                                new GWdgtTextSmall(
                                  string:
                                      '${ordersList[index].total_price} Riyal',
                                ),
                              ],
                            ),
                          ),
                          key: GlobalKey(),
                          onTap: () async {},
                          scaleCoefficient: 0.9,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SpringButton(
                          SpringButtonType.OnlyScale,
                          Container(
                            // padding: EdgeInsets.symmetric(vertical: 44.h),
                            width: sizeBtnHeight,
                            height: sizeBtnHeight,
                            // w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radius),
                                color: Colors.white38),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  CommunityMaterialIcons.calendar_clock,
                                  color: Colors.white70,
                                  size: 80.sp,
                                ),
                                new GWdgtTextSmall(
                                  string:
                                      '${ordersList[index].client_order_date.hour}:${ordersList[index].client_order_date.minute}',
                                ),
                              ],
                            ),
                          ),
                          key: GlobalKey(),
                          onTap: () async {},
                          scaleCoefficient: 0.9,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              GWdgtTextTitleDesc(string: getText(index)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Builder(builder: (_) {
                                    List<String> list = [];
                                    Map<String, dynamic> mapper =
                                        Provider.of<VMSalonData>(context)
                                            .providedServices;

                                    ordersList[index].services.forEach((k, v) {
                                      v.forEach((kk, vv) {
                                        if (k == 'other')
                                          list.add(kk.toString());
                                        else {
                                          try {
                                            list.add(mapper['services'][k]
                                                ['items'][kk]['ar']);
                                          } catch (e) {
                                            list.add(k.toString());
                                          }
                                        }
                                      });
                                    });
                                    return Wrap(
                                      textDirection: TextDirection.rtl,
                                      // verticalDirection: VerticalDirection.down,
                                      // direction: Axis.horizontal,
                                      children: list
                                          .map((f) => Container(
                                              height: 100.h,
                                              padding: EdgeInsets.all(16.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radius),
                                                color: Colors.white38,
                                              ),
                                              // backgroundColor: Colors.white12,
                                              child: Center(
                                                child: GWdgtTextChip(
                                                  string: f,
                                                ),
                                              )))
                                          .toList(),
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  String getText(int index) {
    if (ordersList[index]
            .client_order_date
            .isBefore(DateTime.now().toLocal()) &&
        (ordersList[index].status == 3 || ordersList[index].status == 8))
      return 'مرحبا، نرجو تأكيد اتمام العملية  (${ordersList[index].client_name})  ${getDate(ordersList[index].client_order_date)}';
    else
      return '${getOrderStatus(ordersList[index].status)} (${ordersList[index].client_name}) ';
  }
}

String getDate(DateTime date) {
  return 'الوقت ${date.hour}:${date.minute}';
}
