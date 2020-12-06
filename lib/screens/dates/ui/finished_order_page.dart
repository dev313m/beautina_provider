import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[string]
final strFinishedOrders = 'طلبات منتهية';

///[size]

double sizePageTitle = 170.h;

///[radius]
double radius = 12;

///[color]

final Color colorBackground = AppColors.purpleColor;

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
        backgroundColor: colorBackground,
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                // addRepaintBoundaries: false,

                children: <Widget>[
                  Hero(
                    tag: 'bbb',
                    transitionOnUserGestures: true,
                    child: Container(
                      width: double.infinity,
                      height: sizePageTitle,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        color: AppColors.pinkBright,
                      ),
                      child: Center(
                          child: AnimatedSwitcher(
                        // key: ValueKey('any'),
                        duration: Duration(milliseconds: 500),
                        child: GWdgtTextTitle(
                          string: strFinishedOrders,
                        ),
                      )),
                    ),
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
