import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/day_builder.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/event_marker.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/selected_day.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/today_builder.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/utils/animated/loading.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:intl/intl.dart' as dateUtil;

///[radius]
final double radius = radiusDefault;

///[colors]
Color colorContainer = ConstDatesColors.littleList.withAlpha(200);

Color colorEvent = CalendarColors.eventColor;
Color colorTopNoti = CalendarColors.topNoti;
Color colorBottomLeftNoti = CalendarColors.bottomLeft;
Color colorBottomRightNoti = CalendarColors.bottomRight;
Color colorReloadBtn = AppColors.blue;

class WdgtDateCalendar extends StatefulWidget {
  WdgtDateCalendar({Key? key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<WdgtDateCalendar>
    with TickerProviderStateMixin {
  int? month;
  DateTime _focusedDate = DateTime.now();
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController!.forward();

    month = DateTime.now().toLocal().month;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VmDateDataTest>(builder: (vmDateDataTest) {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        child: Container(
            color: AppColors.blueOpcity.withOpacity(0.9),
            child: Stack(
              children: <Widget>[
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TableCalendar(
                    eventLoader: (date) {
                      var days = vmDateDataTest.orderList!.where((element) {
                        return (element.client_order_date!.month ==
                                    date.month &&
                                element.client_order_date!.day == date.day) &&
                            (element.status!.index == 0 ||
                                element.status!.index == 1 ||
                                element.status!.index == 3);
                      }).toList();

                      return days;
                    },
                    firstDay: DateTime.now(),
                    focusedDay: _focusedDate.add(Duration(days: 1)),
                    lastDay: DateTime.now().add(Duration(days: 30)),
                    availableCalendarFormats: {
                      CalendarFormat.week: 'الاسبوع',
                      CalendarFormat.month: 'الشهر',
                      CalendarFormat.twoWeeks: "بعد اسبوعين"
                    },
                    calendarFormat: CalendarFormat.twoWeeks,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    dayHitTestBehavior: HitTestBehavior.deferToChild,
                    pageAnimationEnabled: true,

                    // // locale: 'ar_AR',
                    // events: getEvents(
                    //     Get.find<VmDateDataTest>().orderList, context),
                    availableGestures: AvailableGestures.horizontalSwipe,
                    headerVisible: true,

                    ///[to-do check this ondayselected third parameter]
                    onDaySelected: (
                      date,
                      events,
                    ) async {
                      vmDateDataTest.listOfDay = [];
                      _focusedDate = date;
                      setState(() {});
                      // await Future.delayed(const Duration(milliseconds: 500));
                      vmDateDataTest.listOfDay = vmDateDataTest.orderList!
                          .where((item) =>
                              (item.client_order_date!.month == date.month &&
                                  item.client_order_date!.day == date.day) &&
                              (item.status!.index == 0 ||
                                  item.status!.index == 1 ||
                                  item.status!.index == 3))
                          .toList();
                      // onCalendarDaySelected(date, events, context);
                    },
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                    ),
                    // onVisibleDaysChanged: (time, date, format) async {
                    //   onVisibleDaysChanged(context, date);
                    //   // month = time.month;
                    // },
                    onPageChanged: (date) async {
                      int currentMonth = vmDateDataTest.month;
                      if (currentMonth < date.month) {
                        vmDateDataTest.month = date.month;
                        vmDateDataTest.isLoading = true;

                        await vmDateDataTest.apiLoadMore();
                        vmDateDataTest.isLoading = false;
                      }
                      // month = time.month;
                    },
                    selectedDayPredicate: (day) {
                      if (day.month == _focusedDate.month &&
                          day.day == _focusedDate.day) return true;
                      return false;
                    },

                    headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(color: Colors.white),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.amber.withOpacity(0.9),
                          size: 16,
                        ),
                        formatButtonVisible: false,
                        titleCentered: true),
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (_, day) {
                        return GWdgtTextTitleDesc(
                          string: getArDay(day),
                          color: Colors.amber.withOpacity(0.7),
                        );
                      },
                      selectedBuilder: (context, date, date2) {
                        var list = vmDateDataTest.orderList!
                            .where((item) =>
                                (item.creation_date?.month == date.month &&
                                    item.creation_date?.day == date.day) &&
                                (item.status == 0 ||
                                    item.status == 1 ||
                                    item.status == 3))
                            .toList();
                        return WdgtDateCalendarSelectedDay(
                          animationController: _animationController,
                          date: date,
                          list: list,
                        );
                      },
                      markerBuilder: (context, date, List<Order> events) {
                        final children = <Widget>[];
                        var newOrders = events
                            .where((event) => event.status!.index == 0)
                            .toList();
                        var acceptedOrder = events
                            .where((event) => event.status!.index == 1)
                            .toList();
                        var approvedOrder = events
                            .where((event) => event.status!.index == 3)
                            .toList();

                        if (newOrders.isNotEmpty) {
                          children.add(
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: WdgtDateCalendarEventMarker(
                                  date: date,
                                  events: newOrders,
                                  color: colorBottomLeftNoti),
                            ),
                          );
                        }

                        if (acceptedOrder.isNotEmpty) {
                          children.add(
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: WdgtDateCalendarEventMarker(
                                  date: date,
                                  events: acceptedOrder,
                                  color: colorBottomRightNoti),
                            ),
                          );
                        }
                        if (approvedOrder.isNotEmpty) {
                          children.add(
                            Positioned(
                              right: 0,
                              top: 0,
                              child: WdgtDateCalendarEventMarker(
                                  date: date,
                                  events: approvedOrder,
                                  color: colorTopNoti),
                            ),
                          );
                        }

                        return Stack(
                          children: children,
                        );
                      },
                      disabledBuilder: ((context, day, focusedDay) {
                        return SizedBox();
                      }),
                      defaultBuilder: (_, date, date2) {
                        var list = vmDateDataTest.orderList!
                            .where((item) =>
                                (item.creation_date!.month == date.month &&
                                    item.creation_date!.day == date.day) &&
                                (item.status == 0 ||
                                    item.status == 1 ||
                                    item.status == 3))
                            .toList();
                        // if(newOrders ==null || acceptedOrder ==null || approvedOrder == null)
                        if (list == null) list = [];
                        return WdgtDateCalendarDayBuilder(
                          date: date,
                          list: list,
                        );
                      },
                      todayBuilder: (context, date, _) {
                        return WdgtDateCalendarTodayBuilder(
                          date: date,
                        );
                      },
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: Get.find<VmDateDataTest>().isLoading
                      ? Align(
                          child: GetLoadingWidget(),
                          alignment: Alignment.center,
                        )
                      : SizedBox(),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    // height: 50,
                    // left: MediaQuery.of(context).size.width / 2 - ScreenUtil().setWidth(ConstDateSizes.reloadLeft),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            bottomRight: Radius.circular(radius)),
                        // color: Colors.pink,
                        child: Material(
                          color: colorReloadBtn,
                          child: IconButton(
                              color: Colors.white,
                              disabledColor: Colors.brown,
                              icon: Icon(
                                CommunityMaterialIcons.reload,
                                color: Colors.amber,
                              ),
                              highlightColor: Colors.deepOrangeAccent,
                              focusColor: Colors.deepOrangeAccent,
                              hoverColor: Colors.deepOrangeAccent,
                              splashColor: Colors.pink,
                              onPressed: () async {
                                Get.find<VmDateDataTest>().isLoading = true;
                                await pagesRefresh(context);
                              }),
                        ),
                      ),
                    )),
              ],
            )),
      );
    });
  }

  getArDay(DateTime enDay) {
    var day = dateUtil.DateFormat('EEEE').format(enDay);

    switch (day) {
      case "Sunday":
        return 'الاحد';
      case "Monday":
        return 'الاثنين';
      case "Tuesday":
        return 'الثلاثاء';
      case "Wednesday":
        return 'الاربعاء';
      case "Thursday":
        return 'الخميس';
      case "Friday":
        return 'الجمعة';
      case "Saturday":
        return 'السبت';
    }
  }
}
