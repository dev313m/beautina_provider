import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Map<DateTime, List<dynamic>> getBusyDatesEvents(BuildContext context) {
  Map<DateTime, List<dynamic>> events = {};

  Provider.of<VMSalonData>(context).beautyProvider.busyDates.forEach((f) {
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

///This method combine events and use busy dates as also events

Map<DateTime, List<dynamic>> getEvents(List<Order> orders, BuildContext context) {
  Map<DateTime, List<dynamic>> events = getBusyDatesEvents(context);

  Provider.of<VmDateData>(context).orderList.forEach((f) {
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

onCalendarDaySelected(DateTime date, List<dynamic> events, BuildContext context) async {
  List<Order> list = events.cast();
  Provider.of<VmDateData>(context).calanderChosenDay = date;

  Provider.of<VmDateData>(context).listOfDay = [];
  Provider.of<VmDateData>(context).isShowAvailableWidget = false;
  await Future.delayed(Duration(milliseconds: 200));
  Provider.of<VmDateData>(context).isShowAvailableWidget = true;

  Provider.of<VmDateData>(context).listOfDay = list.where((item) => item.status == 0 || item.status == 1 || item.status == 3).toList();
}

onVisibleDaysChanged(BuildContext context, DateTime date) async {
  int currentMonth = Provider.of<VmDateData>(context).month;
  if (currentMonth < date.month) {
    Provider.of<VmDateData>(context).month = date.month;
    Provider.of<VmDateData>(context).isLoading = true;

    await Provider.of<VmDateData>(context).apiLoadMore();
    Provider.of<VmDateData>(context).isLoading = false;
  }
}
