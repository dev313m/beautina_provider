import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/db_orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

String getDateString(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  String day = dateTime.day.toString();
  String hour = dateTime.hour.toString();
  String min = dateTime.minute.toString();
  return '$year/$month/$day ~ $hour:$min';
}

int getStep(int status) {
  if (status == 0)
    return 0;
  else if (status == 1)
    return 1;
  else
    return 2;
}

String getOrderStatus(int status) {
  switch (status) {
    case 0:
      return 'طلب جديد';
    case 1:
      return 'طلب بإنتظار تأكيد الزبونه';
    case 2:
      return 'طلب ملغي';
    case 3:
      return "طلب تام ومؤكد من الزبونة";
    case 4:
      return 'طلب تم رفضة';
    case 5:
      return 'طلب منتهي بانتظار التقييم';
    case 6:
      return 'تم تقييم الطلب من الزبون';
    case 7:
      return 'طلب منتهي غير مكتمل';
    case 8:
      return 'طلب منتهي';
  }
}

///If success it will return true other it will return false
Future<bool> getFunctionReject(
  Order order,
  BuildContext context,
) async {
  try {
    await apiOrderReject(order);
    await refreshList(context);
    return true;
    // print('Stream is hersa ');
  } catch (e) {
    return false;
  }
}

Future refreshList(BuildContext context) async {
  // Provider.of<VmDateData>(context).isLoading = true;
  // Provider.of<VmDateData>(context).notifyListeners();
  // await Future.delayed(Duration(seconds: 1));
  await Provider.of<VmDateData>(context).iniState();
}

Future<bool> getFunctionAccept(Order order, BuildContext context) async {
  if (order.order_duration == null) {
    showToast('يجب اختيار الوقت المتوقع لإنها الخدمة');
    return false;
  }
  try {
    await apiOrderAccept(order);
    await refreshList(context);
    return true;
    // print('Stream is hersa ');
  } catch (e) {
    return false;
  }
}

Future<bool> getFunctionFinishedIncomplete(
    Order order, BuildContext context) async {
  try {
    await apiFinishedIncomplete(order);
    await refreshList(context);
    showToast('تم ابلاغك شكرا لكِ');

    return true;
    // print('Stream is hersa ');
  } catch (e) {
    return false;
  }
}

Future<bool> getFunctionFinishedComplete(
    Order order, BuildContext context) async {
  try {
    await apiFinishedComplete(order);
    await refreshList(context);
    showToast('تم ابلاغك شكرا لكِ');

    return true;
    // print('Stream is hersa ');
  } catch (e) {
    return false;
  }
}

List<Order> getFilteredList(List<Order> list, int index) {
  if (index == 5)
    return list;
  else if (index == 4)
    return list.where((order) => (order.status == 3)).toList();
  else if (index == 3)
    return list.where((order) => (order.status == 0)).toList();
  else if (index == 2)
    return list.where((order) => (order.status == 1)).toList();
  else if (index == 1)
    return list
        .where((order) => (order.status == 2 || order.status == 4))
        .toList();
  else
    return list
        .where((order) => (order.status == 5 ||
            order.status == 6 ||
            order.status == 7 ||
            order.status == 8))
        .toList();
}

Future<void> pagesRefresh(BuildContext context) async {
  Provider.of<VmDateData>(context).iniState(); //this will refresh orders list
}
