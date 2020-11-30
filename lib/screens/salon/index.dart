import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/screens/salon/ui/close_open_salon.dart';
import 'package:beautina_provider/screens/salon/ui/how_i_look_search/how_i_look_in_search.dart';
import 'package:beautina_provider/screens/salon/ui/how_my_profile_look.dart';
import 'package:beautina_provider/screens/salon/ui/location_not_set.dart';
import 'package:beautina_provider/screens/salon/ui/profile_details.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/salon/ui/adding_services.dart';
import 'package:beautina_provider/screens/salon/ui/ui_displayed_services.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PageSalon extends StatefulWidget {
  const PageSalon({Key key}) : super(key: key);

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
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse)
        Provider.of<VMRootUi>(context).hideBars = true;
      else if (Provider.of<VMRootUi>(context).hideBars) Provider.of<VMRootUi>(context).hideBars = false;
    });
    // initBeautyProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.purpleColor,
            child: ListView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(ConstRootSizes.topContainer - 40),
                ),
                WdgtSalonProfileDetails(),
                if (Provider.of<VMSalonData>(context).beautyProvider.location.length != 2)
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                if (Provider.of<VMSalonData>(context).beautyProvider.location.length != 2) WdgtSalonLocationNotSet(),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                WdgtSalonCloseOpenSalon(),
                if (Provider.of<VMSalonData>(context).providedServices != null)
                  ClipRRect(borderRadius: BorderRadius.circular(15), child: WdgtSalonMyServices()),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                if (Provider.of<VMSalonData>(context).providedServices.containsKey('services'))
                  if (Provider.of<VMSalonData>(context).providedServices['services'].keys.length != 0) WdgtSalonAddService(),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                WdgtSalonHowLookProfile(),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                WdgtSalonHowLookSearch(),
                SizedBox(
                  height: 100,
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
      ),
    );
  }
}
