import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';

///[strings]
final strDetails = 'تفاصيل';

///[sizes]
double sizePageTitle = ScreenUtil().setHeight(170);

///[radius]
double radiusPageTitle = 12;

///[color]
final Color colorPageTitle = Colors.white38;
final Color colorBackground = AppColors.purpleColor;

class WdgtDatePageSingleOrderDetail extends StatefulWidget {
  final String orderId;
  final String heroTag;
  WdgtDatePageSingleOrderDetail({Key key, this.heroTag, this.orderId}) : super(key: key);

  @override
  _PageOrderDetailState createState() => _PageOrderDetailState();
}

class _PageOrderDetailState extends State<WdgtDatePageSingleOrderDetail> {
  Order order;
  @override
  Widget build(BuildContext context) {
    order = Provider.of<VmDateData>(context).orderList.where((element) => element.doc_id == widget.orderId).first;
    return Scaffold(
      primary: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: colorBackground,
      body: SingleChildScrollView(
        child: Column(
          // addRepaintBoundaries: false,

          children: <Widget>[
            Hero(
              tag: order.doc_id + 'ok',
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
            WdgtDateOrderDetails(order: order)
          ],
        ),
      ),
    );
  }
}
