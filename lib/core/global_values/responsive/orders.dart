import 'package:beautina_provider/core/global_values/core/async_api.dart';
import 'package:beautina_provider/core/global_values/responsive/global_val.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/services/api/db_orders.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GlobalValOrders extends GlobalValLoad {
  Rx<List<Order>> todayOrder = Rx([]);
  Rx<List<Order>> allOrders = Rx([]);
}
