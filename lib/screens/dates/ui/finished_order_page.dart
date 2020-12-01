import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderListFinishedPage extends StatefulWidget {
  final String heroTag;
  OrderListFinishedPage({Key key, this.heroTag}) : super(key: key);

  @override
  _OrderListFinishedState createState() => _OrderListFinishedState();
}

class _OrderListFinishedState extends State<OrderListFinishedPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VmDateData>(builder: (_, VmDateData, child) {
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
                    itemCount:
                        VmDateData.orderList.where((item) => item.status != 0 && item.status != 1 && item.status != 3).toList().length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return WdgtDateOrderDetails(
                        order:
                            VmDateData.orderList.where((item) => item.status != 0 && item.status != 1 && item.status != 3).toList()[index],
                      );
                    },
                  ),
                ],
              ),
            ),
            Hero(
              tag: 'bbb',
              transitionOnUserGestures: true,
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(170),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.pinkBright,
                ),
                child: Center(
                    child: AnimatedSwitcher(
                  // key: ValueKey('any'),
                  duration: Duration(milliseconds: 500),
                  child: ExtendedText(
                    string: 'طلبات منتهية',
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
    });
  }
}
