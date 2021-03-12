import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/screens/root/functions.dart';

class WdgtSetttingsPersonalInfo extends StatefulWidget {
  WdgtSetttingsPersonalInfo({Key key}) : super(key: key);

  @override
  _WdgtSetttingsPersonalInfoState createState() =>
      _WdgtSetttingsPersonalInfoState();
}

class _WdgtSetttingsPersonalInfoState extends State<WdgtSetttingsPersonalInfo> {

  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(allContainerPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(allContainerRadius),
          color: allContainerBg),
      child: GetBuilder<VMSettingsDataTest>(builder: (vmSettingsData) {
        return Form(
          key: vmSettingsData.formKey,
          autovalidate: vmSettingsData.autoValidate,
          child: Column(children: [
            Icon(CommunityMaterialIcons.account_edit,
                color: overviewIconColor, size: overviewIconSize),
            GWdgtTextTitle(
              string: personalData,
            ),
            Y(),
            GetBuilder<VMSalonDataTest>(
              builder: (vMSalonData) {
                
                return new BeautyTextfield(
                  helperText: nameHint,
                  placeholder: vMSalonData.beautyProvider.name,
                  inputType: TextInputType.text,
                  // height: 33,
                  onChanged: (val) {
                    vmSettingsData.name = val;
                  },
                  suffixIcon: Icon(CommunityMaterialIcons.face_profile),
                );
              }
            ),
            SizedBox(height: btwAnyTwoInForm),
            GetBuilder<VMSalonDataTest>(
              builder: (vMSalonData) {
                
                return BeautyTextfield(
                  inputType: TextInputType.phone,
                  maxLength: 9,
                  helperText: '966',
                  placeholder: vMSalonData.beautyProvider.phone
                      .substring(4,vMSalonData. beautyProvider.phone.length),

                  prefixIcon: Icon(Icons.phone),
                  onChanged: (val) {
                    vmSettingsData.mobile =
                        Countries.phoneCodePlus[vMSalonData.beautyProvider.country] +
                            convertArabicToEnglish(val);
                  },
                  // initialValue: beautyProvider.phone.substring(4, beautyProvider.phone.length),
                  // decoration: new InputDecoration(
                  //     suffixText: '966 ',

                  //     // prefixStyle: TextStyle(color: AppColors.blueOpcity),
                  //     hasFloatingPlaceholder: true,
                  //     border: new OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(fieldsRadius),
                  //       ),
                  //       gapPadding: fieldGapPadding,
                  //     ),
                  //     prefixIcon: Icon(CommunityMaterialIcons.phone),
                  //     filled: true,
                  //     // labelText: '966',
                  //     // hintStyle: new TextStyle(color: Colors.grey[800]),
                  //     hintText: phoneHint,
                  //     fillColor: fieldColor),
                  // // strutStyle: StrutStyle(/),
                  // keyboardType: TextInputType.phone,
                  // validator: validateMobile,
                  // onSaved: (String val) {
                  //   vmSettingsData.mobile = Countries.phoneCodePlus[beautyProvider.country] + val;
                  // },
                );
              }
            ),
            Y(),
            GetBuilder<VMSalonDataTest>(
              builder: (vMSalonData) {
                return
                  BeautyTextfield(
                  // initialValue: beautyProvider.intro,
                  placeholder:vMSalonData. beautyProvider.intro,
                  // helperText: descHint,
                  isBox: true,
                  inputType: TextInputType.text,
                  helperText: descHint,

                  // decoration: new InputDecoration(
                  //     prefixText: descHint,
                  //     prefixStyle: TextStyle(color: AppColors.blueOpcity),
                  //     hasFloatingPlaceholder: true,
                  //     border: new OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(fieldsRadius),
                  //       ),
                  //     ),
                  //     suffixIcon: Icon(CommunityMaterialIcons.information),
                  //     filled: true,
                  //     // hintStyle: new TextStyle(color: Colors.grey[800]),
                  //     // hintText: "وصف للصالون مختصر",
                  //     fillColor: fieldColor),
                  // keyboardType: TextInputType.text,
                  // validator: validateName,
                  onChanged: (String val) {
                    vmSettingsData.description = val;
                  },
                );
              }
            ),
            Y(),
            RoundedLoadingButton(
              controller: buttonController,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: GWdgtTextButton(
                        string: updateBtnStr,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                await updateBtn(context, buttonController);
              },
              color: updateBtnColor,
              animateOnTap: false,
            )
          ]),
        );
      }),
    );
  }
}

///[sizes]
var allContainerPadding = edgeContainer;
var overviewIconSize = ScreenUtil().setHeight(200);
var btwIconxRest = ScreenUtil().setHeight(40);
var btwAnyTwoInForm = ScreenUtil().setHeight(6);
var btwFormxUpdateBtn = 10.h;
var fieldGapPadding = 20.w;

///[Colors]
var allContainerBg = Colors.white24;
var overviewIconColor = AppColors.purpleOpcity;
var fieldColor = Colors.white70;
var updateBtnColor = Colors.blue;

///[borderradius]
double allContainerRadius = radiusDefault;

///[Borderrduis]
final double fieldsRadius = radiusDefault;

///[String]
final personalData = 'البيانات الشخصية';
final nameHint = 'الاسم: ';
final phoneHint = "رقم الجوال";
final descHint = 'وصف مختصر:';
final updateBtnStr = 'تحديث';
