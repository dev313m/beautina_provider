import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/utils/current.dart';

class WdgtRootTopBar extends StatefulWidget {
  WdgtRootTopBar({Key key}) : super(key: key);

  @override
  _WdgtRootTopBarState createState() => _WdgtRootTopBarState();
}

class _WdgtRootTopBarState extends State<WdgtRootTopBar> {
  @override
  Widget build(BuildContext context) {
    VMRootUi vmRootUi = Provider.of<VMRootUi>(context);
    return Align(
        alignment: Alignment.topCenter,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Provider.of<VMRootUi>(context).hideBars
                ? SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: heightTopBar,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            color: AppColors.blueOpcity.withOpacity(0.9)),
                        child: Center(
                            child: AnimatedSwitcher(
                          // key: ValueKey('any'),
                          duration: Duration(milliseconds: 500),
                          child: getTitleWidget(context, vmRootUi.pageIndex),
                        )),
                      ),
                    ),
                  )));
  }

  getTitleWidget(BuildContext context, pageIndex) {
    if (pageIndex == 3)
      return ExtendedText(
        key: ValueKey('value0'),
        string: '~ الصالون ~',
        fontSize: ExtendedText.xbigFont,
      );
    else if (pageIndex == 2)
      return ExtendedText(
        key: ValueKey('value1'),
        string: '~ المواعيد ~',
        fontSize: ExtendedText.xbigFont,
      );
    else if (pageIndex == 1)
      return ExtendedText(key: ValueKey('value2'), string: '~ الاشعارات ~', fontSize: ExtendedText.xbigFont);
    else
      return ExtendedText(key: ValueKey('value3'), string: '~ الاعدادات ~', fontSize: ExtendedText.xbigFont);
  }
}

double radius = radiusDefault;
