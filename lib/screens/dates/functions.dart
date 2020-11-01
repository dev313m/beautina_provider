import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/shared_variables_order.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/db_orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

Function getFunctionReject(Order order, BuildContext context) {
  Function f = (AnimationController ac) async {
    ac.forward();
    try {
      await apiOrderReject(order);

      // apiNotificationAdd(MyNotification(
      //     client_id: order.client_id,
      //     createDate: DateTime.now().toString(),
      //     describ: 'قامت ${order.client_name} بإلغاء الطلب، الله كريم',
      //     from_token: '',
      //     to_token: order.tokens.elementAt(0),
      //     icon: '',
      //     image: '',
      //     title: 'الغاء الطلب',
      //     type: '0')
      //   ..toFirestoreMap());
      // ac.reverse();
      await refreshList(context);

      showToast('تم الغاء الطلب شكرا لتنبيهك');
      // print('Stream is hersa ');
    } catch (e) {
      showToast(e.toString());
    }
  };
  return f;
}

Future refreshList(BuildContext context) async {
  // Provider.of<SharedOrder>(context).isLoading = true;
  // Provider.of<SharedOrder>(context).notifyListeners();
  // await Future.delayed(Duration(seconds: 1));
  await Provider.of<SharedOrder>(context).iniState();
}

Function getFunctionAccept(Order order, BuildContext context) {
  Function f = (AnimationController ac) async {
    //Check if order duration is set

    if (order.order_duration == null) {
      showToast('يجب اختيار الوقت المتوقع لإنها الخدمة');
      return;
    }
    ac.forward();

    try {
      await apiOrderAccept(order);
      // await apiNotificationAdd(MyNotification(
      //     client_id: order.client_id,
      //     createDate: DateTime.now().toString(),
      //     describ: 'مبروك، قامت الزبونة بتأكيد الطلب',
      //     from_token: '',
      //     to_token: order.tokens.elementAt(0),
      //     icon: '',
      //     image: '',
      //     title: 'طلب مؤكد',
      //     type: '0')
      //   ..toFirestoreMap());
      refreshList(context);
      showToast('مبروك، طلبك مؤكد');
    } catch (e) {
      showToast(e.toString());
    }
  };
  return f;
}

Function getFunctionFinishedIncomplete(Order order, BuildContext context) {
  Function f = (AnimationController ac) async {
    ac.forward();

    try {
      await apiFinishedIncomplete(order);
      // await apiNotificationAdd(MyNotification(
      //     client_id: order.client_id,
      //     createDate: DateTime.now().toString(),
      //     describ: 'مبروك، قامت الزبونة بتأكيد الطلب',
      //     from_token: '',
      //     to_token: order.tokens.elementAt(0),
      //     icon: '',
      //     image: '',
      //     title: 'طلب مؤكد',
      //     type: '0')
      //   ..toFirestoreMap());
      refreshList(context);
      showToast('تم ابلاغك شكرا لكِ');
    } catch (e) {
      showToast(e.toString());
    }
  };
  return f;
}

Function getFunctionFinishedComplete(Order order, BuildContext context) {
  Function f = (AnimationController ac) async {
    ac.forward();

    try {
      await apiFinishedComplete(order);
      // await apiNotificationAdd(MyNotification(
      //     client_id: order.client_id,
      //     createDate: DateTime.now().toString(),
      //     describ: 'مبروك، قامت الزبونة بتأكيد الطلب',
      //     from_token: '',
      //     to_token: order.tokens.elementAt(0),
      //     icon: '',
      //     image: '',
      //     title: 'طلب مؤكد',
      //     type: '0')
      //   ..toFirestoreMap());
      refreshList(context);
      showToast('تم ابلاغك شكرا لكِ');
    } catch (e) {
      showToast(e.toString());
    }
  };
  return f;
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
    return list.where((order) => (order.status == 2 || order.status == 4)).toList();
  else
    return list.where((order) => (order.status == 5 || order.status == 6 || order.status == 7 || order.status == 8)).toList();
}

Future<void> pagesRefresh(BuildContext context) async {
  Provider.of<SharedOrder>(context).iniState(); //this will refresh orders list
}
