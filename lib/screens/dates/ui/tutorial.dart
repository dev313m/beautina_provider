import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/constants.dart';
import 'package:beautina_provider/screens/dates/ui/on_off_availability.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/text.dart';

///[strings]
final strInstruction = 'شرح، مثال:';
final strInstDesc =
    ''' - الطلبات المقبولة يجب تأكيدها عند الظهور بالاعلى\n - الطلبات المقبولة يجب تأكيدها عند الظهور بالاعلى\n    - فضلا يرجى تأكيد الطلبات التامة عند الظهور بالأعلى''';
final strOrdersConfirmed = 'طلبات مؤكدة';
final strOrdersWaiting = 'بإنتظار تأكيد الزبون';
final strOrdersNew = 'طلبات جديدة';

///[colors]
Color colorContainer = CalendarColors.container;
Color colorEvent = CalendarColors.eventColor;
Color colorTopNoti = CalendarColors.topNoti;
Color colorBottomLeftNoti = CalendarColors.bottomLeft;
Color colorBottomRightNoti = CalendarColors.bottomRight;

///[radius]
const double radiusDay = 12;
double radius = radiusDefault;

/// [$sizes]
double sizeContainer = 400.h;

double sizeHInstructionDay = ScreenUtil().setWidth(115);
double sizeWInstructionDay = ScreenUtil().setWidth(500);
double sizeDay = 100.w;
double sizeInsideDayInstrH = 220.w;
double sizeInsideDayInstrW = 30.w;
double sizePaddingDayInst = 30.w;

///[edge padding]
// double edgeContainer = ScreenUtil().setWidth(10);
double edge24Padding = ScreenUtil().setHeight(8);

///[heights]
double heightInstruction = 40.sp;

class WdgtDateTutorialCalendar extends StatelessWidget {
  const WdgtDateTutorialCalendar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius)),
      child: Container(
        color: colorContainer,
        height: sizeContainer,
        // width: ScreenUtil().setWidth(200),
        child: Stack(
          children: <Widget>[
            Positioned(
                left: 500.w,
                // alignment: Alignment(100.w, 100.w),
                child: Padding(
                  padding: EdgeInsets.all(edgeContainer),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GWdgtTextSmall(
                        string: strInstruction,
                        // fontSize: ExtendedText.bigFont,
                      ),
                      // GWdgtTextSmall(string: strInstDesc,color: Colors.white54,),
                      SizedBox(
                        height: heightInstruction,
                      ),
                      Container(
                        // color: Colors.white60,
                        
                        height: sizeHInstructionDay + 50.h,
                        width: sizeWInstructionDay + 50.h,
                        child: Stack(
                          children: <Widget>[
                            Align(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: colorEvent,
                                  borderRadius:
                                      BorderRadius.circular(radiusDay)),
                              height: sizeDay + 50.h,
                              width: sizeDay + 50.h,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(edge24Padding),
                                  child: GWdgtTextBadge(
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
                                            child: GWdgtTextBadge(
                                          string: '4',
                                        )),
                                      ),
                                    ),
                                    GWdgtTextSmall(
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
                                      child: GWdgtTextSmall(
                                        string: strOrdersNew,
                                      ),
                                    ),
                                    ClipOval(
                                      child: Container(
                                        color: colorBottomLeftNoti,
                                        width: sizePaddingDayInst,
                                        height: sizePaddingDayInst,
                                        child: Center(
                                          child: GWdgtTextBadge(
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
                                            child: GWdgtTextBadge(
                                          string: '2',
                                        )),
                                      ),
                                    ),
                                    GWdgtTextSmall(
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
      ),
    );
  }
}
