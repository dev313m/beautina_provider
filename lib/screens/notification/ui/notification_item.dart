import 'package:flutter/material.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/models/notification.dart' as MyNotify;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class WdgtNotificationItem extends StatelessWidget {
  final MyNotify.MyNotification _notification;
  WdgtNotificationItem({MyNotify.MyNotification notification})
      : _notification = notification;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(4)),
        child: Material(
          color: _notification.status == 0
              ? AppColors.blue.withAlpha(200)
              : AppColors.blue.withOpacity(0.1),
          borderOnForeground: true,
          borderRadius: BorderRadius.circular(12),
          shadowColor: Theme.of(context).canvasColor,
          child: InkWell(
            onTap: () {},
            highlightColor: Colors.transparent,
            borderRadius: new BorderRadius.circular(12),
            splashColor: Colors.pink,
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(8)), //
              child: Container(
                height: 250,
                // constraints: BoxConstraints(minHeight: 120, maxHeight: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ExtendedText(
                      string: "${_notification.title} ",
                      fontSize: ExtendedText.bigFont,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Visibility(visible: true, child: SizedBox()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ExtendedText(
                              string: _notification.describ,
                              textAlign: TextAlign.right,
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
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Builder(builder: (_) {
                        DateTime test =
                            DateTime.parse(_notification.createDate);
                        // test = test.toLocal();
                        return ExtendedText(
                          string: timeago.format(test,
                              // allowFromNow: true,
                              locale: 'ar'),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

///[sizes]
const double imageH = 0.1;
const double imageW = 0.1;
const double containerOuterPadding = 4;
const double containerInnerPadding = 15;
const double imageSeperationHeight = 0.03;
const double introSeperationHeight = 0.01;

///[string]
const String imageStr = 'assets/images/default.png';

///[colors]
final Color notiBackgroundRead = AppColors.pinkBright.withAlpha(200);
final Color notiBackgroundNotRead = AppColors.pinkBright.withOpacity(0.5);
final Color containerSplash = Colors.pink;

///[raduis]

const double containerRaduis = 12;
