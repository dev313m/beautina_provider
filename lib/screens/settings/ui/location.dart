import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';

class WdgtSettingsLocation extends StatefulWidget {
  WdgtSettingsLocation({Key? key}) : super(key: key);

  @override
  _WdgtSettingsLocationState createState() => _WdgtSettingsLocationState();
}

class _WdgtSettingsLocationState extends State<WdgtSettingsLocation> {
  bool loadingLocation = false;
  // ModelBeautyProvider beautyProvider;
  // VMSettingsData vmSettingsData;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(allContainerPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(allContainerRadius),
            color: allContainerBgColor),
        child: Column(
          children: <Widget>[
            Icon(CommunityMaterialIcons.map_marker_check,
                color: iconColor, size: overviewIconSize),
            GWdgtTextTitle(
              string: locationDetails,
            ),
            Y(),
            GetBuilder<VMSettingsDataTest>(builder: (vmSettingsData) {
              return Directionality(
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
                    showMenuLocation(context, vmSettingsData.globalKey);
                  },
                ),
              );
            }),
            GetBuilder<VMSalonDataTest>(builder: (vMSalonData) {
              return GetBuilder<VMSettingsDataTest>(builder: (vmSettingsData) {
                return Row(
                  children: <Widget>[
                    Chip(
                        label: ExtendedText(
                      string: vmSettingsData.city == null
                          ? vMSalonData.beautyProvider.city
                          : vmSettingsData.country,
                      fontColor: Colors.black,
                    )),
                    Chip(
                        label: ExtendedText(
                      string: vmSettingsData.country == null
                          ? vMSalonData.beautyProvider.country
                          : vmSettingsData.city,
                      fontColor: Colors.black,
                    ))
                  ],
                );
              });
            }),
            GetBuilder<VMSettingsDataTest>(builder: (vmSettingsData) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: BeautyTextfield(
                  suffixIcon: Icon(Icons.location_on),
                  placeholder: loadingLocation
                      ? 'جاري التحميل، انقري مره اخرى عند التآخير'
                      : introLocationStr,
                  readOnly: true,
                  inputType: TextInputType.text,
                  onTap: () async {
                    setState(() {
                      loadingLocation = true;
                    });
                    List<double> location = await getMyLocation();
                    loadingLocation = false;
                    if (location.toString() == null)
                      introLocationStr = locationErrStr;
                    else {
                      introLocationStr =
                          locationSuccessStr + location.toString();
                      vmSettingsData.location = location;
                    }
                    await Future.delayed(Duration(seconds: 3));
                    setState(() {});
                  },
                ),
              );
            }),
            Y(),
            RoundedLoadingButton(
              controller: buttonController,
              borderRadius: allContainerRadius,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: GWdgtTextButton(
                        string: updateStr,
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
          ],
        ));
  }
}

///[Sizes]
double allContainerPadding = edgeContainer;
double overviewIconSize = 200.h;
double btwOverviewxRest = 50.h;
double btnHeight = 100.h;
double btnIconPadding = 8.h;
double btwBtnsxUpdateBtn = 20.h;

///[Colors]
final iconColor = AppColors.purpleOpcity;
final allContainerBgColor = Colors.white24;
final btnColor = AppColors.pinkBright;
final updateBtnColor = Colors.lightBlue;
final inkBtnColor = Colors.pink;

///[Strings]
String introLocationStr = 'انقري هنا لإضافة احداثيات موقعك';
String locationErrStr = 'حدث خطأ ما، الرجاء تفعيل تحديد الموقع';
String locationSuccessStr = "تمت الاضافة ";
final String locationDetails = 'بيانات الموقع';
final String chooseLocationStr = 'اختيار المنطقة';
final String updateStr = 'تحديث';

///[borderradius]
///
double allContainerRadius = radiusDefault;
