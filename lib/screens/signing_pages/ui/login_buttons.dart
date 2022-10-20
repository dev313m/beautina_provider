import 'package:beautina_provider/core/controller/erros_controller.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///[radius]
double radius = radiusDefault;

class WdgtLoginButtonIos extends StatelessWidget {
  final Function? onPress;
  final Function? onError;
  final BuildContext? contextT;

  const WdgtLoginButtonIos(
      {Key? key, this.onPress, this.onError, this.contextT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () async {
              onPress!();

              try {
                await loginWithApple(contextT);
              } catch (e) {
                showToast(e.toString());
                onError!();
                ErrorController.logError(
                    eventName: ErrorController.unableToLoginError,
                    exception: e);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                color: Colors.white,
                height: heightTextField,
                child: Row(
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    GWdgtTextButton(
                      string: 'Apple تسجيل الدخول باستخدام',
                      color: Colors.black,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 2.w, top: 10.h, bottom: 15.h),
                      child: Icon(
                        CommunityMaterialIcons.apple,
                        color: Colors.black,
                        size: 67.sp,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GWdgtTextTitleDesc(
            string: '( يجب اضافة صلاحية دخول الايميل )',
          ),
        ),
      ],
    );
  }
}

class WdgtLoginButtonGoogle extends StatelessWidget {
  final Function? onPress;
  final Function? onError;
  final BuildContext? contextT;
  const WdgtLoginButtonGoogle(
      {Key? key, this.onPress, this.onError, this.contextT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await Future.delayed(Duration(seconds: 1));
        onPress!();
        try {
          await loginWithGoogle(contextT);
        } catch (e) {
          showToast(e.toString());
          onError!();
          ErrorController.logError(
              eventName: ErrorController.unableToLoginError, exception: e);
          // var a = 34;
        }
        // var a = 4;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: heightTextField,
          color: ConstLoginColors.google,
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
            child: Row(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 10.h, bottom: 15.h),
                  child: Icon(
                    CommunityMaterialIcons.google,
                    color: Colors.white,
                    size: 67.sp,
                  ),
                ),
                GWdgtTextButton(
                  string: 'التسجيل بواسطة جوجل',
                  // fontSize: ExtendedText.xbigFont,
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
