import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WdgtSetttingsPersonalInfo extends StatefulWidget {
  WdgtSetttingsPersonalInfo({Key key}) : super(key: key);

  @override
  _WdgtSetttingsPersonalInfoState createState() => _WdgtSetttingsPersonalInfoState();
}

class _WdgtSetttingsPersonalInfoState extends State<WdgtSetttingsPersonalInfo> {
  ModelBeautyProvider beautyProvider;
  VMSettingsData vmSettingsData;
  @override
  Widget build(BuildContext context) {
    vmSettingsData = Provider.of<VMSettingsData>(context);
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;

    return Container(
      padding: EdgeInsets.all(allContainerPadding),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(allContainerRadius), color: allContainerBg),
      child: Form(
        key: vmSettingsData.formKey,
        autovalidate: vmSettingsData.autoValidate,
        child: Column(children: [
          Icon(CommunityMaterialIcons.account_edit, color: overviewIconColor, size: overviewIconSize),
          ExtendedText(string: personalData, fontSize: ExtendedText.xbigFont),
          SizedBox(height: btwIconxRest),
          new TextFormField(
            decoration: new InputDecoration(
                // hintText: 'الاسم',
                prefixText: nameHint,
                // prefixStyle: TextStyle(color: AppColors.blueOpcity),
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(fieldsRadius),
                  ),
                  // gapPadding: ScreenUtil().setWidth(20)
                ),
                suffix: Icon(CommunityMaterialIcons.face_profile),
                // labelText: 'الاسم',
                filled: true,
                hasFloatingPlaceholder: true,
                // helperText: beautyProvider.name,
                // hintStyle: new TextStyle(color: Colors.grey[800]),
                fillColor: fieldColor),
            keyboardType: TextInputType.text,
            validator: validateName,
            onSaved: (String val) {
              vmSettingsData.name = val;
            },
            initialValue: beautyProvider.name,
          ),
          SizedBox(height: btwAnyTwoInForm),
          TextFormField(
            initialValue: beautyProvider.username.substring(4, beautyProvider.username.length),
            decoration: new InputDecoration(
                suffixText: '966 ',
                // prefixStyle: TextStyle(color: AppColors.blueOpcity),
                hasFloatingPlaceholder: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(fieldsRadius),
                  ),
                  gapPadding: fieldGapPadding,
                ),
                prefixIcon: Icon(CommunityMaterialIcons.phone),
                filled: true,
                // labelText: '966',
                // hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: phoneHint,
                fillColor: fieldColor),
            // strutStyle: StrutStyle(/),
            keyboardType: TextInputType.phone,
            validator: validateMobile,
            onSaved: (String val) {
              vmSettingsData.mobile = Countries.phoneCodePlus[beautyProvider.country] + val;
            },
          ),
          SizedBox(height: btwAnyTwoInForm),
          new TextFormField(
            initialValue: beautyProvider.intro,
            minLines: 3,
            maxLines: 5,
            decoration: new InputDecoration(
                prefixText: descHint,
                prefixStyle: TextStyle(color: AppColors.blueOpcity),
                hasFloatingPlaceholder: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(fieldsRadius),
                  ),
                ),
                suffixIcon: Icon(CommunityMaterialIcons.information),
                filled: true,
                // hintStyle: new TextStyle(color: Colors.grey[800]),
                // hintText: "وصف للصالون مختصر",
                fillColor: fieldColor),
            keyboardType: TextInputType.text,
            validator: validateName,
            onSaved: (String val) {
              vmSettingsData.description = val;
            },
          ),
          new SizedBox(
            height: btwFormxUpdateBtn,
          ),
          RoundedLoadingButton(
            controller: vmSettingsData.controller,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: ExtendedText(
                      string: updateBtnStr,
                      fontSize: ExtendedText.bigFont,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () async {
              await updateBtn(context);
            },
            color: updateBtnColor,
            animateOnTap: false,
          )
        ]),
      ),
    );
  }
}

///[sizes]
var allContainerPadding = ScreenUtil().setWidth(30);
var overviewIconSize = ScreenUtil().setHeight(200);
var btwIconxRest = ScreenUtil().setHeight(40);
var btwAnyTwoInForm = ScreenUtil().setHeight(6);
var btwFormxUpdateBtn = 10.h;
var fieldGapPadding = 20.w;

///[Colors]
var allContainerBg = Colors.white24;
var overviewIconColor = AppColors.pinkBright;
var fieldColor = Colors.white70;
var updateBtnColor = Colors.blue;

///[borderradius]
double allContainerRadius = 12;

///[Borderrduis]
final double fieldsRadius = 12;

///[String]
final personalData = 'البيانات الشخصية';
final nameHint = 'الاسم: ';
final phoneHint = "رقم الجوال";
final descHint = 'وصف مختصر:';
final updateBtnStr = 'تحديث';
