import 'dart:io';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/app_url.dart';
import 'package:beautina_provider/pages/root/functions.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:community_material_icon/community_material_icon.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      isOverlayTapDismiss: false,
      descStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ExtendedText.bigFont,
          color: ExtendedText.brightColor),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: AppColors.purpleColor,
      titleStyle: TextStyle(
          fontSize: ExtendedText.bigFont,
          color: ExtendedText.brightColor.withOpacity(0.7)));

  // Alert dialog using custom alert style
  Alert(
      context: context,
      style: alertStyle,
      title: "يوجد تحديث جديد",
      content: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(100),
            child: FlareActor(
              'assets/rive/upgrade.flr',
              fit: BoxFit.contain,
              animation: 'spin2',
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
          width: ScreenUtil().setWidth(150),
          onPressed: () {
            var url = '';
            url = Platform.isIOS ? APP_URL_IOS : APP_URL_ANRROID;
            launchURL(url);
          },
          color: AppColors.blue,
          child: ExtendedText(
            string: "تحديث",
            fontSize: ExtendedText.bigFont,
          ),
        )
      ]).show();
}

class WidgetNoConnection extends StatelessWidget {
  const WidgetNoConnection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.black.withOpacity(0.5),
        ),
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 4,
        child: FlareActor(
          'assets/rive/noconnection.flr',
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
          animation: 'no_netwrok',
        ),
      ),
    );
  }
}
