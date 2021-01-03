import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/functions.dart';
import 'package:beautina_provider/screens/settings/functions.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
class WdgtSettingsSupport extends StatefulWidget {
  WdgtSettingsSupport({Key key}) : super(key: key);

  @override
  _WdgtSettingsSupportState createState() => _WdgtSettingsSupportState();
}

class _WdgtSettingsSupportState extends State<WdgtSettingsSupport> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: allContainerPadding),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(allContainerRadius), color: allContainerColor),
        child: Column(
          children: <Widget>[
            GWdgtTextTitle(
              string: complaintStr,
            ),
            Y(height: btwTextxIcons),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Icon(
                      CommunityMaterialIcons.whatsapp,
                      size: iconSize,
                      color: whatsappIconColor,
                    ),
                    onTap: () {
                      try {
                        getWhatsappFunction(whatsappUrl)();
                      } catch (e) {}
                    },
                  ),
                ),
                // Expanded(
                //   child: InkWell(
                //     child: Icon(
                //       CommunityMaterialIcons.telegram,
                //       size: iconSize,
                //       color: telegramIconColor,
                //     ),
                //     onTap: () {
                //       try {
                //         urlLaunch(url: telegramUrl);
                //       } catch (e) {}
                //     },
                //   ),
                // ),
                Expanded(
                  child: InkWell(
                    child: Icon(
                      CommunityMaterialIcons.instagram,
                      size: iconSize,
                      color: instagramIconColor,
                    ),
                    onTap: () {
                      try {
                        urlLaunch(url: instagramUrl);
                      } catch (e) {}
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

///[sizes]

double allContainerPadding = edgeContainer;
double btwTextxIcons = 100.h;
double iconSize = ScreenUtil().setSp(200);

///[colors]
final allContainerColor = Colors.white24;
final whatsappIconColor = Colors.green;
final telegramIconColor = Colors.blue;
final instagramIconColor = Colors.redAccent;

///[Strings]
final complaintStr = "للشكوى والاقتراحات والاستفسارات";
final telegramUrl = 'https://t.me/beautinapp';
final whatsappUrl = '+966583122121';
final instagramUrl = 'https://www.instagram.com/beautina.online';

///[Radius]
double allContainerRadius = radiusDefault;
