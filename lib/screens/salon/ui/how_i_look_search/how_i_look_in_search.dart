import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/salon/ui/how_i_look_search/ui_how_I_look.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

class WdgtSalonHowLookSearch extends StatelessWidget {
  const WdgtSalonHowLookSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        child: Material(
          color: Colors.white38,
          child: Ink(
            width: double.infinity,
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    size: ScreenUtil().setSp(900.sp),
                    color: AppColors.purpleColor,
                  ),
                  Expanded(
                    child: Center(
                        child: GWdgtTextTitle(
                      string: 'كيف تظهر صفحتي في البحث',
                      // fontSize: ExtendedText.bigFont,
                    )),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PageHowILookSearch()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

final radius = radiusDefault;
