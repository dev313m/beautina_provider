import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WdgtSettingsLocation extends StatefulWidget {
  WdgtSettingsLocation({Key key}) : super(key: key);

  @override
  _WdgtSettingsLocationState createState() => _WdgtSettingsLocationState();
}

class _WdgtSettingsLocationState extends State<WdgtSettingsLocation> {
  bool loadingLocation = false;
  ModelBeautyProvider beautyProvider;
  VMSettingsData vmSettingsData;

  @override
  Widget build(BuildContext context) {
    vmSettingsData = Provider.of<VMSettingsData>(context);
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
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
            ExtendedText(
                string: locationDetails, fontSize: ExtendedText.xbigFont),
            SizedBox(
              height: btwOverviewxRest,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(allContainerRadius),
                child: Container(
                  child: Material(
                    color: inkBtnColor,
                    child: Ink(
                        height: btnHeight,
                        child: InkWell(
                          splashColor: inkBtnColor,
                          focusColor: inkBtnColor,
                          hoverColor: inkBtnColor,
                          highlightColor: inkBtnColor,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(btnIconPadding),
                                child: Icon(Icons.home),
                              ),
                              ExtendedText(
                                string: chooseLocationStr,
                                fontColor: Colors.black,
                              ),
                            ],
                          ),
                          onTap: () {
                            showMenuLocation(context, vmSettingsData.globalKey);
                          },
                        )),
                  ),
                )),
            Row(
              children: <Widget>[
                Chip(
                    label: ExtendedText(
                  string: vmSettingsData.city == null
                      ? beautyProvider.city
                      : vmSettingsData.country,
                  fontColor: Colors.black,
                )),
                Chip(
                    label: ExtendedText(
                  string: vmSettingsData.country == null
                      ? beautyProvider.country
                      : vmSettingsData.city,
                  fontColor: Colors.black,
                ))
              ],
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(allContainerRadius),
                child: Container(
                  child: Material(
                    color: inkBtnColor,
                    child: Ink(
                        height: ScreenUtil().setHeight(btnHeight),
                        child: InkWell(
                          splashColor: inkBtnColor,
                          focusColor: inkBtnColor,
                          hoverColor: inkBtnColor,
                          highlightColor: inkBtnColor,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(btnIconPadding),
                                child: Icon(Icons.location_on),
                              ),
                              loadingLocation
                                  ? Loading()
                                  : ExtendedText(
                                      string: introLocationStr,
                                      fontColor: Colors.black,
                                    ),
                            ],
                          ),
                          onTap: () async {
                            setState(() {
                              loadingLocation = true;
                            });
                            List<dynamic> location = await getMyLocation();
                            setState(() {
                              loadingLocation = false;
                              if (loadingLocation == null)
                                introLocationStr = locationErrStr;
                              else {
                                introLocationStr = locationSuccessStr;
                                vmSettingsData.location = location;
                              }
                            });
                          },
                        )),
                  ),
                )),
            SizedBox(
              height: btwBtnsxUpdateBtn,
            ),
            RoundedLoadingButton(
              controller: vmSettingsData.controller,
              borderRadius: allContainerRadius,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: ExtendedText(
                        string: updateStr,
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
          ],
        ));
  }
}

///[Sizes]
double allContainerPadding = 30.w;
double overviewIconSize = 200.h;
double btwOverviewxRest = 50.h;
double btnHeight = 100.h;
double btnIconPadding = 8.h;
double btwBtnsxUpdateBtn = 20.h;

///[Colors]
final iconColor = AppColors.pinkBright;
final allContainerBgColor = Colors.white24;
final btnColor = AppColors.pinkBright;
final updateBtnColor = Colors.lightBlue;
final inkBtnColor = Colors.pink;

///[Strings]
String introLocationStr = 'اختيار الخريطة (الرجاء تفعيل الخرائط)';
String locationErrStr = 'حدث خطأ ما، الرجاء تفعيل تحديد الموقع';
String locationSuccessStr = "تمت الاضافة ";
final String locationDetails = 'بيانات الموقع';
final String chooseLocationStr = 'اختيار المنطقة';
final String updateStr = 'تحديث';

///[borderradius]
///
double allContainerRadius = 12;
