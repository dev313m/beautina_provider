import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WdgtDatePageSingleOrderDetail extends StatefulWidget {
  final Order order;
  final String heroTag;
  WdgtDatePageSingleOrderDetail({Key key, this.heroTag, this.order}) : super(key: key);

  @override
  _PageOrderDetailState createState() => _PageOrderDetailState();
}

class _PageOrderDetailState extends State<WdgtDatePageSingleOrderDetail> {
  VmDateData vmDateData;
  @override
  Widget build(BuildContext context) {
    vmDateData = Provider.of<VmDateData>(context);
    return Scaffold(
      primary: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.purpleColor,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              // addRepaintBoundaries: false,

              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(220),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: AppColors.blueOpcity.withOpacity(0.9)
                  ),
                  child: Center(
                      child: AnimatedSwitcher(
                    // key: ValueKey('any'),
                    duration: Duration(milliseconds: durationCalender),
                  )),
                ),
                WdgtDateOrderDetails(order: vmDateData.orderList.firstWhere((item) => item.doc_id == widget.order.doc_id))
              ],
            ),
          ),
          Hero(
            tag: widget.order.doc_id + 'ok',
            transitionOnUserGestures: true,
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(170),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white38,
              ),
              child: Center(
                  child: AnimatedSwitcher(
                // key: ValueKey('any'),
                duration: Duration(milliseconds: durationCalender),
                child: ExtendedText(
                  string: 'تفاصيل',
                  fontSize: ExtendedText.xbigFont,
                ),
              )),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     color: Colors.transparent,
          //     height: ScreenUtil().setHeight(ConstRootSizes.navigation),
          //     width: ScreenResolution.width,
          //   ),
          // ),
        ],
      ),
    );
  }
}
