import 'package:beautina_provider/core/controller/load_controller.dart';
import 'package:beautina_provider/core/global_values/responsive/orders.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/services/api/db_orders.dart';
import 'package:get/instance_manager.dart';

class OrdersController {
  List<Order> loadSelectedDayList(DateTime dateTime) {
    return Get.find<GlobalValOrders>()
        .todayOrder
        .value
        .where((order) => (order.client_order_date?.month == dateTime.month &&
            order.client_order_date?.day == dateTime.day))
        .toList();
  }

  Future loadMonthOrderList(int month) async {
    // GlobalValFunController.load(
    //     load: load,
    //     onError: onError,
    //     onFinally: onFinally,
    //     globalVal: globalVal);
  }

  List<Order> getSelectedDayList(DateTime dateTime) {
    return Get.find<GlobalValOrders>().todayOrder.value;
  }

  List<Order> getMonthorderList(DateTime fromDate) {
    return Get.find<GlobalValOrders>().allOrders.value;
  }
}
