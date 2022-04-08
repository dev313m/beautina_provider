import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/day_builder.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/event_marker.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/selected_day.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/today_builder.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/utils/animated/loading.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/constants/app_colors.dart';

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
    return Obx(() {
      var vmDateDataTest = Get.find<VmDateDataTest>();
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        child: Container(
            color: colorContainer,
            child: Stack(
              children: <Widget>[
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TableCalendar(
                    eventLoader: (date) {
                      return vmDateDataTest.orderList!.where((element) =>
                          (element.creation_data!.month == date.month &&
                              element.creation_data!.day == date.day) &&
                          (element.status == 0 ||
                              element.status == 1 ||
                              element.status == 3)) as List<Order>;
                    },
                    firstDay: DateTime.now(),
                    focusedDay: DateTime.now(),
                    lastDay: DateTime.now().add(Duration(days: 30)),
                    availableCalendarFormats: {
                      CalendarFormat.week: 'الاسبوع',
                      CalendarFormat.month: 'الشهر',
                      CalendarFormat.twoWeeks: "بعد اسبوعين"
                    },

                    startingDayOfWeek: StartingDayOfWeek.saturday,

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
                      await Future.delayed(const Duration(milliseconds: 500));
                      vmDateDataTest.listOfDay = vmDateDataTest.orderList!
                          .where((item) =>
                              (item.creation_data!.month == date.month &&
                                  item.creation_data!.day == date.day) &&
                              (item.status == 0 ||
                                  item.status == 1 ||
                                  item.status == 3))
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
                    headerStyle: HeaderStyle(formatButtonVisible: false),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, date2) {
                        var list = vmDateDataTest.orderList!
                            .where((item) =>
                                (item.creation_data!.month == date.month &&
                                    item.creation_data!.day == date.day) &&
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
                        List<dynamic> newOrders =
                            events.where((event) => event.status == 0).toList();
                        List<dynamic> acceptedOrder =
                            events.where((event) => event.status == 1).toList();
                        List<dynamic> approvedOrder =
                            events.where((event) => event.status == 3).toList();

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
                      defaultBuilder: (_, date, date2) {
                        var list = vmDateDataTest.orderList!
                            .where((item) =>
                                (item.creation_data!.month == date.month &&
                                    item.creation_data!.day == date.day) &&
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
                            icon: Icon(CommunityMaterialIcons.reload),
                            highlightColor: Colors.deepOrangeAccent,
                            focusColor: Colors.deepOrangeAccent,
                            hoverColor: Colors.deepOrangeAccent,
                            splashColor: Colors.pink,
                            onPressed: () async {
                              Get.find<VmDateDataTest>().isLoading = true;
                              await pagesRefresh(context);
                            }),
                      ),
                    )),
              ],
            )),
      );
    });
  }
}
