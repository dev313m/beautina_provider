import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';

/// [radius]
double radiusContainer = radiusDefault;

///[Strings]

final strOpenOrCloseSalon = 'فتح - اغلاق صالوني';
final strOpenOrCloseSalonDesc = '(اضغطي على المصباح لإخفاء ظهورك عند البحث)';
final strUpdateError = 'حدث خطأ اثناء التحديث';
final strUpdateDone = 'تم التحديث بنجاح';
final strFlare = 'assets/rive/share.flr';
final strFlareAnimationStart = 'lightOn';
final strFlareAnimationFinish = 'lightOff';

///[colors]
Color colorContainerBg = Colors.white38;

///[Size]
double flareHeightSize = 0.23.sh;
// double flareWidthSize = 0.23.sh;

class WdgtSalonShare extends StatefulWidget {
  WdgtSalonShare({Key key}) : super(key: key);

  @override
  _WdgtSalonShareState createState() => _WdgtSalonShareState();
}

class _WdgtSalonShareState extends State<WdgtSalonShare> {
  ///Show loading animation when updating flag
  bool availableLoad = false;

  ModelBeautyProvider beautyProvider;
  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;

    if (beautyProvider.username.contains('+9'))
      return Container(
        decoration: BoxDecoration(
            color: colorContainerBg,
            // image: AsssetImage(assetName),
            borderRadius: BorderRadius.circular(radiusContainer)),
        child: Column(
          children: [
            
          ],
        ),
      );
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                // height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
                decoration: BoxDecoration(
                    color: colorContainerBg,
                    borderRadius: BorderRadius.circular(radiusContainer)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Y(
                      height: heightBottomContainer,
                    ),
                    Center(
                        child: GWdgtTextTitle(
                      string: strOpenOrCloseSalon,
                    )),
                    Y(),
                    GWdgtTextTitleDesc(
                      string: strOpenOrCloseSalonDesc,
                    ),
                    Y(
                      height: heightBottomContainer,
                    )
                  ],
                ),
              ),
              Y(
                height: heightBottomContainer,
              )
            ],
          ),
        ),
        Container(
          height: 50.h,
          child: Material(
            color: Colors.transparent,
            child: Ink(
              // width: 400,

              height: 50.h,
              child: InkWell(
                borderRadius: BorderRadius.circular(radiusContainer),
                onTap: () async {
                  updateUserAvailability(
                      context,
                      onAvailableChangeSuccess(),
                      onAvailableChangeLoad(),
                      onAvailableChangeError(),
                      onAvailableChangeComplete());
                },
                child: Stack(
                  children: <Widget>[
                    FlareActor(
                      strFlare,
                      animation: 'Untitled',
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
        ),
      ],
    );
  }

  Function onAvailableChangeComplete() {
    return () {
      availableLoad = false;
      setState(() {});
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
