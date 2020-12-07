import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/screens/signing_pages/ui.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtLoginLocation extends StatelessWidget {
  final GlobalKey globalKey;
  const WdgtLoginLocation({Key key, @required this.globalKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextHolder(
          backgroundColor: ConstLoginColors.regionColor,
          borderColor: ConstLoginColors.regionColor,
          borderRadius: BorderRadius.circular(12),
          function: () {
            showPicker(context, globalKey);
          },
          edgeInsetsGeometry: EdgeInsets.symmetric(horizontal: 22),
          height: ScreenUtil().setHeight(ConstLoginSizes.regionHeight),
          iconWidget: Icon(
            CommunityMaterialIcons.home_city_outline,
            size: ScreenUtil().setSp(40),
            color: ExtendedText.brightColor,
          ),
          textWidget: ExtendedText(
            string: 'المنطقة',
            fontSize: ExtendedText.bigFont,
          ),
          width: ScreenUtil().setWidth(688),
        ),
        isCityChosen(context)
            ? CityWidget(
                color: ConstLoginColors.city,
                function: () {
                  showPicker(context, globalKey);
                },
              )
            : SizedBox()
      ],
    );
  }
}
