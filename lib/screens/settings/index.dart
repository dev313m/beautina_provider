import 'package:beautina_provider/blocks/settings_personal_info/block_settings_personal_info.dart';
import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/settings/ui/location.dart';
import 'package:beautina_provider/screens/settings/ui/personal_info.dart';
import 'package:beautina_provider/screens/settings/ui/profile_image.dart';
import 'package:beautina_provider/screens/settings/ui/support.dart';
import 'package:beautina_provider/screens/settings/ui/username.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';

class PageSettings extends StatefulWidget {
  PageSettings({Key? key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  VMSettingsData? vmSettingsData;
  ScrollController? _scrollController;
  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
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
    return Scaffold(
        // key: vmSettingsData.globalKey,
        backgroundColor: Colors.transparent,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.all(0),
                controller: _scrollController,
                children: <Widget>[
                  Y(height: heightTopBar),
                  Y(),
                  Y(),
                  WdgtSettingsProfileImage(),
                  Y(),
                  Y(),
                  WdgtSettingsUsername(),
                  Y(),
                  WdgtSetttingsPersonalInfo(),
                  new SizedBox(
                    height: btwProfilexLocation,
                  ),
                  WdgtSettingsLocation(),
                  new SizedBox(
                    height: btwLocationxSupport,
                  ),
                  WdgtSettingsSupport(),
                  new SizedBox(
                    height: buttomSpacing,
                  ),
                ],
              ),
            )));
  }
}

///[sizes]
var allScreenPadding = ScreenUtil().setWidth(8);
var topSpacing = ScreenUtil().setHeight(200);
var btwImagexPorfile = ScreenUtil().setWidth(50);
var btwProfilexLocation = ScreenUtil().setWidth(100);
var btwLocationxSupport = ScreenUtil().setWidth(100);
var buttomSpacing = ScreenUtil().setWidth(100);
