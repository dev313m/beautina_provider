import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/db_orders.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SharedOrder with ChangeNotifier {
  bool build = true;
  // the required to download month
  int month = DateTime.now().toLocal().month;
  bool _isLoading = true;
  List<Order> comingConfirmedList = [];
  String lastDoc = '';
  List<Order> _listOfDay = [];

  // List<Order> _toConfirmList = [];

  List<Order> get listOfDay => _listOfDay;

  set listOfDay(List<Order> listOfDay) {
    _listOfDay = listOfDay;
    notifyListeners();
  }

  /// 2 for all
  /// 1 for active
  /// 0 for not active
  int filterIndex = 5;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool isError = false;

  List<Order> orderList = [];

  /// 2 for all
  /// 1 for active
  /// 0 for not active
  // List<Order> _filteredList;

  /// 2 for all
  /// 1 for active
  /// 0 for not active
  // List<Order> get filteedList => _filteredList;

  /// 2 for all
  /// 1 for active
  /// 0 for not active
  // set filteredList(List<Order> filteredList) {
  //   _filteredList = filteredList;
  //   notifyListeners();
  // }

  SharedOrder({this.build = true}) {
    if (build) iniState();
  }

  iniState() async {
    getDefaults();
    try {
      // await Future.delayed(Duration(seconds: 5));

      orderList =
          await getOrders(day: DateTime.now().toLocal().day, month: month);
      comingConfirmedList = await getComingConfirmed();

      if (orderList.length != 0) lastDoc = orderList.last.doc_id;
      // sort();
      setInitialDayList();

      isLoading = false;
      // notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
      // showToast(e.toString());
    }
  }

  setInitialDayList() {
    listOfDay = orderList
        .where((item) =>
            item.client_order_date.month == DateTime.now().toLocal().month &&
            item.client_order_date.day == DateTime.now().toLocal().day &&
            item.client_order_date.year == DateTime.now().toLocal().year)
        .where(
            (item) => item.status == 3 || item.status == 0 || item.status == 1)
        .toList();

    // toConfirmList = orderList
    //     .where((item) =>
    //         item.status == 1 ||
    //         (item.client_order_date.isBefore(DateTime.now()) &&
    //             (item.status == 3 || item.status == 8)))
    //     .toList();
  }

  Future apiLoadMore() async {
    try {
      List<Order> moreOrders = await getOrders(day: 0, month: month);
      // if (moreOrders.length != 0) lastDoc = moreOrders.last.doc_id;

      orderList.addAll(moreOrders);
      // sort();
      return;
    } catch (e) {
      showToast('هناك خطأ:$e.toString()');
    }
  }

  // sort() {
  //   orderList.sort((a, b) {
  //     return b.client_order_date.compareTo(a.client_order_date);
  //   });
  // }

  // List<Order> get toConfirmList => _toConfirmList;

  // set toConfirmList(List<Order> toConfirmList) {
  //   _toConfirmList = toConfirmList;
  //   notifyListeners();
  // }

  getDefaults() {
    lastDoc = '';
    isError = false;
    isLoading = true;
    notifyListeners();
  }
}
