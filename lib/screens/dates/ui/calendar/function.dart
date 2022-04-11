import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Map<DateTime, List<dynamic>?> getBusyDatesEvents(BuildContext context) {
  Map<DateTime, List<dynamic>?> events = {};

  Get.find<GlobalValBeautyProviderListenable>().beautyProvider.busyDates!.forEach((f) {
    DateTime fromDate = DateTime.utc(f['from']!.year, f['from']!.month, f['from']!.day);
    DateTime? toDate = f['to'];
    if (events[fromDate] == null) events[fromDate] = [];

    //if there is only one day add it
    if (fromDate == toDate)
      events[fromDate] = events[fromDate]?..add(Order(status: -1));
    else {
      //add first day in the range
      events[fromDate] = events[fromDate]?..add(Order(status: -1));
      int i = 1;
      // add all the days in the range
      while (fromDate.add(Duration(days: i)).isBefore(toDate!)) {
        if (events[fromDate.add(Duration(days: i))] == null) events[fromDate.add(Duration(days: i))] = [];
        events[fromDate.add(Duration(days: i))] = events[fromDate.add(Duration(days: i))]?..add(Order(status: -1));
        i++;
      }
    }
  });
  return events;
}

///This method combine events and use busy dates as also events

Map<DateTime, List<dynamic>?> getEvents(List<Order> orders, BuildContext context) {
  Map<DateTime, List<dynamic>?> events = getBusyDatesEvents(context);

  Get.find<VmDateDataTest>().orderList!.forEach((f) {
    DateTime dbDate = f.client_order_date!;
    DateTime date = DateTime.utc(dbDate.year, dbDate.month, dbDate.day);
    // events[date] = events[date] == null ? [f] : events[date]
    //  ..add(f);

    if (events[date] == null)
      events[date] = [f];
    else
      events[date] = events[date]?..add(f);
  });
  return events;
}

onCalendarDaySelected(DateTime date, List<dynamic> events, BuildContext context) async {
  List<Order> list = events.cast();
  Get.find<VmDateDataTest>().calanderChosenDay = date;

  Get.find<VmDateDataTest>().listOfDay = [];
  Get.find<VmDateDataTest>().isShowAvailableWidget = false;
  await Future.delayed(Duration(milliseconds: 200));
  Get.find<VmDateDataTest>().isShowAvailableWidget = true;

  Get.find<VmDateDataTest>().listOfDay = list.where((item) => item.status == 0 || item.status == 1 || item.status == 3).toList();
}

onVisibleDaysChanged(BuildContext context, DateTime date) async {
  int currentMonth = Get.find<VmDateDataTest>().month;
  if (currentMonth < date.month) {
    Get.find<VmDateDataTest>().month = date.month;
    Get.find<VmDateDataTest>().isLoading = true;

    await Get.find<VmDateDataTest>().apiLoadMore();
    Get.find<VmDateDataTest>().isLoading = false;
  }
}
