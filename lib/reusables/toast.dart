import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showAlert(context, {@required String msg, @required String dismiss}) {
  // Reusable alert style
  var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ExtendedText.defaultFont,
          color: ExtendedText.brightColor),
      animationDuration: Duration(milliseconds: durationCalender),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppColors.purpleColor,
      titleStyle: TextStyle(
          fontSize: ExtendedText.bigFont,
          color: ExtendedText.brightColor.withOpacity(0.7)));

  // Alert dialog using custom alert style
  Alert(
      context: context,
      style: alertStyle,
      title: msg,
      content: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(110),
            child: FlareActor(
              'assets/rive/notification.flr',
              fit: BoxFit.contain,
              animation: 'active',
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
          width: ScreenUtil().setWidth(150),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.blue,
          child: ExtendedText(
            string: dismiss ?? '',
            fontSize: ExtendedText.bigFont,
          ),
        ),
      ]).show();
}
