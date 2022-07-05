import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/services/api/db_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

String? getOrderStatus(OrderStatus? status) {
  switch (status) {
    case OrderStatus.NewOrder:
      return 'طلب جديد';
    case OrderStatus.AcceptedByProvider:
      return 'طلب بإنتظار تأكيد الزبونه';
    case OrderStatus.CanceledByCustomer:
      return 'طلب ملغي';
    case OrderStatus.ConfirmedByCustomer:
      return "طلب تام ومؤكد من الزبونة";
    case OrderStatus.RejectedByProvider:
      return 'طلب تم رفضة';
    case OrderStatus.FinishedSuccessfully:
      return 'طلب منتهي بانتظار التقييم';
    case OrderStatus.Evaluated:
      return 'تم تقييم الطلب من الزبون';
    case OrderStatus.FinishedUncorrectly:
      return 'طلب منتهي غير مكتمل';
    case OrderStatus.ClaimFinishedCorrectly:
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
  // Get.find<VmDateDataTest>().isLoading = true;
  // Get.find<VmDateDataTest>().notifyListeners();
  // await Future.delayed(Duration(seconds: 1));
  await Get.find<VmDateDataTest>().iniState();
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
  Get.find<VmDateDataTest>().iniState(); //this will refresh orders list
}
