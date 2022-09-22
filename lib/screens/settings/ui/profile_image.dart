import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/ui/profile_details.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:beautina_provider/utils/animated/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';

class WdgtSettingsProfileImage extends StatefulWidget {
  WdgtSettingsProfileImage({Key? key}) : super(key: key);

  @override
  _WdgtSettingsProfileImageState createState() =>
      _WdgtSettingsProfileImageState();
}

class _WdgtSettingsProfileImageState extends State<WdgtSettingsProfileImage> {
  /// * Loading status shown when image is updating
  bool imageLoad = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GWdgtTextTitle(
          string: strProfileEdit,
        ),
        Y(height: btwStrxImage),
        InkWell(
          onTap: () async {
            imageCache!.clear();

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
            child: ClipOval(
                // clipper: ,
                // height: ScreenUtil().setHeight(300),
                child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: imageLoad
                        ? GetLoadingWidget()
                        : BeautyProviderController.getBeautyProviderProfile()
                                    .image !=
                                ''
                            ? ImageFirebase(
                                key: ValueKey('image_change'),
                                height: sizeImageProfile,
                                width: sizeImageProfile,
                                url: FIREBASE_STORAGE_URL +
                                    BeautyProviderController
                                            .getBeautyProviderProfile()
                                        .uid!,
                              )
                            : Image.asset(
                                strDefaultProfileImage,
                                height: sizeImageProfile,
                                key: ValueKey('image_change_assets'),
                                width: sizeImageProfile,
                                fit: BoxFit.cover,
                              ))),
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
