import 'package:beauty_order_provider/constants/app_colors.dart';
import 'package:beauty_order_provider/pages/notification/ui.dart';
import 'package:beauty_order_provider/pages/root/shared_variable_root.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  double currentScroll = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _animationController.dispose();
  }

  @override
  Widget build(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Index(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Index extends StatefulWidget {
  @override
  _Index createState() => _Index();
}

class _Index extends State<Index> with AutomaticKeepAliveClientMixin<Index> {
  Widget upperW;
  // AnimationController _animationController;
  // Animation _animation;
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
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse)
        Provider.of<SharedRoot>(context).hideBars = true;
      else if (Provider.of<SharedRoot>(context).hideBars)
        Provider.of<SharedRoot>(context).hideBars = false;
    });
    // _animationController =
    //     new AnimationController(vsync: this, duration: Duration(seconds: 2));
    // _animation = CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeInToLinear,
    //     reverseCurve: Curves.easeOutBack);
    // _animationController.addListener(() {
    //   this.setState(() {});
    // });
    // _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<SharedRoot>(context).refreshList();

        return;
      },
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(180),
          ),
          // SliverToBoxAdapter(
          //     child: WidgetTitlePage(
          //   title: '~ الاشعارات ~',
          // )),
          ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Container(
          height: ScreenUtil().setHeight(500),
          color: AppColors.purpleColor,
          child: FlareActor(
            'assets/rive/notification.flr',
            animation: 'active',
            // color: Colors.black.withOpacity(0.2),
          ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                Provider.of<SharedRoot>(context).notificationList.length,
            itemBuilder: (_, index) {
              return Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(4)),
                  child: 

                  Provider.of<SharedRoot>(context)
                              .notificationList
                              .elementAt(index)
                              .type ==
                          ''
                      ? 
                      Container(
                        height: 200.h,
                        child: NotificationUI(
                            notification: Provider.of<SharedRoot>(context)
                                .notificationList
                                .elementAt(index),
                          ),
                      )
                      : 
                      BroadcastUI(
                          notification: Provider.of<SharedRoot>(context)
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
