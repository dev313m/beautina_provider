import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
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
                            duration: Duration(milliseconds: 500),
                            child: getTitleWidget(context, vmRootUi.pageIndex),
                          ),
                        ),
                      ),
                    ),
                  )));
  }

  getTitleWidget(BuildContext context, pageIndex) {
    if (pageIndex == 3)
      return GWdgtTextTitle(
        key: ValueKey('value0'),
        string: '~ الصالون ~',
      );
    else if (pageIndex == 2)
      return GWdgtTextTitle(
        key: ValueKey('value1'),
        string: '~ المواعيد ~',
      );
    else if (pageIndex == 1)
      return GWdgtTextTitle(
        key: ValueKey('value2'),
        string: '~ الاشعارات ~',
      );
    else
      return GWdgtTextTitle(
        key: ValueKey('value3'),
        string: '~ الاعدادات ~',
      );
  }
}

double radius = radiusDefault;
