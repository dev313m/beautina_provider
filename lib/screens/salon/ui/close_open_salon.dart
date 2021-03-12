import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

/// [radius]
double radiusContainer = radiusDefault;

///[Strings]

final strOpenOrCloseSalon = 'فتح - اغلاق صالوني';
final strOpenOrCloseSalonDesc = '(اضغطي على المصباح لإخفاء ظهورك عند البحث)';
final strUpdateError = 'حدث خطأ اثناء التحديث';
final strUpdateDone = 'تم التحديث بنجاح';
final strFlare = 'assets/rive/bulb.flr';
final strFlareAnimationStart = 'lightOn';
final strFlareAnimationFinish = 'lightOff';

///[colors]
Color colorContainerBg = Colors.white38;

///[Size]
double flareHeightSize = 0.23.sh;
// double flareWidthSize = 0.23.sh;

class WdgtSalonCloseOpenSalon extends StatefulWidget {
  WdgtSalonCloseOpenSalon({Key key}) : super(key: key);

  @override
  _WdgtSalonCloseOpenSalonState createState() => _WdgtSalonCloseOpenSalonState();
}

class _WdgtSalonCloseOpenSalonState extends State<WdgtSalonCloseOpenSalon> {
  ///Show loading animation when updating flag
  bool availableLoad = false;

  ModelBeautyProvider beautyProvider;
  @override
  Widget build(BuildContext context) {

    return GetBuilder<VMSalonDataTest>(builder: (vMSalonData) {
          beautyProvider = vMSalonData.beautyProvider;
        return Column(
          children: [
            Container(
              // height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
              decoration: BoxDecoration(color: colorContainerBg, borderRadius: BorderRadius.circular(radiusContainer)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                                Y(height: heightBottomContainer,), 

                  Center(
                      child: GWdgtTextTitle(
                    string: strOpenOrCloseSalon,
                  )),
                  Y(),
                  GWdgtTextTitleDesc(
                    string: strOpenOrCloseSalonDesc,
                  ),               Y(height: heightBottomContainer,)

                ],
                
              ),
            ),
            Container(
              height: flareHeightSize,
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  // width: 400,

                  height: flareHeightSize,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radiusContainer),
                    onTap: () async {
                      updateUserAvailability(
                          context, onAvailableChangeSuccess(), onAvailableChangeLoad(), onAvailableChangeError(), onAvailableChangeComplete());
                    },
                    child: Stack(
                      children: <Widget>[
                        FlareActor(
                          strFlare,
                          animation: beautyProvider.available ? strFlareAnimationStart : strFlareAnimationFinish,
                          shouldClip: false,
                          snapToEnd: false,
                          // controller: ,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedSwitcher(
                            duration: Duration(seconds: 1),
                            child: availableLoad ? Loading() : SizedBox(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),               Y(height: heightBottomContainer,)

          ],
        );
      }
    );
  }

  Function onAvailableChangeComplete() {
    return ()  {
      availableLoad = false; 
      setState(() {
        
      });
    };
  }

  Function onAvailableChangeError() {
    return () {
      showToast(strUpdateError);
    };
  }

  Function onAvailableChangeLoad() {
    return () async {
      availableLoad = true;
      setState(() {});
    };
  }

  Function onAvailableChangeSuccess() {
    return () {
      availableLoad = false;
    };
  }
}
