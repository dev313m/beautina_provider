import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/dates/ui/page_single_order_detail.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spring_button/spring_button.dart';

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
                return Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ConstDatesColors.littleList.withAlpha(200),
                    ),
                    // height: ScreenUtil().setHeight(210),
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SpringButton(
                              SpringButtonType.OnlyScale,
                              Hero(
                                tag: ordersList[index].doc_id + 'ok',
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: ExtendedText(
                                      string: 'التفاصيل',
                                    ),
                                  ),
                                  width: ScreenUtil().setWidth(130),
                                  height: ScreenUtil().setWidth(100),
                                ),
                              ), onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => WdgtDatePageSingleOrderDetail(order: ordersList[index], heroTag: ordersList[index].doc_id),
                            ));
                          }
                              // showCupertinoModalBottomSheet(
                              //   context: context,
                              //   backgroundColor: Colors.black87,
                              //   bounce: true,
                              //   elevation: 22,
                              //   builder: (_, __) => PageOrderDetail(
                              //       order: widget.ordersList[index],
                              //       heroTag: widget.ordersList[index].doc_id),
                              // );
                              ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              ExtendedText(string: getText(index)),
                              ExtendedText(
                                string: 'السعر: ${ordersList[index].total_price}',
                                textAlign: TextAlign.right,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Builder(builder: (_) {
                                    List<String> list = [];
                                    Map<String, dynamic> mapper = Provider.of<VMSalonData>(context).providedServices;

                                    ordersList[index].services.forEach((k, v) {
                                      v.forEach((kk, vv) {
                                        if (k == 'other')
                                          list.add(kk.toString());
                                        else {
                                          try {
                                            list.add(mapper['services'][k]['items'][kk]['ar']);
                                          } catch (e) {
                                            list.add(k.toString());
                                          }
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
                                                backgroundColor: Colors.white12,
                                                label: ExtendedText(
                                                  string: f,
                                                  fontColor: Colors.black,
                                                )))
                                            .toList(),
                                      ),
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  String getText(int index) {
    if (ordersList[index].client_order_date.isBefore(DateTime.now().toLocal()) &&
        (ordersList[index].status == 3 || ordersList[index].status == 8))
      return 'مرحبا، نرجو تأكيد اتمام العملية  (${ordersList[index].client_name})  ${getDate(ordersList[index].client_order_date)}';
    else
      return '${getOrderStatus(ordersList[index].status)} (${ordersList[index].client_name})  ${getDate(ordersList[index].client_order_date)}';
  }
}

String getDate(DateTime date) {
  return 'الوقت ${date.hour}:${date.minute}';
}
