import 'package:flutter/material.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/models/notification.dart' as MyNotify;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class WdgtNotificationBroadcast extends StatelessWidget {
  final MyNotify.MyNotification notification;

  const WdgtNotificationBroadcast({Key key, this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(top: ScreenUtil().setWidth(containerOuterPadding)),
        child: Material(
          color: notification.status == 0
              ? notiBackgroundRead
              : notiBackgroundNotRead,
          borderOnForeground: true,
          borderRadius: BorderRadius.circular(containerRaduis),
          shadowColor: Theme.of(context).canvasColor,
          child: InkWell(
            onTap: () {},
            highlightColor: Colors.transparent,
            borderRadius: new BorderRadius.circular(containerRaduis),
            splashColor: containerSplash,
            child: Padding(
              padding: EdgeInsets.all(
                  ScreenUtil().setHeight(containerInnerPadding)), //
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: imageH.sh,
                    width: imageW.sh,
                    child: ClipOval(
                      child: Image.asset(
                        imageStr,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: imageSeperationHeight.sh,
                  ),
                  ExtendedText(
                    string: "${notification.title} ",
                    fontSize: ExtendedText.bigFont,
                  ),
                  SizedBox(
                    height: introSeperationHeight.sh,
                  ),
                  ExtendedText(
                    string: notification.describ,
                    textAlign: TextAlign.right,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Builder(builder: (_) {
                      DateTime test = DateTime.parse(notification.createDate);
                      // test = test.toLocal();
                      return ExtendedText(
                        string: timeago.format(test, locale: 'ar'),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

///[sizes]
const double containerRaduis = 12;
const double imageH = 0.1;
const double imageW = 0.1;

const double imageSeperationHeight = 0.03;
const double introSeperationHeight = 0.01;

///[string]
const String imageStr = 'assets/images/default.png';

///[colors]
final Color notiBackgroundRead = AppColors.pinkBright.withAlpha(200);
final Color notiBackgroundNotRead = AppColors.pinkBright.withOpacity(0.5);
final Color containerSplash = Colors.pink;

///[raduis]
const double containerOuterPadding = 4;
const double containerInnerPadding = 15;
