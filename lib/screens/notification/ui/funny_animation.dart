import 'package:beautina_provider/constants/app_colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WdgtNotificationAnimation extends StatefulWidget {
  WdgtNotificationAnimation({Key? key}) : super(key: key);

  @override
  _WdgtNotificationAnimationState createState() => _WdgtNotificationAnimationState();
}

class _WdgtNotificationAnimationState extends State<WdgtNotificationAnimation> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widgetRadius),
      child: Container(
        height: widgetHeight,
        color: AppColors.purpleColor,
        child: FlareActor(
          "assets/rive/goodone.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: 'Swing',
        ),
      ),
    );
  }
}

/// [sizes]
///
double widgetHeight = 0.34.sh;

/// [radius]
///
const double widgetRadius = 17;
