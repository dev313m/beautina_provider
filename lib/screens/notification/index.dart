import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:beautina_provider/screens/notification/ui/notification_item.dart';
import 'package:beautina_provider/screens/notification/ui/broadcast.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/screens/notification/ui/funny_animation.dart';

class PageNotification extends StatefulWidget {
  @override
  _PageNotification createState() => _PageNotification();
}

class _PageNotification extends State<PageNotification>
    with AutomaticKeepAliveClientMixin<PageNotification> {
  ScrollController? _scrollController;
  double currentScroll = 0;

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();

    // _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      onScrollAction(_scrollController!, context,
          onScrollUp: onScrollUp, onScrolldown: onScrollDown);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VMRootDataTest>(builder: (vmRootData) {
      return RefreshIndicator(
        onRefresh: () async {
          await vmRootData.refreshNotificationList();
          return;
        },
        child: ListView(
          padding: EdgeInsets.all(0),
          controller: _scrollController,
          children: <Widget>[
            Y(height: heightTopBar),
            Y(),
            WdgtNotificationAnimation(key: ValueKey('flower')),
            ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: vmRootData.notificationList.length,
              itemBuilder: (_, index) {
                return Padding(
                    padding: EdgeInsets.only(top: edgeContainer),
                    child: vmRootData.notificationList.elementAt(index).type ==
                            ''
                        ? WdgtNotificationItem(
                            notification:
                                vmRootData.notificationList.elementAt(index),
                          )
                        : WdgtNotificationBroadcast(
                            notification:
                                vmRootData.notificationList.elementAt(index)));
              },
            ),
            Y(
              height: bottomNavPadding,
            )
          ],
        ),
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

///[sizes]
///
// final double topTabSize = 0.1.sh;
final double bottomNavPadding = heightNavBar;
