import 'package:beautina_provider/blocks/location_alert/location_alert_repo.dart';
import 'package:beautina_provider/screens/settings/ui/location.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationAlertBlock extends StatefulWidget {
  const LocationAlertBlock({Key? key}) : super(key: key);

  @override
  State<LocationAlertBlock> createState() => _LocationAlertBlockState();
}

class _LocationAlertBlockState extends State<LocationAlertBlock> {
  late LocationAlertRepo _locationAlertRepo;

  /// [radius]
  double radiusButton = radiusDefault;
  double radiusContainer = radiusDefault;

  ///[edge]
  double edgeMainContainer = edgeContainer;
  double edgeMainText = 16;

  ///[colors]
  Color colorContainerBg = Colors.white38;
  Color colorSubmitButton = Colors.blue;
  Color colorTitleFont = Colors.white;
  Color colorToggle = Colors.black;
  Color colorToggleSplash = Colors.black;
  @override
  void initState() {
    super.initState();

    _locationAlertRepo = LocationAlertRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(edgeMainContainer),
          // height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
          decoration: BoxDecoration(
              color: colorContainerBg,
              borderRadius: BorderRadius.circular(radiusContainer)),
          child: Column(children: [
            Icon(CupertinoIcons.alarm_fill),
            Container(
              // height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
              decoration: BoxDecoration(
                  // color: colorContainerBg,
                  borderRadius: BorderRadius.circular(radiusContainer)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Y(
                    height: heightBottomContainer,
                  ),
                  Center(
                      child: GWdgtTextTitle(
                    string: 'تحديث موقعك في الخريطة',
                  )),
                  Y(),
                  GWdgtTextTitleDesc(
                    string:
                        'يجب أن يكون إحداثيات موقعك متوفرة حتى يتمكن العملاء من العثور عليك',
                  ),
                ],
              ),
            ),
          ]),
        ),
        WdgtSettingsLocation()
      ],
    );
  }
}
