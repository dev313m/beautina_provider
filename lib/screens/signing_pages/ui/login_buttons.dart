import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtLoginButtonIos extends StatelessWidget {
  final Function onPress;
  const WdgtLoginButtonIos({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () async {
              try {
                await loginWithApple(context);
              } catch (e) {
                showToast(e.toString());
              }
              onPress();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    Text(
                      'Apple تسجيل الدخول باستخدام',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 2, top: 10, bottom: 15),
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
          child: Text(
            '( يجب اضافة صلاحية دخول الايميل )',
            style: TextStyle(color: Colors.white70, fontSize: 10),
            // fontColor: Colors.white,
            // fontSize: ExtendedText.smallFont,
          ),
        ),
      ],
    );
  }
}

class WdgtLoginButtonGoogle extends StatelessWidget {
  final Function onPress;
  const WdgtLoginButtonGoogle({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await loginWithGoogle(context);
        } catch (e) {
          showToast(e.toString());
        }
        onPress();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: ConstLoginColors.google,
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
            child: Column(
              children: <Widget>[
                ExtendedText(
                  string: 'التسجيل بواسطة جوجل',
                  fontSize: ExtendedText.xbigFont,
                ),
                Icon(
                  CommunityMaterialIcons.google,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
