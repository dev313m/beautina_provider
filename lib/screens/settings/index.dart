import 'package:beautina_provider/screens/root/functions.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:beautina_provider/screens/settings/ui/location.dart';
import 'package:beautina_provider/screens/settings/ui/personal_info.dart';
import 'package:beautina_provider/screens/settings/ui/profile_image.dart';
import 'package:beautina_provider/screens/settings/ui/support.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PageSettings extends StatefulWidget {
  PageSettings({Key key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  VMSettingsData vmSettingsData;
  ScrollController _scrollController;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      bool hideBars = Provider.of<VMRootUi>(context).hideBars;
      onScrollAction(_scrollController, context,
          onScrollUp: onScrollUp, onScrolldown: onScrollDown);
    });
  }

  @override
  Widget build(BuildContext context) {
    vmSettingsData = Provider.of<VMSettingsData>(context);
    return Scaffold(
        key: vmSettingsData.globalKey,
        backgroundColor: Colors.transparent,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(
                          ScreenUtil().setWidth(allScreenPadding)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: topSpacing),
                          WdgtSettingsProfileImage(),
                          SizedBox(height: btwImagexPorfile),
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
                    ),
                  ],
                ),
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
