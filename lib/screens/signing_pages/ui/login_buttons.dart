import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///[radius]
double radius = radiusGeneral;

class WdgtLoginButtonIos extends StatelessWidget {
  final Function onPress;
  final Function onError;

  const WdgtLoginButtonIos({Key key, this.onPress, this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () async {
              onPress();

              try {
                await loginWithApple(context);
              } catch (e) {
                showToast(e.toString());
                onError();
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    Text(
                      'Apple تسجيل الدخول باستخدام',
                      style: TextStyle(fontSize: 40.sp, color: Colors.black),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 2.w, top: 10.h, bottom: 15.h),
                      child: Icon(
                        CommunityMaterialIcons.apple,
                        color: Colors.black,
                        size: 25,
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
  final Function onPress;
  final Function onError;
  const WdgtLoginButtonGoogle({Key key, this.onPress, this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await Future.delayed(Duration(seconds: 1));
        onPress();
        try {
          await loginWithGoogle(context);
          var a = 3;
        } catch (e) {
          onError();

          showToast(e.toString());
          var a = 34;
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
