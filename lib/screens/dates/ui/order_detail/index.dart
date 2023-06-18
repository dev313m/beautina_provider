import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_new.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_canceled.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_confirmed.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_only_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_outdated.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_waiting_customer.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WdgtDateOrderDetails extends StatefulWidget {
  final String? orderId;
  const WdgtDateOrderDetails({Key? key, this.orderId}) : super(key: key);

  @override
  _WdgtDateOrderDetailsState createState() => _WdgtDateOrderDetailsState();
}

class _WdgtDateOrderDetailsState extends State<WdgtDateOrderDetails> {
  Order? order;

  @override
  Widget build(BuildContext context) {
    order = Get.find<VmDateDataTest>()
        .orderList!
        .where((element) => element.doc_id == widget.orderId)
        .first;

    if (order!.status!.index == 0) //new order
      return WidgetNewOrder(order: order);
    else if (order!.status!.index == 1) // order approved by provider
      return WidgetWaitingCustomer(order: order);
    else if (order!.status!.index == 2 ||
        order!.status!.index == 4) //order is canceled by customer or provider
      return WidgetCanceledOrder(order: order);
    else if (order!.status!.index == 3) // order is confirmed by costomer
    {
      if (DateTime.now().toLocal().isAfter(order!.client_order_date!.toLocal()))

        ///When order is submitted by user but outdated
        return WidgetOutdatedOrder(
          order: order,
        );
      return WidgetConfirmedByCustomerOrder(order: order);
    }

    /// [status!.index = 5]: finished successfully,
    /// [status!.index = 7]: finished unsuccessfully,
    /// [status!.index = 6]: is in evaluation status!.index,
    /// [status!.index = 8]: user claim finished complete
    else if (order!.status!.index == 5 ||
        order!.status!.index == 6 ||
        order!.status!.index == 7 ||
        order!.status!.index == 8) return WidgetOnlyDetailsOrder(order: order);
    return SizedBox();
  }
}
