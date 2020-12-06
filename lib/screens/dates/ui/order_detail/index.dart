import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_new.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_canceled.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_confirmed.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_only_details.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_outdated.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/order_waiting_customer.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WdgtDateOrderDetails extends StatefulWidget {
  final String orderId;
  const WdgtDateOrderDetails({Key key, this.orderId}) : super(key: key);

  @override
  _WdgtDateOrderDetailsState createState() => _WdgtDateOrderDetailsState();
}

class _WdgtDateOrderDetailsState extends State<WdgtDateOrderDetails> {
  Order order;

  @override
  Widget build(BuildContext context) {
    order = Provider.of<VmDateData>(context)
        .orderList
        .where((element) => element.doc_id == widget.orderId)
        .first;

    if (order.status == 0) //new order
      return WidgetNewOrder(order: order);
    else if (order.status == 1) // order approved by provider
      return WidgetWaitingCustomer(order: order);
    else if (order.status == 2 ||
        order.status == 4) //order is canceled by customer or provider
      return WidgetCanceledOrder(order: order);
    else if (order.status == 3) // order is confirmed by costomer
    {
      if (order.client_order_date.month == DateTime.now().month &&
          DateTime.now().day == order.client_order_date.day)

        ///When order is submitted by user but outdated
        return WidgetOutdatedOrder(
          order: order,
        );
      return WidgetConfirmedByCustomerOrder(order: order);
    }

    /// [status = 8]: finished successfully,
    /// [status = 7]: finished unsuccessfully,
    /// [status = 6]: is in evaluation status,
    /// [status = 5]: user claim finished complete
    else if (order.status == 5 ||
        order.status == 6 ||
        order.status == 7 ||
        order.status == 8) return WidgetOnlyDetailsOrder(order: order);
    return SizedBox();
  }
}
