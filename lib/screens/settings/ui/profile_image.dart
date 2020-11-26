import 'dart:io';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/index.dart';
import 'package:beautina_provider/screens/salon/ui/profile_details.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:beautina_provider/services/api/image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class WdgtSettingsProfileImage extends StatefulWidget {
  WdgtSettingsProfileImage({Key key}) : super(key: key);

  @override
  _WdgtSettingsProfileImageState createState() =>
      _WdgtSettingsProfileImageState();
}

class _WdgtSettingsProfileImageState extends State<WdgtSettingsProfileImage> {
  ModelBeautyProvider beautyProvider;
  VMSettingsData vmSettingsData;

  ///Loading status shown when image is updating
  bool imageLoad = false;

  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
    vmSettingsData = Provider.of<VMSettingsData>(context);
    return Column(
      children: [
        ExtendedText(string: strProfileEdit, fontSize: ExtendedText.xbigFont),
        SizedBox(height: btwStrxImage),
        InkWell(
          onTap: () {
            updateImage();
          },
          child: Container(
            height: imageSize,
            width: imageSize,
            child: ClipOval(
                key: Key('ovalkey'),
                // clipper: ,
                // height: ScreenUtil().setHeight(300),
                child: AnimatedSwitcher(
                    duration: imageUpdateTransition,
                    child: imageLoad
                        ? Loading()
                        : Stack(
                            children: <Widget>[
                              MyImage(
                                key: ValueKey('imagelk'),
                                url:
                                    '$imageUrl${beautyProvider.uid}$imageExtension',
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  CommunityMaterialIcons.folder_edit,
                                  color: iconColor,
                                  size: iconSize,
                                ),
                              )
                            ],
                          ))),
          ),
        )
      ],
    );
  }

  updateImage() async {
    File file = await imageChoose();
    if (await file.exists() == false) return;
    // painting.imageCache.clear();
    DefaultCacheManager manager = new DefaultCacheManager();
    manager.emptyCache();
    imageLoad = true;
    setState(() {});
    bool response = await imageUpload(file, beautyProvider.uid);
    if (response) {
      try {
        // imageCache.clear();
        // painting.imageCache.clear();
        DefaultCacheManager manager = new DefaultCacheManager();
        manager.emptyCache();
        await Future.delayed(Duration(seconds: 8));
        setState(() {});
      } catch (e) {
        showToast('حدث خطأ في التحديث ${e.toString()}');
      }
      imageLoad = false;
    }
  }
}

///[sizes]
var btwStrxImage = ScreenUtil().setHeight(20);
var imageSize = ScreenUtil().setHeight(399);
var iconSize = ScreenUtil().setSp(80);

///[String]
const strProfileEdit = 'تعديل الصورة الشخصية';
const imageUrl = 'https://resorthome.000webhostapp.com/upload/';
const imageExtension = '.jpg';

///[colors]
const Color iconColor = Colors.deepOrange;

///[Durations]
const imageUpdateTransition = Duration(seconds: 1);
