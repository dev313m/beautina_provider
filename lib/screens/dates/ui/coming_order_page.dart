import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/ui.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  // final List<Order> orderList;
  OrderListPage({
    Key key,
  }) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
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
                    duration: Duration(milliseconds: 500),
                  )),
                ),
                ListView.builder(
                  itemCount: vmDateData.comingConfirmedList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return WdgtDateOrderDetails(
                      order: vmDateData.orderList
                          .where((item) => item.status == 3)
                          .toList()[index],
                    );
                  },
                ),
              ],
            ),
          ),
          Hero(
            tag: 'newOrders',
            transitionOnUserGestures: true,
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(170),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ConstDatesColors.topBtns,
              ),
              child: Center(
                  child: AnimatedSwitcher(
                // key: ValueKey('any'),
                duration: Duration(milliseconds: 500),
                child: ExtendedText(
                  string: 'طلبات مؤكدة قادمة',
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
