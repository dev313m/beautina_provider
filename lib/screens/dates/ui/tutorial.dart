import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WdgtDateTutorialCalendar extends StatelessWidget {
  const WdgtDateTutorialCalendar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      child: Container(
        color: CalendarColors.container,
        height: ScreenUtil().setHeight(300),
        // width: ScreenUtil().setWidth(200),
        child: Stack(
          children: <Widget>[
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: IconButton(
            //     icon: Icon(
            //       CommunityMaterialIcons.calendar_question,
            //       size: ScreenUtil().setSp(60),
            //       color: Colors.white38,
            //     ),
            //     onPressed: () {},
            //   ),
            // ),

            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ExtendedText(
                        string: 'تعليمات:',
                        fontSize: ExtendedText.bigFont,
                      ),
                      ExtendedText(string: '- اضغط على اليوم لتظهر المواعيد بالاسفل'),
                      ExtendedText(string: '- الطلبات المقبولة يجب تأكيدها عند الظهور بالاعلى'),
                      ExtendedText(string: '- فضلا يرجى تأكيد الطلبات التامة عند الظهور بالأعلى'),
                      SizedBox(
                        height: 40.sp,
                      ),
                      Container(
                        // color: Colors.white60,
                        height: ScreenUtil().setWidth(115),
                        width: ScreenUtil().setWidth(400),
                        child: Stack(
                          children: <Widget>[
                            Align(
                                child: Container(
                              decoration: BoxDecoration(color: CalendarColors.eventColor, borderRadius: BorderRadius.circular(12)),
                              height: ScreenUtil().setWidth(90),
                              width: ScreenUtil().setWidth(90),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                                  child: ExtendedText(
                                    string: '24',
                                  ),
                                ),
                              ),
                            )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: ScreenUtil().setWidth(170),
                                height: ScreenUtil().setWidth(30),
                                child: Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                        color: CalendarColors.topNoti,
                                        width: ScreenUtil().setWidth(30),
                                        height: ScreenUtil().setWidth(30),
                                        child: Center(
                                            child: ExtendedText(
                                          string: '4',
                                        )),
                                      ),
                                    ),
                                    ExtendedText(
                                      string: 'طلبات قادمة مؤكدة',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: ScreenUtil().setWidth(170),
                                height: ScreenUtil().setWidth(30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Center(
                                      child: ExtendedText(
                                        string: 'طلبات جديدة',
                                      ),
                                    ),
                                    ClipOval(
                                      child: Container(
                                        color: CalendarColors.bottomLeft,
                                        width: ScreenUtil().setWidth(30),
                                        height: ScreenUtil().setWidth(30),
                                        child: Center(
                                          child: ExtendedText(
                                            string: '5',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: ScreenUtil().setWidth(170),
                                height: ScreenUtil().setWidth(30),
                                child: Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Container(
                                        color: CalendarColors.bottomRight,
                                        width: ScreenUtil().setWidth(30),
                                        height: ScreenUtil().setWidth(30),
                                        child: Center(
                                            child: ExtendedText(
                                          string: '2',
                                        )),
                                      ),
                                    ),
                                    ExtendedText(
                                      string: 'تحت انتظار تأكيد الزبون',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

            Align(
              alignment: Alignment.topLeft,
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Provider.of<VmDateData>(context).isShowAvailableWidget
                    ? WAvailablilityChanger(
                        changableAvailableDate: Provider.of<VmDateData>(context).calanderChosenDay,
                      )
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),

      // key: Key('uiniv'),
    );
  }
}
