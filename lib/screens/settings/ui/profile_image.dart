import 'dart:io';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/ui/profile_details.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';

import 'package:flutter/services.dart';

class WdgtSettingsProfileImage extends StatefulWidget {
  WdgtSettingsProfileImage({Key key}) : super(key: key);

  @override
  _WdgtSettingsProfileImageState createState() =>
      _WdgtSettingsProfileImageState();
}

class _WdgtSettingsProfileImageState extends State<WdgtSettingsProfileImage> {
  ModelBeautyProvider beautyProvider;
  VMSettingsData vmSettingsData;

  /// * Loading status shown when image is updating
  bool imageLoad = false;

  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;
    vmSettingsData = Provider.of<VMSettingsData>(context);
    return Column(
      children: [
        GWdgtTextTitle(
          string: strProfileEdit,
        ),
        Y(height: btwStrxImage),
        InkWell(
          onTap: () async {
            imageCache.clear();

            updateProfileImage(
                context,
                onProfileImageChangeLoad(),
                onProfileImageChangeSuccess(),
                onProfileImageChangeError(),
                onProfileImageChangeComplete());
          },
          child: Container(
            height: sizeImageProfile,
            width: sizeImageProfile,
            child: Stack(
              children: [
                ClipOval(
                    key: ValueKey('image'),

                    // clipper: ,
                    // height: ScreenUtil().setHeight(300),
                    child: AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: imageLoad
                            ? Loading()
                            : beautyProvider.image != ''
                                ? ImageFirebase(
                                    height: sizeImageProfile,
                                    width: sizeImageProfile,
                                    url:
                                        'gs://beautina-firebase.appspot.com/image_profile/' +
                                            beautyProvider.uid,
                                  )
                                : Image.asset(
                                    strDefaultProfileImage,
                                    height: sizeImageProfile,
                                    width: sizeImageProfile,
                                    fit: BoxFit.cover,
                                  ))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    Icons.edit,
                    color: Colors.orange,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Function onProfileImageChangeComplete() {
    return () async {
      imageLoad = false;
      setState(() {}); // - showToast(strUpdateDone);
    };
  }

  Function onProfileImageChangeError() {
    return () {
      setState(() {});
    };
  }

  Function onProfileImageChangeLoad() {
    return () async {
      imageLoad = true;
      setState(() {});
    };
  }

  Function onProfileImageChangeSuccess() {
    return () {};
  }
}

///[sizes]
var btwStrxImage = ScreenUtil().setHeight(20);
var imageSize = ScreenUtil().setHeight(399);
var iconSize = ScreenUtil().setSp(80);

///[String]
const strProfileEdit = 'تعديل الصورة الشخصية';
const imageExtension = '.jpg';

///[colors]
const Color iconColor = Colors.deepOrange;

///[Durations]
const imageUpdateTransition = Duration(seconds: 1);
