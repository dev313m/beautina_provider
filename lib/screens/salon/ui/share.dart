import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
Color colorContainerBg = Colors.black54;

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
  ///
  RoundedLoadingButtonController roundedLoadingButtonController =
      RoundedLoadingButtonController();
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Y(
                height: BoxHeight.heightBtwTitle,
              ),
              GWdgtTextTitle(
                  string: 'انشئي اسم مستعار، لتشاركي رابط خدماتك مع زبائنك'),
              GWdgtTextTitleDesc(
                string: "(لم تقومي بإختيار اسم مستعار)",
                color: Colors.redAccent,
              ),
              Container(
                height: 200.h,
                child: FlareActor(
                  strFlare,
                  animation: 'Untitled',
                  shouldClip: false,
                  snapToEnd: false,
                  // controller: ,
                ),
              ),
              Y(
                height: BoxHeight.heightBtwContainers,
              ),
              // GWdgtTextTitleDesc(
              //   string: 'عند انشاء اسم مستعارص يمكنكي مشاركة حسابك لدى زبائنك',
              //   // fontColor: ExtendedText.brightColors2,
              // ),
              Y(
                height: 60.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: BeautyTextfield(
                  // height: ScreenUtil().setHeight(90),
                  onChanged: (String s) {
                    Provider.of<VMSettingsData>(context).username = s;
                  },
                  // textStyle: TextStyle(color: AppColors.pinkBright),
                  suffixIcon: Icon(
                    Icons.supervised_user_circle_outlined,
                  ),
                  helperText: 'مثال: beauty_salon',
                  inputType: TextInputType.text,
                ),
              ),
              Y(),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusDefault),
                child: RoundedLoadingButton(
                  controller: roundedLoadingButtonController,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(radiusDefault),
                      ),
                      height: 100,
                      width: double.infinity,
                      child: Center(child: GWdgtTextButton(string: 'حفظ'))),
                  onPressed: () async {
                    // if (checkFields()) {
                    //   await updateProviderServices(
                    //       context,
                    //       showOther,
                    //       chosenService,
                    //       priceBefore,
                    //       priceAfter,
                    //       otherServiceName,
                    //       _btnController);
                    //   clearFields();
                    // }

                    // _btnController.reset();

                    funUpdateUsername(context, roundedLoadingButtonController);
                  },
                  // controller: _btnController,
                ),
              ),
              Y(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.all(edgeText),
                child: Row(
                  children: [
                    // GWdgtTextTitleDesc(
                    //   string: 'مشاركة حسابي',
                    // ),

                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              color: Colors.white70,
                              icon: Icon(Icons.ios_share),
                              onPressed: () {
                                gFunShareAccount(beautyProvider.username);

                                if (beautyProvider.username.contains('+9'))
                                  showToast('لم تقومي بحفظ اسم مستعار');
                                else
                                  gFunShareAccount(beautyProvider.username);
                              },
                            ),
                            IconButton(
                              color: Colors.white70,
                              icon: Icon(Icons.copy),
                              onPressed: () {
                                if (beautyProvider.username.contains('+9'))
                                  showToast('لم تقومي بحفظ اسم مستعار');
                                else
                                  gFunCopyText(
                                      'https://beautina.online/${beautyProvider.username}');
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    return Container(
      decoration: BoxDecoration(
          color: colorContainerBg,
          // image: AsssetImage(assetName),
          borderRadius: BorderRadius.circular(radiusContainer)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Y(
              height: BoxHeight.heightBtwTitle,
            ),
            // GWdgtTextTitle(string: 'رابط حسابي'),
            Container(
              height: 400.h,
              child: FlareActor(
                strFlare,
                animation: 'Untitled',
                shouldClip: false,
                snapToEnd: false,
                // controller: ,
              ),
            ),
 
            // GWdgtTextTitleDesc(
            //   string: 'عند انشاء اسم مستعارص يمكنكي مشاركة حسابك لدى زبائنك',
            //   // fontColor: ExtendedText.brightColors2,
            // ),

  
            Padding(
              padding: EdgeInsets.all(edgeText),
              child: Row(
                children: [
                  Column(
                    children: [
                      GWdgtTextTitleDesc(
                        string:
                            "(شاركي حسابك لزبائنك وفي مواقع التواصل الاجتماعي)",
                        color: Colors.redAccent,
                      ),
                      GWdgtTextTitleDesc(
                        string:
                            "https://beautina.app.link/${beautyProvider.username}",
                      ),
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            color: Colors.white70,
                            icon: Icon(Icons.ios_share),
                            onPressed: () {
                              gFunShareAccount(beautyProvider.username);

                              if (beautyProvider.username.contains('+9'))
                                showToast('لم تقومي بحفظ اسم مستعار');
                              else
                                gFunShareAccount(beautyProvider.username);
                            },
                          ),
                          IconButton(
                            color: Colors.white70,
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              if (beautyProvider.username.contains('+9'))
                                showToast('لم تقومي بحفظ اسم مستعار');
                              else
                                gFunCopyText(
                                    'https://beautina.app.link/${beautyProvider.username}');
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
