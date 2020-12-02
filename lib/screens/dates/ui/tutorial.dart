import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/ui/on_off_availability.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/dates/ui/order_detail/common_order_ui/ui.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare.dart';

///[strings]
final strInstruction = 'تعليمات:';
final strInstDesc =
    ''' - الطلبات المقبولة يجب تأكيدها عند الظهور بالاعلى\n - الطلبات المقبولة يجب تأكيدها عند الظهور بالاعلى\n    - فضلا يرجى تأكيد الطلبات التامة عند الظهور بالأعلى''';
final strOrdersConfirmed = 'طلبات قادمة مؤكدة';
final strOrdersWaiting = 'تحت انتظار تأكيد الزبون';
final strOrdersNew = 'طلبات جديدة';

///[colors]
Color colorContainer = CalendarColors.container;
Color colorEvent = CalendarColors.eventColor;
Color colorTopNoti = CalendarColors.topNoti;
Color colorBottomLeftNoti = CalendarColors.bottomLeft;
Color colorBottomRightNoti = CalendarColors.bottomRight;

///[radius]
const double radiusDay = 12;

/// [$sizes]
double sizeContainer = 300.h;

double sizeHInstructionDay = ScreenUtil().setWidth(115);
double sizeWInstructionDay = ScreenUtil().setWidth(400);
double sizeDay = 90.w;
double sizeInsideDayInstrH = 170.w;
double sizeInsideDayInstrW = 30.w;
double sizePaddingDayInst = 30.w;

///[edge padding]
double edgeContainer = ScreenUtil().setWidth(10);

///[heights]
double heightInstruction = 40.sp;

class WdgtDateTutorialCalendar extends StatelessWidget {
  const WdgtDateTutorialCalendar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorContainer,
      height: sizeContainer,
      // width: ScreenUtil().setWidth(200),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(edgeContainer),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ExtendedText(
                      string: strInstruction,
                      fontSize: ExtendedText.bigFont,
                    ),
                    ExtendedText(string: strInstDesc),
                    SizedBox(
                      height: heightInstruction,
                    ),
                    Container(
                      // color: Colors.white60,
                      height: sizeHInstructionDay,
                      width: sizeWInstructionDay,
                      child: Stack(
                        children: <Widget>[
                          Align(
                              child: Container(
                            decoration: BoxDecoration(
                                color: colorEvent,
                                borderRadius: BorderRadius.circular(radiusDay)),
                            height: sizeDay,
                            width: sizeDay,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(8)),
                                child: ExtendedText(
                                  string: '24',
                                ),
                              ),
                            ),
                          )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: sizeInsideDayInstrH,
                              height: sizeInsideDayInstrW,
                              child: Row(
                                children: <Widget>[
                                  ClipOval(
                                    child: Container(
                                      color: colorTopNoti,
                                      width: sizePaddingDayInst,
                                      height: sizePaddingDayInst,
                                      child: Center(
                                          child: ExtendedText(
                                        string: '4',
                                      )),
                                    ),
                                  ),
                                  ExtendedText(
                                    string: strOrdersConfirmed,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: sizeInsideDayInstrH,
                              height: sizeInsideDayInstrW,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Center(
                                    child: ExtendedText(
                                      string: strOrdersNew,
                                    ),
                                  ),
                                  ClipOval(
                                    child: Container(
                                      color: colorBottomLeftNoti,
                                      width: sizePaddingDayInst,
                                      height: sizePaddingDayInst,
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
                              width: sizeInsideDayInstrH,
                              height: sizeInsideDayInstrW,
                              child: Row(
                                children: <Widget>[
                                  ClipOval(
                                    child: Container(
                                      color: colorBottomRightNoti,
                                      width: sizePaddingDayInst,
                                      height: sizePaddingDayInst,
                                      child: Center(
                                          child: ExtendedText(
                                        string: '2',
                                      )),
                                    ),
                                  ),
                                  ExtendedText(
                                    string: strOrdersWaiting,
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
                      changableAvailableDate:
                          Provider.of<VmDateData>(context).calanderChosenDay,
                    )
                  : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
