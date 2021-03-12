import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/screens/salon/ui/share.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WdgtSettingsUsername extends StatefulWidget {
  WdgtSettingsUsername({Key key}) : super(key: key);

  @override
  _WdgtSettingsUsernameState createState() => _WdgtSettingsUsernameState();
}

class _WdgtSettingsUsernameState extends State<WdgtSettingsUsername> {
  // ModelBeautyProvider beautyProvider;

  RoundedLoadingButtonController roundedLoadingButtonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    // beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
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
            GWdgtTextTitle(string: 'تعديل اسم المستخدم'),
            Container(
              height: 300.h,
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
            GetBuilder<VMSalonDataTest>(
              builder: (vMSalonData) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: BeautyTextfield(
                    // height: ScreenUtil().setHeight(90),
                    onChanged: (String s) {
                      Get.find<VMSettingsDataTest>().username = s;
                    },
                    // textStyle: TextStyle(color: AppColors.pinkBright),
                    suffixIcon: Icon(
                      Icons.supervised_user_circle_outlined,
                    ),
                    helperText:vMSalonData. beautyProvider.username.contains('+')
                        ? 'مثال: beauty_salon'
                        : vMSalonData.beautyProvider.username,
                    inputType: TextInputType.text,
                  ),
                );
              }
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
              height: BoxHeight.heightBtwContainers,
            ),
          ],
        ),
      ),
    );
  }
}

final strFlare = 'assets/rive/share.flr';

///[colors]
Color colorContainerBg = Colors.black54;

///[Size]
double flareHeightSize = 0.23.sh;
// double flareWidthSize = 0.23.sh;
