import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/ui/coming_order_page.dart';
import 'package:beautina_provider/screens/dates/ui/finished_order_page.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/dates/ui_order_list_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_button/spring_button.dart';
import 'package:beautina_provider/reusables/text.dart';

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
              borderRadius: BorderRadius.circular(12),
              child: SpringButton(
                SpringButtonType.WithOpacity,
                Container(
                  height: ScreenUtil().setHeight(130),
                  child: Center(
                    child: Container(
                      // width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                          color: ConstDatesColors.topBtns,
                          borderRadius: BorderRadius.circular(12)),
                      height: ScreenUtil().setHeight(100),
                      child: Center(
                        child: ExtendedText(
                          string: 'طلبات منتهية',
                          fontSize: ExtendedText.bigFont,
                        ),
                      ),
                    ),
                  ),
                ),
                scaleCoefficient: 0.85,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => OrderListFinishedPage(heroTag: 'bbb')));
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
              SpringButton(
                SpringButtonType.WithOpacity,
                Container(
                  height: ScreenUtil().setHeight(130),
                  child: Center(
                    child: Hero(
                      tag: 'newOrders',
                      child: Container(
                        decoration: BoxDecoration(
                            color: ConstDatesColors.topBtns,
                            borderRadius: BorderRadius.circular(12)),
                        height: ScreenUtil().setHeight(100),
                        child: Center(
                          child: ExtendedText(
                            string: 'طلبات مؤكدة قادمة',
                            fontSize: ExtendedText.bigFont,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                scaleCoefficient: 0.85,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => OrderListPage()));
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: ClipOval(
                  child: Container(
                      width: ScreenUtil().setWidth(30),
                      height: ScreenUtil().setHeight(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red),
                      child: Center(
                        child: ExtendedText(
                          string: Provider.of<VmDateData>(context)
                              .comingConfirmedList
                              .length
                              .toString(),
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
