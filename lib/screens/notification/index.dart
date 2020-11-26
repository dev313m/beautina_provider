import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/screens/notification/ui/notification_item.dart';
import 'package:beautina_provider/screens/notification/ui/broadcast.dart';

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
            height: topTabSize.sh,
          ),
          WdgtNotificationAnimation(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Provider.of<VMRootData>(context).notificationList.length,
            itemBuilder: (_, index) {
              return Provider.of<VMRootData>(context)
                          .notificationList
                          .elementAt(index)
                          .type ==
                      ''
                  ? WdgtNotificationItem(
                      notification: Provider.of<VMRootData>(context)
                          .notificationList
                          .elementAt(index),
                    )
                  : WdgtNotificationBroadcast(
                      notification: Provider.of<VMRootData>(context)
                          .notificationList
                          .elementAt(index));
            },
          ),
          SizedBox(
            height: bottomNavPadding.sh,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

///[sizes]
///
const double topTabSize = 0.1;
const double bottomNavPadding = 0.1;
