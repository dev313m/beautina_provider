import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/calendar.dart';
import 'package:beautina_provider/screens/dates/ui/tutorial.dart';
import 'package:beautina_provider/screens/dates/ui/order_list.dart';
import 'package:beautina_provider/screens/dates/ui/top_buttons.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';

import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading/loading.dart';

class PageDate extends StatefulWidget {
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<PageDate> with AutomaticKeepAliveClientMixin<PageDate> {
  double currentScroll = 0;

  ///
  ///2 for all
  ///1 for active
  ///0 for not active
  int filterType = 0;
  List<bool> filterBool;
  Order order;
  Widget upperW;
  VmDateData vmDateData;
  bool dataLoading = false;

  List<Order> displayedList;

  // AnimationController _animationController;
  // Animation _animation;
  ScrollController scrollController;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    filterBool = [false, false, false, false, false, true];
    scrollController = ScrollController();
    scrollController.addListener(() {
      onScrollAction(scrollController, context,
          onScrollUp: onScrollUp, onScrolldown: onScrollDown);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VmDateDataTest>(
      builder: (vmDateData) {
        return RefreshIndicator(
          semanticsLabel: 'Reload',
          onRefresh: () async {
            await vmDateData.iniState();
            return;
          },
          child: ListView(
            controller: scrollController,
            children: <Widget>[
              Y(height: heightNavBar + 25.h),
              Y(),
              WdgtDateTopButtons(),
              Y(),
              WdgtDateCalendar(),
              // key: Key('uiniv'),
              WdgtDateTutorialCalendar(),

              // key: Key('uiniv')
              Y(),

              WdgtDateOrderList(hero: '1'),

              dataLoading ? Center(child: Loading()) : SizedBox(),
              SizedBox(height: heightBottomBarPadding)
            ],
          ),
        );
      }
    );
  }
}

///[heights]
double heightTopBar = 140.h;
double heightBottomBarPadding = 200.h;
