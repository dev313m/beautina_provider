import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/screens/dates/ui/calendar.dart';
import 'package:beautina_provider/screens/dates/functions.dart';
import 'package:beautina_provider/screens/dates/ui/tutorial.dart';
import 'package:beautina_provider/screens/dates/ui.dart';
import 'package:beautina_provider/screens/dates/ui/order_list.dart';
import 'package:beautina_provider/screens/dates/ui/top_buttons.dart';

import 'package:beautina_provider/reusables/loading.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

// class WidgetGetAllList extends StatelessWidget {
//   final List<Order> snapshot;
//   const WidgetGetAllList({Key key, this.snapshot}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       // ...snapshot.map((order) => order.status == 5? WidgetRating(order: order,):  )

//       Column(
//         children: List.generate(snapshot.length, (index) => JustOrderWidget(order: snapshot[index])).toList(),
//       )
//     ]);
//   }
// }

// class WidgetFutureList extends StatefulWidget {
//   WidgetFutureList({Key key}) : super(key: key);

//   @override
//   _WidgetFutureListState createState() => _WidgetFutureListState();
// }

// class _WidgetFutureListState extends State<WidgetFutureList> {
//   VmDateData vmDateData;
//   @override
//   Widget build(BuildContext context) {
//     VmDateData vmDateData = Provider.of<VmDateData>(context);

//     if (vmDateData.isError)
//       return Center(
//         child: InkWell(
//           onTap: () {
//             vmDateData.iniState();
//           },
//           child: Container(
//             width: 400,
//             height: 400,
//             child: Text('إعادة تحميل'),
//           ),
//         ),
//       );
//     else if (vmDateData.isLoading)
//       return GetLoadingWidget();
//     else if (vmDateData.orderList.length == 0)
//       return Center(
//         child: ExtendedText(
//           string: 'لايوجد طلبات',
//           fontSize: ExtendedText.xbigFont,
//         ),
//       );
//     else
//       return WidgetGetAllList(snapshot: getFilteredList(vmDateData.orderList, vmDateData.filterIndex));
//   }
// }

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
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse)
        Provider.of<VMRootUi>(context).hideBars = true;
      else if (Provider.of<VMRootUi>(context).hideBars) Provider.of<VMRootUi>(context).hideBars = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    vmDateData = Provider.of<VmDateData>(context);

    return RefreshIndicator(
      semanticsLabel: 'Reload',
      onRefresh: () async {
        await vmDateData.iniState();
        return;
      },
      child: ListView(
        controller: scrollController,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(150),
          ),
          WdgtDateTopButtons(),
          WdgtDateCalendar(),
          // key: Key('uiniv'),
          WdgtDateTutorialCalendar(),

          // key: Key('uiniv')

          WdgtDateOrderList(hero: '1'),

          dataLoading ? Center(child: Loading()) : SizedBox(),
          SizedBox(height: ScreenUtil().setHeight(200))
        ],
      ),
    );
  }
}
