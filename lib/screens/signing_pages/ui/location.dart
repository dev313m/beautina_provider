import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/utils/ui/chip.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class WdgtLoginLocation extends StatelessWidget {
  final GlobalKey globalKey;
  const WdgtLoginLocation({Key key, @required this.globalKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: BeautyTextfield(
            suffixIcon: Icon(
              CommunityMaterialIcons.home_city_outline,
              // size: ScreenUtil().setSp(40),
            ),
            helperText: 'المنطقة',
            readOnly: true,
            inputType: TextInputType.text,
            onTap: () {
              showPicker(context, globalKey);
            },
          ),
        ),
        isCityChosen(context)
            ? GWdgtChip(
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

///[sizes]
