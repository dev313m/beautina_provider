import 'package:beautina_provider/blocks/settings_personal_info/block_settings_personal_info_repo.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
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
  WdgtSetttingsPersonalInfo({Key? key}) : super(key: key);

  @override
  _WdgtSetttingsPersonalInfoState createState() =>
      _WdgtSetttingsPersonalInfoState();
}

class _WdgtSetttingsPersonalInfoState extends State<WdgtSetttingsPersonalInfo> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  late SettingsPersonalInfoUsecase? _settingsPersonalInfoUsecase;
  late SettingsPersonalInfoRepo? _settingsPersonalInfoRepo;
  final globalKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _settingsPersonalInfoUsecase = SettingsPersonalInfoUsecase();
    _settingsPersonalInfoRepo = SettingsPersonalInfoRepo();
    _settingsPersonalInfoRepo!
        .initSettingsPersonalUsercase(_settingsPersonalInfoUsecase!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(allContainerPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(allContainerRadius),
            color: allContainerBg),
        child: Form(
          key: formKey,
          // autovalidate: vmSettingsData.autoValidate,
          child: Column(children: [
            Icon(CommunityMaterialIcons.account_edit,
                color: overviewIconColor, size: overviewIconSize),
            GWdgtTextTitle(
              string: personalData,
            ),
            Y(),
            new BeautyTextfield(
              helperText: nameHint,
              placeholder:
                  BeautyProviderController.getBeautyProviderProfile().name ??
                      '',
              inputType: TextInputType.text,
              // height: 33,
              onChanged: (val) {
                _settingsPersonalInfoUsecase?.name = val;
              },
              suffixIcon: Icon(CommunityMaterialIcons.face_profile),
            ),
            SizedBox(height: btwAnyTwoInForm),
            BeautyTextfield(
              inputType: TextInputType.phone,
              maxLength: 9,
              helperText: '966',
              placeholder: BeautyProviderController.getBeautyProviderProfile()
                  .phone
                  ?.substring(
                      4,
                      BeautyProviderController.getBeautyProviderProfile()
                          .phone!
                          .length),
              prefixIcon: Icon(Icons.phone),
              onChanged: (val) {
                _settingsPersonalInfoUsecase?.phone = Countries.phoneCodePlus[
                        BeautyProviderController.getBeautyProviderProfile()
                            .country!]! +
                    convertArabicToEnglish(val);
              },
            ),
            Y(),
            BeautyTextfield(
              // initialValue: beautyProvider.intro,
              placeholder:
                  BeautyProviderController.getBeautyProviderProfile().intro,
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
                _settingsPersonalInfoUsecase?.desc = val;
              },
            ),
            Y(),
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
                  showMenuLocation(
                      context, Get.find<VMSettingsDataTest>().globalKey);
                },
              ),
            ),
            GetBuilder<VMSalonDataTest>(builder: (vMSalonData) {
              return GetBuilder<VMSettingsDataTest>(
                  init: VMSettingsDataTest(),
                  builder: (vmSettingsData) {
                    return Row(
                      children: <Widget>[
                        Chip(
                            label: GWdgtTextSmall(
                          string: vmSettingsData.city == null
                              ? vMSalonData.beautyProvider.city
                              : vmSettingsData.country,
                          color: Colors.black,
                        )),
                        Chip(
                            label: GWdgtTextSmall(
                          string: vmSettingsData.country == null
                              ? vMSalonData.beautyProvider.country
                              : vmSettingsData.city,
                          color: Colors.black,
                        ))
                      ],
                    );
                  });
            }),
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
                try {
                  var city = Get.find<VMSettingsDataTest>().city;
                  var country = Get.find<VMSettingsDataTest>().country;

                  if (city != null && city != '')
                    _settingsPersonalInfoUsecase!.city =
                        Get.find<VMSettingsDataTest>().city;
                  if (country != null && country != '')
                    _settingsPersonalInfoUsecase!.country =
                        Get.find<VMSettingsDataTest>().country;

                  _settingsPersonalInfoRepo!
                      .validateInput(_settingsPersonalInfoUsecase!);
                  await updateBtn(context, buttonController,
                      city: city,
                      country: country,
                      desc: _settingsPersonalInfoUsecase!.desc,
                      name: _settingsPersonalInfoUsecase!.name,
                      phone: _settingsPersonalInfoUsecase!.phone);
                } catch (e) {
                  buttonController.error();
                  showToast(e.toString());
                }
              },
              color: updateBtnColor,
              animateOnTap: false,
            )
          ]),
        ));
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
