import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/ui/coming_order_page.dart';
import 'package:beautina_provider/screens/dates/ui/finished_order_page.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring_button/spring_button.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

///[radiuss]
double radiusBotton = radiusDefault;

///[Sizes]
double sizeContainerBtn = ScreenUtil().setHeight(130);
double sizeBtnHeight = 100.h;
double sizeBadge = ScreenUtil().setWidth(radiusDefault);

///[String]
final strOrderFinished = 'طلبات منتهية';
final strOrderComing = 'طلبات مؤكدة قادمة';

///[colors]
Color colorButton = ConstDatesColors.topBtns;
Color colorBadge = Colors.red;

class WdgtDateTopButtons extends StatefulWidget {
  WdgtDateTopButtons({Key key}) : super(key: key);

  @override
  _WdgtDateTopButtonsState createState() => _WdgtDateTopButtonsState();
}

class _WdgtDateTopButtonsState extends State<WdgtDateTopButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Hero(
            tag: 'bbb',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusBotton),
              child: SpringButton(
                SpringButtonType.WithOpacity,
                Container(
                  height: sizeContainerBtn,
                  child: Center(
                    child: Container(
                      // width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(color: colorButton, borderRadius: BorderRadius.circular(radiusBotton)),
                      // height: sizeBtnHeight,
                      child: Center(
                        child: GWdgtTextButton(
                          string: strOrderFinished,
                          // fontSize: ExtendedText.bigFont,
                        ),
                      ),
                    ),
                  ),
                ),
                scaleCoefficient: 0.85,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderListFinishedPage(heroTag: 'bbb')));
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(9),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusBotton),
                child: SpringButton(
                  SpringButtonType.WithOpacity,
                  Container(
                    height: sizeContainerBtn,
                    child: Center(
                      child: Hero(
                        tag: 'newOrders',
                        child: Container(
                          decoration: BoxDecoration(color: colorButton, borderRadius: BorderRadius.circular(radiusBotton)),
                          // height: sizeBtnHeight,
                          child: Center(
                            child: GWdgtTextButton(
                              string: strOrderComing,
                              // fontSize: ExtendedText.bigFont,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  scaleCoefficient: 0.85,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderListPage()));
                  },
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ClipOval(
                  child: Container(
                      width: sizeBadge,
                      height: sizeBadge,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorBadge),
                      child: Center(
                        child: ExtendedText(
                          string: Get.find<VmDateDataTest>().comingConfirmedList.length.toString(),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
