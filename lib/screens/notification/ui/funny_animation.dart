import 'package:beautina_provider/constants/app_colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class WdgtNotificationAnimation extends StatefulWidget {
  WdgtNotificationAnimation({Key key}) : super(key: key);

  @override
  _WdgtNotificationAnimationState createState() =>
      _WdgtNotificationAnimationState();
}

class _WdgtNotificationAnimationState extends State<WdgtNotificationAnimation> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Container(
        height: ScreenUtil().setHeight(500),
        color: AppColors.purpleColor,
        child: FlareActor(
          'assets/rive/notification.flr',
          animation: 'active',
          // color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
