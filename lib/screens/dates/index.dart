import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/calendar/calendar.dart';
import 'package:beautina_provider/screens/dates/ui/tutorial.dart';
import 'package:beautina_provider/screens/dates/ui/order_list.dart';
import 'package:beautina_provider/screens/dates/ui/top_buttons.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/utils/redesigned_packages/scrollable_tab.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/error_flare.dart';
import 'package:beautina_provider/utils/ui/space.dart';

import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PageDate extends StatefulWidget {
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<PageDate>
    with AutomaticKeepAliveClientMixin<PageDate> {
  double currentScroll = 0;

  ///
  ///2 for all
  ///1 for active
  ///0 for not active
  int filterType = 0;
  List<bool>? filterBool;
  Order? order;
  Widget? upperW;
  VmDateData? vmDateData;
  bool dataLoading = false;

  List<Order>? displayedList;

  // AnimationController _animationController;
  // Animation _animation;
  ScrollController? scrollController;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    filterBool = [false, false, false, false, false, true];
    scrollController = ScrollController();
    scrollController!.addListener(() {
      onScrollAction(scrollController!, context,
          onScrollUp: onScrollUp, onScrolldown: onScrollDown);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VmDateDataTest>(builder: (vmDateData) {
      return RefreshIndicator(
        semanticsLabel: 'Reload',
        onRefresh: () async {
          await vmDateData.iniState();
          return;
        },
        child: ListView(
          padding: EdgeInsets.all(0),
          controller: scrollController,
          children: <Widget>[
            Y(height: heightTopBar),
            Y(),
            // WdgtDateTopButtons(),
            // Y(),
            GetBuilder<VMSalonDataTest>(builder: (context) {
              return WdgtDateCalendar();
            }),
            // key: Key('uiniv'),
            WdgtDateTutorialCalendar(),

            // key: Key('uiniv')
            Y(),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusDefault),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      // Colors.transparent,
                      Colors.transparent,
                      AppColors.purpleColor,

                      AppColors.purpleColor,
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                  color: AppColors.purpleColor,
                  child: Column(
                    children: [
                      Container(
                        height: 0.74.sh,
                        child: vmDateData.isError
                            ? Center(
                                child: GetOnErrorWidget(
                                  onTap: () => vmDateData.iniState(),
                                ),
                              )
                            : vmDateData.isLoading
                                ? Shimmer.fromColors(
                                    baseColor: AppColors.pinkBright,
                                    highlightColor: Colors.grey[300]!,
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: WdgtTabOrders(),
                                    ),
                                  )
                                : WdgtTabOrders(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class WdgtTabOrders extends StatelessWidget {
  const WdgtTabOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WdgtScrollableListTabView(
      tabHeight: 135.h,
      tabs: [
        ScrollableListTab(
            tab: ListTab(
                label: GWdgtTextTitleDesc(string: 'بحاجة لتاكيدك'),
                // icon: Icon(Icons.notifications_none, size: 40.sp),
                showIconOnList: true,
                inactiveBackgroundColor: AppColors.pinkBright.withOpacity(0.2),
                activeBackgroundColor: AppColors.pinkOpcity.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            body: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Get.find<VmDateDataTest>()
                    .listOfDay
                    .where((element) => element.status == 0)
                    .toList()
                    .length,
                itemBuilder: (_, index) {
                  return WdgtOrderItemBrief(
                    isArgent: true,
                    hero: '1',
                    order: Get.find<VmDateDataTest>()
                        .listOfDay
                        .where((element) => element.status == 0)
                        .toList()[index],
                  );
                })),
        ScrollableListTab(
            tab: ListTab(
                label: GWdgtTextTitleDesc(string: 'بإنتظار تآكيد الزبون'),
                // icon: Icon(Icons.pending_actions, size: 40.sp),
                showIconOnList: true,
                activeBackgroundColor: AppColors.blue,
                inactiveBackgroundColor: AppColors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(0)),
            body: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: Get.find<VmDateDataTest>()
                    .listOfDay
                    .where((element) => element.status == 1)
                    .toList()
                    .length,
                itemBuilder: (_, index) {
                  var a = Get.find<VmDateDataTest>()
                      .listOfDay
                      .where((element) => element.status == 1)
                      .toList();
                  return WdgtOrderItemBrief(
                    hero: '2',
                    order: a[index],
                  );
                })),
        ScrollableListTab(
            tab: ListTab(
                showIconOnList: true,
                label: GWdgtTextTitleDesc(string: 'مؤكد'),
                icon: Icon(Icons.done, size: 40.sp),
                activeBackgroundColor: AppColors.blue,
                inactiveBackgroundColor: AppColors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            body: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: Get.find<VmDateDataTest>()
                    .listOfDay
                    .where((element) => element.status == 3)
                    .toList()
                    .length,
                itemBuilder: (_, index) {
                  var a = Get.find<VmDateDataTest>()
                      .listOfDay
                      .where((element) => element.status == 3)
                      .toList();
                  return WdgtOrderItemBrief(
                    hero: '3',
                    order: a[index],
                  );
                })),
      ],
    );
  }
}

///[heights]
double heightBottomBarPadding = 200.h;
