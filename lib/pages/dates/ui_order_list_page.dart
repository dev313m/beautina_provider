import 'dart:ui';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/pages/dates/constants.dart';
import 'package:beautina_provider/pages/dates/functions.dart';
import 'package:beautina_provider/pages/dates/paint.dart';
import 'package:beautina_provider/pages/dates/shared_variables_order.dart';
import 'package:beautina_provider/pages/dates/ui.dart';
import 'package:beautina_provider/pages/root/constants.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<SharedOrder>(builder: (_, sharedOrder, child) {
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
                      borderRadius: BorderRadius.circular(25),
                      // color: AppColors.blueOpcity.withOpacity(0.9)
                    ),
                    child: Center(
                        child: AnimatedSwitcher(
                      // key: ValueKey('any'),
                      duration: Duration(milliseconds: durationCalender),
                    )),
                  ),
                  // CustomPaint(
                  //   willChange: false,
                  //   isComplex: true,
                  //   // willChange: false,
                  //   // isComplex: false,
                  //   size: Size(ScreenUtil().setWidth(650),
                  //       ScreenUtil().setHeight(130)),
                  //   painter: MyPainter(step: getStep(0)),
                  // ),
                  ListView.builder(
                    itemCount: sharedOrder.comingConfirmedList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return JustOrderWidget(
                        order:
                            sharedOrder.orderList.where((item) => item.status == 3).toList()[index],
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
                  borderRadius: BorderRadius.circular(25),
                  color: ConstDatesColors.topBtns,
                ),
                child: Center(
                    child: AnimatedSwitcher(
                  // key: ValueKey('any'),
                  duration: Duration(milliseconds: durationCalender),
                  child: ExtendedText(
                    string: 'طلبات مؤكدة قادمة',
                    fontSize: ExtendedText.xbigFont,
                  ),
                )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.overlay,
                child: Container(
                  color: Colors.transparent,
                  height: ScreenUtil().setHeight(ConstRootSizes.navigation),
                  width: ScreenResolution.width,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class OrderListFinishedPage extends StatefulWidget {
  final String heroTag;
  OrderListFinishedPage({Key key, this.heroTag}) : super(key: key);

  @override
  _OrderListFinishedState createState() => _OrderListFinishedState();
}

class _OrderListFinishedState extends State<OrderListFinishedPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SharedOrder>(builder: (_, sharedOrder, child) {
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
                      borderRadius: BorderRadius.circular(25),
                      // color: AppColors.blueOpcity.withOpacity(0.9)
                    ),
                    child: Center(
                        child: AnimatedSwitcher(
                      // key: ValueKey('any'),
                      duration: Duration(milliseconds: durationCalender),
                    )),
                  ),
                  ListView.builder(
                    itemCount: sharedOrder.orderList
                        .where((item) => item.status != 0 && item.status != 1 && item.status != 3)
                        .toList()
                        .length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return JustOrderWidget(
                        order: sharedOrder.orderList
                            .where(
                                (item) => item.status != 0 && item.status != 1 && item.status != 3)
                            .toList()[index],
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
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.pinkBright,
                ),
                child: Center(
                    child: AnimatedSwitcher(
                  // key: ValueKey('any'),
                  duration: Duration(milliseconds: durationCalender),
                  child: ExtendedText(
                    string: 'طلبات منتهية',
                    fontSize: ExtendedText.xbigFont,
                  ),
                )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.overlay,
                child: Container(
                  color: Colors.transparent,
                  height: ScreenUtil().setHeight(ConstRootSizes.navigation),
                  width: ScreenResolution.width,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PageOrderDetail extends StatefulWidget {
  final Order order;
  final String heroTag;
  PageOrderDetail({Key key, this.heroTag, this.order}) : super(key: key);

  @override
  _PageOrderDetailState createState() => _PageOrderDetailState();
}

class _PageOrderDetailState extends State<PageOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SharedOrder>(builder: (_, sharedOrder, child) {
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
                      borderRadius: BorderRadius.circular(25),
                      // color: AppColors.blueOpcity.withOpacity(0.9)
                    ),
                    child: Center(
                        child: AnimatedSwitcher(
                      // key: ValueKey('any'),
                      duration: Duration(milliseconds: durationCalender),
                    )),
                  ),
                  JustOrderWidget(
                      order: sharedOrder.orderList
                          .firstWhere((item) => item.doc_id == widget.order.doc_id))
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
                  borderRadius: BorderRadius.circular(25),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.overlay,
                child: Container(
                  color: Colors.transparent,
                  height: ScreenUtil().setHeight(ConstRootSizes.navigation),
                  width: ScreenResolution.width,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
