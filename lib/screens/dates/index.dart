import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/calendar.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/shared_variables_order.dart';
import 'package:beautina_provider/screens/dates/tutorial.dart';
import 'package:beautina_provider/screens/dates/ui.dart';
import 'package:beautina_provider/screens/dates/ui_order_list_page.dart';
import 'package:beautina_provider/screens/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/screens/my_salon/ui_how_I_look.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/reusables/loading.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:spring_button/spring_button.dart';

class FutureList extends StatefulWidget {
  @override
  _FutureListState createState() => _FutureListState();
}

class WidgetGetAllList extends StatelessWidget {
  final List<Order> snapshot;
  const WidgetGetAllList({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // ...snapshot.map((order) => order.status == 5? WidgetRating(order: order,):  )

      Column(
        children: List.generate(snapshot.length,
            (index) => JustOrderWidget(order: snapshot[index])).toList(),
      )
    ]);
  }
}

class _FutureListState extends State<FutureList> {
  SharedOrder sharedOrder;
  @override
  Widget build(BuildContext context) {
    return WidgetFutureList();
  }
}

class WidgetFutureList extends StatefulWidget {
  WidgetFutureList({Key key}) : super(key: key);

  @override
  _WidgetFutureListState createState() => _WidgetFutureListState();
}

class _WidgetFutureListState extends State<WidgetFutureList> {
  SharedOrder sharedOrder;
  @override
  Widget build(BuildContext context) {
    sharedOrder = Provider.of<SharedOrder>(context);

    if (sharedOrder.isError)
      return Center(
        child: InkWell(
          onTap: () {
            sharedOrder.iniState();
          },
          child: Container(
            width: 400,
            height: 400,
            child: Text('إعادة تحميل'),
          ),
        ),
      );
    else if (sharedOrder.isLoading)
      return GetLoadingWidget();
    else if (sharedOrder.orderList.length == 0)
      return Center(
        child: ExtendedText(
          string: 'لايوجد طلبات',
          fontSize: ExtendedText.xbigFont,
        ),
      );
    else
      return WidgetGetAllList(
          snapshot:
              getFilteredList(sharedOrder.orderList, sharedOrder.filterIndex));
  }
}

class DatePage extends StatefulWidget {
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage>
    with AutomaticKeepAliveClientMixin<DatePage> {
  double currentScroll = 0;

  ///
  ///2 for all
  ///1 for active
  ///0 for not active
  int filterType = 0;
  List<bool> filterBool;
  Order order;
  Widget upperW;
  SharedOrder sharedOrder;
  bool dataLoading = false;

  List<Order> displayedList;

  // AnimationController _animationController;
  // Animation _animation;
  ScrollController scrollController;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    filterBool = [false, false, false, false, false, true];
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse)
        Provider.of<VMRootUi>(context).hideBars = true;
      else if (Provider.of<VMRootUi>(context).hideBars)
        Provider.of<VMRootUi>(context).hideBars = false;
      // if (scrollController.position.maxScrollExtent ==
      //         scrollController.position.pixels &&
      //     !dataLoading) {
      //   setState(() {
      //     dataLoading = true;
      //   });
      //   await Provider.of<SharedOrder>(context).apiLoadMore();
      //   setState(() {
      //     dataLoading = false;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    sharedOrder = Provider.of<SharedOrder>(context);

    return RefreshIndicator(
      semanticsLabel: 'Reload',
      onRefresh: () async {
        await sharedOrder.iniState();
        return;
      },
      child: Stack(
        children: <Widget>[
          ListView(
            controller: scrollController,
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(150),
              ),

              // if (sharedOrder.toConfirmList.length > 0)
              //   Container(
              //       padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              //       decoration: BoxDecoration(
              //           color: AppColors.purpleColor,
              //           borderRadius: BorderRadius.circular(9)),
              //       child: Column(
              //         children: <Widget>[
              //           ExtendedText(
              //               string: 'طلبات يجب تأكيدها',
              //               fontSize: ExtendedText.xxbigFont),
              //           OrdersList(
              //               ordersList: sharedOrder.toConfirmList, hero: '0'),
              //         ],
              //       )),

              Row(
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: 'bbb',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: SpringButton(
                          SpringButtonType.WithOpacity,
                          Container(
                            height: ScreenUtil().setHeight(130),
                            child: Center(
                              child: Container(
                                // width: ScreenUtil().setWidth(200),
                                decoration: BoxDecoration(
                                    color: ConstDatesColors.topBtns,
                                    borderRadius: BorderRadius.circular(9)),
                                height: ScreenUtil().setHeight(100),
                                child: Center(
                                  child: ExtendedText(
                                    string: 'طلبات منتهية',
                                    fontSize: ExtendedText.bigFont,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          scaleCoefficient: 0.85,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    OrderListFinishedPage(heroTag: 'bbb')));
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(9),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        SpringButton(
                          SpringButtonType.WithOpacity,
                          Container(
                            height: ScreenUtil().setHeight(130),
                            child: Center(
                              child: Hero(
                                tag: 'newOrders',
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ConstDatesColors.topBtns,
                                      borderRadius: BorderRadius.circular(9)),
                                  height: ScreenUtil().setHeight(100),
                                  child: Center(
                                    child: ExtendedText(
                                      string: 'طلبات مؤكدة قادمة',
                                      fontSize: ExtendedText.bigFont,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          scaleCoefficient: 0.85,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => OrderListPage()));
                          },
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: ClipOval(
                            child: Container(
                                width: ScreenUtil().setWidth(30),
                                height: ScreenUtil().setHeight(30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red),
                                child: Center(
                                  child: ExtendedText(
                                    string: Provider.of<SharedOrder>(context)
                                        .comingConfirmedList
                                        .length
                                        .toString(),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Calender(),
              // key: Key('uiniv'),
              TutorialCalendar(),

              // key: Key('uiniv')

              OrdersList(ordersList: sharedOrder.listOfDay, hero: '1'),

              dataLoading ? Center(child: Loading()) : SizedBox(),
              SizedBox(height: ScreenUtil().setHeight(200))
            ],
          ),
        ],
      ),
    );
  }
}

class OrdersList extends StatefulWidget {
  final List<Order> ordersList;
  final String hero;
  OrdersList({Key key, this.ordersList, this.hero}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: widget.ordersList.length == 0
          ? SizedBox()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.ordersList.length,
              // cacheExtent: 8,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
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
                                tag: widget.ordersList[index].doc_id + 'ok',
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(9),
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
                              builder: (_) => PageOrderDetail(
                                  order: widget.ordersList[index],
                                  heroTag: widget.ordersList[index].doc_id),
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
                                string:
                                    'السعر: ${widget.ordersList[index].total_price}',
                                textAlign: TextAlign.right,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Builder(builder: (_) {
                                    List<String> list = [];
                                    Map<String, dynamic> mapper =
                                        Provider.of<SharedSalon>(context)
                                            .providedServices;

                                    widget.ordersList[index].services
                                        .forEach((k, v) {
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
    if (widget.ordersList[index].client_order_date
            .isBefore(DateTime.now().toLocal()) &&
        (widget.ordersList[index].status == 3 ||
            widget.ordersList[index].status == 8))
      return 'مرحبا، نرجو تأكيد اتمام العملية  (${widget.ordersList[index].client_name})  ${getDate(widget.ordersList[index].client_order_date)}';
    else
      return '${getOrderStatus(widget.ordersList[index].status)} (${widget.ordersList[index].client_name})  ${getDate(widget.ordersList[index].client_order_date)}';
  }
}

String getDate(DateTime date) {
  return 'الوقت ${date.hour}:${date.minute}';
}
