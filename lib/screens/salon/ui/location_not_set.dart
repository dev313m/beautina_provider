import 'package:beautina_provider/blocks/constants/app_colors.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

///[colors]
Color colorContainerBg = Colors.black54;
Color colorIcon = Color(0xff862a5c);

///[size]
double sizeIcon = 400.sp;

/// [radius]
double radiusContainer = radiusDefault;

/// [String]
final strLocationAlert =
    'قومي بتحديث احداثيات موقعك بالضغط على تحديث، لكي يتمكن الزبائن من اكتشافك..';

class WdgtSalonLocationNotSet extends StatefulWidget {
  const WdgtSalonLocationNotSet({Key? key}) : super(key: key);

  @override
  State<WdgtSalonLocationNotSet> createState() =>
      _WdgtSalonLocationNotSetState();
}

class _WdgtSalonLocationNotSetState extends State<WdgtSalonLocationNotSet> {
  bool loadingLocation = false;
  List<double> geoLocation = [];
  // ModelBeautyProvider beautyProvider;
  // VMSettingsData vmSettingsData;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalValBeautyProviderListenable>(builder: (_) {
      if (_.beautyProvider.location!.length == 2) return SizedBox();
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusContainer),
            color: colorContainerBg,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 480.h,
                child: FlareActor(
                  'assets/rive/error.flr',
                  fit: BoxFit.contain,
                  animation: 'idle',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0.h),
                child: GWdgtTextTitleDesc(
                  string: strLocationAlert,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              RoundedLoadingButton(
                controller: buttonController,
                borderRadius: allContainerRadius,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: GWdgtTextButton(
                          string: 'تحديث الاحداثيات',
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  setState(() {
                    loadingLocation = true;
                  });
                  try {
                    geoLocation = await getMyLocation();
                  } catch (e) {}
                  loadingLocation = false;
                  if (geoLocation.isEmpty)
                    introLocationStr = locationErrStr;
                  else {
                    introLocationStr =
                        locationSuccessStr + geoLocation.toString();
                  }
                  if (geoLocation.isNotEmpty)
                    await updateCountryCity(
                        buttonController, geoLocation.first, geoLocation.last);
                  else {
                    showToast(
                        'الرجاء المحاوله مره اخرى بالضغط على تحديد الموقع، ثم التحديث');
                  }
                },
                color: updateBtnColor,
                animateOnTap: false,
              )
            ],
          ));
    });
    // return Obx(() {});
  }

  //[Sizes]
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
  String locationSuccessStr = "تمت اضافة الاحداثيات ";
  final String locationDetails = 'بيانات الموقع';
  final String chooseLocationStr = 'اختيار المنطقة';
  final String updateStr = 'تحديث';

  ///[borderradius]
  ///
  double allContainerRadius = radiusDefault;
}
