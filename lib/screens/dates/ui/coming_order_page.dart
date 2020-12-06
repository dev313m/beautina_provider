import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/index.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[string]
final strComingOrders = 'طلبات مؤكدة قادمة';

///[size]
double sizePageTitle = 170.h;

///[radius]
double radius = 12;

///[color]

final Color colorBackground = AppColors.purpleColor;
final Color colorTitleContainer = ConstDatesColors.topBtns;

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
      body: SingleChildScrollView(
        child: Column(
          // addRepaintBoundaries: false,

          children: <Widget>[
            Hero(
              tag: 'newOrders',
              transitionOnUserGestures: true,
              child: Container(
                width: double.infinity,
                height: sizePageTitle,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: colorTitleContainer,
                ),
                child: Center(
                    child: AnimatedSwitcher(
                  // key: ValueKey('any'),
                  duration: Duration(milliseconds: 500),
                  child: GWdgtTextTitle(
                    string: strComingOrders,
                  ),
                )),
              ),
            ),
            ListView.builder(
              itemCount: vmDateData.comingConfirmedList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return WdgtDateOrderDetails(
                  order: vmDateData.orderList.where((item) => item.status == 3).toList()[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
