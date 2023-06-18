import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/utils/ui/space.dart';

///[strings]
final strDetails = 'تفاصيل';

///[sizes]
double sizePageTitle = heightTopBar;

///[radius]
double radiusPageTitle = radiusDefault;

///[color]
final Color colorPageTitle = ConstDatesColors.littleList.withAlpha(200);
final Color colorBackground = AppColors.purpleColor;

class WdgtDatePageSingleOrderDetail extends StatefulWidget {
  final String? orderId;
  final String? heroTag;
  WdgtDatePageSingleOrderDetail({Key? key, this.heroTag, this.orderId})
      : super(key: key);

  @override
  _PageOrderDetailState createState() => _PageOrderDetailState();
}

class _PageOrderDetailState extends State<WdgtDatePageSingleOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VmDateDataTest>(builder: (
      vm,
    ) {
      final orderId = vm.orderList!
          .where((element) => element.doc_id == widget.orderId)
          .first
          .doc_id!;
      return Scaffold(
        primary: false,
        // resizeToAvoidBottomPadding: false,
        backgroundColor: colorBackground,
        body: SingleChildScrollView(
          child: Column(
            // addRepaintBoundaries: false,

            children: <Widget>[
              Hero(
                tag: orderId + 'ok',
                transitionOnUserGestures: true,
                child: Container(
                  width: double.infinity,
                  height: sizePageTitle,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusPageTitle),
                    color: colorPageTitle,
                  ),
                  child: Center(
                      child: AnimatedSwitcher(
                          // key: ValueKey('any'),
                          duration: Duration(milliseconds: durationCalender),
                          child: GWdgtTextTitle(
                            string: strDetails,
                          ))),
                ),
              ),
              Y(),
              WdgtDateOrderDetails(orderId: orderId)
            ],
          ),
        ),
      );
    });
  }
}
