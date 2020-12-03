import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///[strings]
final strDetails = 'تفاصيل';

///[sizes]
double sizePageTitle = ScreenUtil().setHeight(170);

///[radius]
double radiusPageTitle = 12;

///[color]
final Color colorPageTitle = Colors.white38;

class WdgtDatePageSingleOrderDetail extends StatefulWidget {
  final Order order;
  final String heroTag;
  WdgtDatePageSingleOrderDetail({Key key, this.heroTag, this.order})
      : super(key: key);

  @override
  _PageOrderDetailState createState() => _PageOrderDetailState();
}

class _PageOrderDetailState extends State<WdgtDatePageSingleOrderDetail> {
  // VmDateData vmDateData;
  @override
  Widget build(BuildContext context) {
    // vmDateData = Provider.of<VmDateData>(context);
    return Scaffold(
      primary: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.purpleColor,
      body: SingleChildScrollView(
        child: Column(
          // addRepaintBoundaries: false,

          children: <Widget>[
            Hero(
              tag: widget.order.doc_id + 'ok',
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
            WdgtDateOrderDetails(order: widget.order)
          ],
        ),
      ),
    );
  }
}
