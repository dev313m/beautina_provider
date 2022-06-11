import 'package:beautina_provider/blocks/all_services/block_all_services.dart';
import 'package:beautina_provider/blocks/my_services/block_my_services.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/salon/ui/auto_accept_default.dart';
import 'package:beautina_provider/screens/salon/ui/close_open_salon.dart';
import 'package:beautina_provider/screens/salon/ui/share.dart';

import 'package:beautina_provider/screens/salon/ui/location_not_set.dart';
import 'package:beautina_provider/screens/salon/ui/profile_details.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/salon/ui/adding_services.dart';
import 'package:beautina_provider/screens/salon/ui/ui_displayed_services.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:get/instance_manager.dart';

class PageSalon extends StatefulWidget {
  const PageSalon({Key? key}) : super(key: key);

  @override
  _PageSalonState createState() => _PageSalonState();
}

class _PageSalonState extends State<PageSalon> {
  bool availableLoad = false;
  // ModelBeautyProvider beautyProvider;
  ScrollController _scrollController = ScrollController();
  bool imageLoad = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      onScrollAction(_scrollController, context,
          onScrollUp: onScrollUp, onScrolldown: onScrollDown);
    });

    // initBeautyProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.purpleColor,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Y(height: heightTopBar), Y(),
              WdgtSalonProfileDetails(
                key: ValueKey('tdest'),
              ),
              Y(),
              const BlockAllServices(),

              const BlockMyServices(),

              // Y(),

              Y(),

              WdgtSalonShare(),
              Y(),

              GetBuilder<GlobalValBeautyProviderListenable>(
                  builder: (vMSalonDataTest) {
                if (vMSalonDataTest.beautyProvider.location!.length != 2)
                  return WdgtSalonLocationNotSet();
                return SizedBox();
              }),
              Y(),
              WdgtSalonCloseOpenSalon(),

              Y(),
              GetBuilder<VMSalonDataTest>(builder: (vMSalonDataTest) {
                if (vMSalonDataTest.providedServices!
                    .containsKey('services')) if (vMSalonDataTest
                        .providedServices!['services'].keys.length !=
                    0) return WdgtSalonAddService();
                return SizedBox();
              }),
              Y(),

              WdgtSalonDefaultAccept(),

              Y(),
              // WdgtSalonHowLookProfile(),

              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.transparent,
            height: ScreenUtil().setHeight(ConstRootSizes.navigation),
            width: ScreenResolution.width,
          ),
        ),
      ],
    );
  }
}
