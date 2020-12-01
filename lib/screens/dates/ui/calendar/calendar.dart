import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/day_builder.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/event_marker.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/function.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/selected_day.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/today_builder.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WdgtDateCalendar extends StatefulWidget {
  WdgtDateCalendar({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<WdgtDateCalendar>
    with TickerProviderStateMixin {
  int month;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();

    month = DateTime.now().toLocal().month;
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
          color: CalendarColors.container,
          child: Stack(
            children: <Widget>[
              TableCalendar(
                calendarController: _calendarController,
                events: getEvents(
                    Provider.of<VmDateData>(context).orderList, context),
                availableGestures: AvailableGestures.horizontalSwipe,
                headerVisible: true,
                initialCalendarFormat: CalendarFormat.month,

                ///[to-do check this ondayselected third parameter]
                onDaySelected: (date, events, _) async {
                  onCalendarDaySelected(date, events, context);
                },
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onVisibleDaysChanged: (time, date, format) async {
                  onVisibleDaysChanged(context, date);
                  // month = time.month;
                },
                headerStyle: HeaderStyle(
                  formatButtonTextStyle: TextStyle().copyWith(
                      color: CalendarColors.header,
                      fontSize: ExtendedText.defaultFont),
                  formatButtonDecoration: BoxDecoration(
                    color: CalendarColors.headerContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                formatAnimation: FormatAnimation.slide,
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, list) {
                    return WdgtDateCalendarSelectedDay(
                      animationController: _animationController,
                      date: date,
                      list: list,
                    );
                  },
                  markersBuilder: (context, date, events, holidays) {
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
                              calendarController: _calendarController,
                              color: CalendarColors.bottomLeft),
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
                              calendarController: _calendarController,
                              color: CalendarColors.bottomRight),
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
                              calendarController: _calendarController,
                              color: CalendarColors.topNoti),
                        ),
                      );
                    }

                    return children;
                  },
                  dayBuilder: (_, date, list) {
                    // if(newOrders ==null || acceptedOrder ==null || approvedOrder == null)
                    if (list == null) list = [];
                    return WdgtDateCalendarDayBuilder(
                      date: date,
                      list: list,
                    );
                  },
                  todayDayBuilder: (context, date, _) {
                    return WdgtDateCalendarTodayBuilder(
                      date: date,
                    );
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Provider.of<VmDateData>(context).isLoading
                    ? Align(
                        child: Loading(),
                        alignment: Alignment.center,
                      )
                    : SizedBox(),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  // height: 50,
                  // left: MediaQuery.of(context).size.width / 2 - ScreenUtil().setWidth(ConstDateSizes.reloadLeft),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                    // color: Colors.pink,
                    child: Material(
                      color: Colors.purple,
                      child: IconButton(
                          color: Colors.white,
                          disabledColor: Colors.brown,
                          icon: Icon(CommunityMaterialIcons.reload),
                          highlightColor: Colors.deepOrangeAccent,
                          focusColor: Colors.deepOrangeAccent,
                          hoverColor: Colors.deepOrangeAccent,
                          splashColor: Colors.pink,
                          onPressed: () async {
                            Provider.of<VmDateData>(context).isLoading = true;
                            await pagesRefresh(context);
                          }),
                    ),
                  )),
            ],
          )),
    );
  }
}
