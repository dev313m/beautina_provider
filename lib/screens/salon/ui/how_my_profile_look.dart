import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/index.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WdgtSalonHowLookProfile extends StatefulWidget {
  const WdgtSalonHowLookProfile({
    Key key,
  }) : super(key: key);

  @override
  _WdgtSalonHowLookProfileState createState() => _WdgtSalonHowLookProfileState();
}

class _WdgtSalonHowLookProfileState extends State<WdgtSalonHowLookProfile> {
  ModelBeautyProvider modelBeautyProvider;
  @override
  Widget build(BuildContext context) {
    modelBeautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        child: Material(
          color: Colors.white24,
          child: Ink(
            width: double.infinity,
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: ExtendedText(
                      string: 'كيف تظهر صفحتي',
                      fontSize: ExtendedText.bigFont,
                    )),
                  ),
                  Icon(
                    CommunityMaterialIcons.store,
                    size: ScreenUtil().setSp(300),
                    color: AppColors.purpleColor,
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BeautyProviderPage(
                            modelBeautyProvider: modelBeautyProvider,
                            withHero: false,
                          )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
