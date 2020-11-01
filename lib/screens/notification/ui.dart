import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/material.dart';
import 'package:beautina_provider/models/notification.dart' as MyNotify;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationUI extends StatelessWidget {
  MyNotify.MyNotification _notification;
  NotificationUI({MyNotify.MyNotification notification})
      : _notification = notification;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: _notification.status == 0
          ? AppColors.blue.withAlpha(200)
          : AppColors.blue.withOpacity(0.1),
      borderOnForeground: true,
      borderRadius: BorderRadius.circular(9.0),
      shadowColor: Theme.of(context).canvasColor,
      child: InkWell(
        onTap: () {},
        highlightColor: Colors.transparent,
        borderRadius: new BorderRadius.circular(9),
        splashColor: Colors.pink,
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setHeight(8)), //
          child: Container(
            // height: 250,
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
                    DateTime now = DateTime.now();
                    DateTime test = DateTime.parse(_notification.createDate);
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
    );
  }
}

class BroadcastUI extends StatelessWidget {
  final MyNotify.MyNotification notification;

  const BroadcastUI({Key key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Material(
        color: notification.status == 0
            ? AppColors.pinkBright.withAlpha(200)
            : AppColors.pinkBright.withOpacity(0.5),
        borderOnForeground: true,
        borderRadius: BorderRadius.circular(9.0),
        shadowColor: Theme.of(context).canvasColor,
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.transparent,
          borderRadius: new BorderRadius.circular(9),
          splashColor: Colors.pink,
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(8)), //
            child: Container(
              // height: 250,
              // constraints: BoxConstraints(minHeight: 120, maxHeight: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150.h,
                    width: 150.h,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/default.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ExtendedText(
                    string: "${notification.title} ",
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
                    height: ScreenUtil().setHeight(20),
                  ),
                  ExtendedText(
                    string: notification.describ,
                    textAlign: TextAlign.right,
                    // overflow: TextOverflow
                    //     .fade, // it wont aloow the the text to go in a new line
                    // style: TextStyle(
                    //     fontSize: 13.0, fontFamily: 'Tajawal'),
                    // textDirection: TextDirection.rtl,
                    // textAlign: TextAlign.right,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Builder(builder: (_) {
                      DateTime now = DateTime.now();
                      DateTime test = DateTime.parse(notification.createDate);
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
      ),
    );
  }
}
