import 'package:flutter/material.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/notification.dart' as MyNotify;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';

class WdgtNotificationItem extends StatelessWidget {
  final MyNotify.MyNotification _notification;
  WdgtNotificationItem({MyNotify.MyNotification notification})
      : _notification = notification;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _notification.status == 0
          ? AppColors.blue.withAlpha(200)
          : AppColors.blue.withOpacity(0.1),
      borderOnForeground: true,
      borderRadius: BorderRadius.circular(containerRaduis),
      shadowColor: Theme.of(context).canvasColor,
      child: InkWell(
        onTap: () {},
        highlightColor: Colors.transparent,
        borderRadius: new BorderRadius.circular(containerRaduis),
        splashColor: Colors.pink,
        child: Padding(
          padding: EdgeInsets.all(containerOuterPadding),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Center(
                        child: Icon(
                      Icons.circle_notifications,
                      size: 90.sp,
                      color: _notification.status == 0
                          ? Colors.yellow.withAlpha(200)
                          : Colors.yellow.withOpacity(0.1),
                    )),
                    Center(
                      child: Builder(builder: (_) {
                        DateTime test =
                            DateTime.parse(_notification.createDate);
                        // test = test.toLocal();
                        return GWdgtTextSmall(
                          string: timeago.format(test,
                              // allowFromNow: true,
                              locale: 'ar'),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GWdgtTextTitleDesc(
                      string: "${_notification.title} ",
                      textAlign: TextAlign.start,
                      // fontSize: ExtendedText.bigFont,
                    ),
                    Y(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GWdgtTextDescDesc(
                            string: _notification.describ ,
                            textAlgin: TextAlign.start,
                            // textAlign: TextAlign.right,
                            // overflow: TextOverflow
                            //     .fade, // it wont aloow the the text to go in a new line
                            // style: TextStyle(
                            //     fontSize: 13.0, fontFamily: 'Tajawal'),
                            // textDirection: TextDirection.rtl,
                            // textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///[sizes]
const double imageH = 0.1;
const double imageW = 0.1;

///[padding]
 double containerOuterPadding = edgeText;
 double containerInnerPadding = edgeText;
const double imageSeperationHeight = 0.03;
const double introSeperationHeight = 0.01;

///[string]
const String imageStr = 'assets/images/default.png';

///[colors]
final Color notiBackgroundRead = AppColors.pinkBright.withAlpha(200);
final Color notiBackgroundNotRead = AppColors.pinkBright.withOpacity(0.5);
final Color containerSplash = Colors.pink;

///[raduis]

double containerRaduis = radiusDefault;
