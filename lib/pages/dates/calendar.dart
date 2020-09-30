import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/pages/dates/constants.dart';
import 'package:beautina_provider/pages/dates/functions.dart';
import 'package:beautina_provider/pages/dates/shared_variables_order.dart';
import 'package:beautina_provider/pages/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  Calender({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with TickerProviderStateMixin {
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

  Map<DateTime, List<dynamic>> getBusyDatesEvents() {
    Map<DateTime, List<dynamic>> events = {};

    Provider.of<SharedSalon>(context).beautyProvider.busyDates.forEach((f) {
      DateTime fromDate = DateTime.utc(f['from'].year, f['from'].month, f['from'].day);
      DateTime toDate = f['to'];
      if (events[fromDate] == null) events[fromDate] = [];

      //if there is only one day add it
      if (fromDate == toDate)
        events[fromDate] = events[fromDate]..add(Order(status: -1));
      else {
        //add first day in the range
        events[fromDate] = events[fromDate]..add(Order(status: -1));
        int i = 1;
        // add all the days in the range
        while (fromDate.add(Duration(days: i)).isBefore(toDate)) {
          if (events[fromDate.add(Duration(days: i))] == null) events[fromDate.add(Duration(days: i))] = [];
          events[fromDate.add(Duration(days: i))] = events[fromDate.add(Duration(days: i))]..add(Order(status: -1));
          i++;
        }
      }
    });
    return events;
  }

  Map<DateTime, List<dynamic>> getEvents(List<Order> orders) {
    Map<DateTime, List<dynamic>> events = getBusyDatesEvents();

    Provider.of<SharedOrder>(context).orderList.forEach((f) {
      DateTime dbDate = f.client_order_date;
      DateTime date = DateTime.utc(dbDate.year, dbDate.month, dbDate.day);
      // events[date] = events[date] == null ? [f] : events[date]
      //  ..add(f);

      if (events[date] == null)
        events[date] = [f];
      else
        events[date] = events[date]..add(f);
    });
    return events;
  }

  Widget _buildEventsMarker(DateTime date, List events, Color color) {
    return Container(
      width: ScreenUtil().setWidth(30),
      height: ScreenUtil().setWidth(30),
      child: ClipOval(
        child: AnimatedContainer(
          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            color: _calendarController.isSelected(date) ? color : _calendarController.isToday(date) ? Colors.brown[300] : color,
          ),
          // width: ScreenUtil().setWidth(16),
          // height: ScreenUtil().setWidth(16),
          child: Center(
            child: ExtendedText(
              string: '${events.length}',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
      child: Container(
          color: CalendarColors.container,
          child: Stack(
            children: <Widget>[
              TableCalendar(
                calendarController: _calendarController,
                events: getEvents(Provider.of<SharedOrder>(context).orderList),
                availableGestures: AvailableGestures.horizontalSwipe,
                // holidays: getEvents(Provider.of<SharedOrder>(context).orderList),
                headerVisible: true,
                initialCalendarFormat: CalendarFormat.month,

                onDaySelected: (date, events) async {
                  List<Order> list = events.cast();
                  Provider.of<SharedOrder>(context).calanderChosenDay = date;

                  Provider.of<SharedOrder>(context).listOfDay = [];
                  Provider.of<SharedOrder>(context).isShowAvailableWidget = false;
                  await Future.delayed(Duration(milliseconds: 200));
                  Provider.of<SharedOrder>(context).isShowAvailableWidget = true;

                  Provider.of<SharedOrder>(context).listOfDay = list.where((item) => item.status == 0 || item.status == 1 || item.status == 3).toList();
                },
                calendarStyle: CalendarStyle(
                  // selectedColor: Colors.deepOrange[400],
                  // todayColor: Colors.deepOrange[200],
                  // markersColor: Colors.brown[700],
                  outsideDaysVisible: false,
                ),

                onVisibleDaysChanged: (time, date, format) async {
                  int currentMonth = Provider.of<SharedOrder>(context).month;
                  if (currentMonth < date.month) {
                    Provider.of<SharedOrder>(context).month = date.month;
                    Provider.of<SharedOrder>(context).isLoading = true;

                    await Provider.of<SharedOrder>(context).apiLoadMore();
                    Provider.of<SharedOrder>(context).isLoading = false;
                  }
                  // month = time.month;
                },
                headerStyle: HeaderStyle(
                  formatButtonTextStyle: TextStyle().copyWith(color: CalendarColors.header, fontSize: ExtendedText.defaultFont),
                  formatButtonDecoration: BoxDecoration(
                    color: CalendarColors.headerContainer,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),

                formatAnimation: FormatAnimation.slide,
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, list) {
                    return FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: CalendarColors.todayContainer, borderRadius: BorderRadius.circular(9)),
                            // margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(100),
                            child: ExtendedText(
                              string: '${date.day}',
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              fontSize: ExtendedText.bigFont,
                              fontColor: Colors.white,
                              // style: TextStyle().copyWith(fontSize: 16.0),
                            ),
                          ),
                          if (list != null)
                            if (list.where((element) => element.status == -1).length > 0)
                              Align(
                                alignment: Alignment.center,
                                child: Icon(CommunityMaterialIcons.lock),
                              )
                        ],
                      ),
                    );
                  },
                  markersBuilder: (context, date, events, holidays) {
                    final children = <Widget>[];
                    List<dynamic> newOrders = events.where((event) => event.status == 0).toList();
                    List<dynamic> acceptedOrder = events.where((event) => event.status == 1).toList();
                    List<dynamic> approvedOrder = events.where((event) => event.status == 3).toList();

                    if (newOrders.isNotEmpty) {
                      children.add(
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: _buildEventsMarker(date, newOrders, CalendarColors.bottomLeft),
                        ),
                      );
                    }

                    if (acceptedOrder.isNotEmpty) {
                      children.add(
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: _buildEventsMarker(
                              date,
                              acceptedOrder,
                              CalendarColors.bottomRight,
                            )),
                      );
                    }
                    if (approvedOrder.isNotEmpty) {
                      children.add(
                        Positioned(
                          right: 0,
                          top: 0,
                          child: _buildEventsMarker(date, approvedOrder, CalendarColors.topNoti),
                        ),
                      );
                    }

                    return children;
                  },
                  dayBuilder: (_, date, list) {
                    // if(newOrders ==null || acceptedOrder ==null || approvedOrder == null)
                    if (list == null) list = [];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: list.where((item) => item.status == 0 || item.status == 1 || item.status == 3).toList().length == 0 ? CalendarColors.empty : CalendarColors.eventColor,
                              borderRadius: BorderRadius.circular(9)),
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setHeight(100),
                          child: ExtendedText(
                            string: '${date.day}',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            fontSize: ExtendedText.bigFont,
                            fontColor: Colors.white38,
                            // style: TextStyle().copyWith(fontSize: 16.0),
                          ),
                        ),
                        if (list.where((element) => element.status == -1).length > 0)
                          Align(
                            alignment: Alignment.center,
                            child: Icon(CommunityMaterialIcons.lock),
                          )
                      ],
                    );
                  },
                  todayDayBuilder: (context, date, _) {
                    return Container(
                      decoration: BoxDecoration(color: CalendarColors.todayContainer, borderRadius: BorderRadius.circular(9)),
                      margin: const EdgeInsets.all(4.0),
                      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(100),
                      child: ExtendedText(
                        string: 'اليوم: ${date.day} ',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.left,
                        fontSize: ExtendedText.bigFont,
                        fontColor: Colors.black54,
                      ),
                    );
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Provider.of<SharedOrder>(context).isLoading
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(9), bottomRight: Radius.circular(9)),
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
                            Provider.of<SharedOrder>(context).isLoading = true;
                            await pagesRefresh(context);
                          }),
                    ),
                  )),
            ],
          )),
    );
  }
}
