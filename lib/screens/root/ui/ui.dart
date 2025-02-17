import 'dart:io';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final String GOOGLE_APP_URL = 'http://play.google.com/store/apps/details?id=com.beautina.service_provider';
final String APPLE_APP_URL = 'https://apps.apple.com/us/app/beautina.service-provider/id1536944501';
onAlertWithCustomImagePressed(context) {
  Alert(
    context: context,
    title: "RFLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
    image: Image.asset("assets/success.png"),
  ).show();
}

// Alert custom content

onAlertWithCustomContentPressed(context) {
  // Reusable alert style
  var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isButtonVisible: true,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: ExtendedText.bigFont, color: ExtendedText.brightColor),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusDefault),
      ),
      backgroundColor: AppColors.purpleColor,
      titleStyle: TextStyle(fontSize: ExtendedText.bigFont, color: ExtendedText.brightColor.withOpacity(0.7)));

  // Alert dialog using custom alert style
  Alert(
      context: context,
      closeFunction: () {
        print('im here');
      },
      style: alertStyle,
      onWillPopActive: true,
      title: "يوجد تحديث جديد",
      content: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(250),
            child: FlareActor(
              'assets/rive/upgrade.flr',
              fit: BoxFit.cover,
              animation: 'spin2',
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
          width: ScreenUtil().setWidth(300),
          onPressed: () {
            var url;
            url = Platform.isIOS ? APPLE_APP_URL : GOOGLE_APP_URL;
            launchURL(url);
          },
          color: AppColors.blue,
          child: GWdgtTextDescDesc(
            string: "تحديث",
          ),
        )
      ]).show();
}
