import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/notification/ui.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/screens/notification/functions.dart';
import 'package:beautina_provider/screens/notification/ui/funny_animation.dart';

class PageNotification extends StatefulWidget {
  @override
  _PageNotification createState() => _PageNotification();
}

class _PageNotification extends State<PageNotification>
    with AutomaticKeepAliveClientMixin<PageNotification> {
  ScrollController _scrollController;
  double currentScroll = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();

    // _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      bool hideBars = Provider.of<VMRootUi>(context).hideBars;
      onScrollAction(_scrollController, hideBars, context,
          onScrollUp: onScrollUp, onScrolldown: onScrollDown);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<VMRootData>(context).refreshNotificationList();
        return;
      },
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(180),
          ),
          WdgtNotificationAnimation(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Provider.of<VMRootData>(context).notificationList.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(4)),
                child: Provider.of<VMRootData>(context)
                            .notificationList
                            .elementAt(index)
                            .type ==
                        ''
                    ? Container(
                        height: 200.h,
                        child: NotificationUI(
                          notification: Provider.of<VMRootData>(context)
                              .notificationList
                              .elementAt(index),
                        ),
                      )
                    : BroadcastUI(
                        notification: Provider.of<VMRootData>(context)
                            .notificationList
                            .elementAt(index)),
              );
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(100),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // List<Widget> getNotifyList(){
  //   if(inheritNotification.notificationList.length == 0)
  //     return [CircularProgressIndicator(
  //       backgroundColor: Colors.purple,
  //     )];
  //     return [
  //       NotificationUI(notification: inh,)
  //     ];
  // }
}
