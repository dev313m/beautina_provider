import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/utils/animated/loading.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:rating_bar_flutter/rating_bar_flutter.dart';

/// [radius]
double radiusButton = radiusDefault;
double radiusContainer = radiusDefault;

///[edge]
double edgeMainContainer = edgeContainer;
double edgeMainText = 8.h;

///[colors]
Color colorContainerBg = Colors.white38;
Color colorIconFavorite = Colors.amber;
Color colorIconDetails = AppColors.purpleOpcity;

///[Strings]
final strImageServerUrl = 'https://resorthome.000webhostapp.com/upload/';
final strImageExtension = '.jpg';
final strMyPoints = 'نقاطي';
final strAcheivedOrders = 'الطلبات المنجزة';
final strLocation = 'الموقع';
final strMobile = 'الجوال';
final strDefaultProfileImage = 'assets/images/default.png';

///[sizes]
final double sizeIconFavorite = 60.sp;
double sizeImageProfile = 500.w;
final double sizeIconDetails = 100.sp;

class WdgtSalonProfileDetails extends StatefulWidget {
  WdgtSalonProfileDetails({Key? key}) : super(key: key);

  @override
  _WdgtSalonProfileDetailsState createState() =>
      _WdgtSalonProfileDetailsState();
}

class _WdgtSalonProfileDetailsState extends State<WdgtSalonProfileDetails> {
  bool imageLoad = false;
  late ModelBeautyProvider beautyProvider;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VMSalonDataTest>(builder: (vMSalonData) {
      beautyProvider = vMSalonData.beautyProvider;

      if (beautyProvider == null) return SizedBox();
      return Container(
          decoration: BoxDecoration(
              color: colorContainerBg,
              // image: AsssetImage(assetName),
              borderRadius: BorderRadius.circular(radiusContainer)),
          child: Padding(
            padding: EdgeInsets.all(edgeMainContainer),
            child: Column(
              children: <Widget>[
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
                                : beautyProvider.image != ''
                                    ? ImageFirebase(
                                        height: sizeImageProfile,
                                        width: sizeImageProfile,
                                        url:
                                            'gs://beautina-firebase.appspot.com/image_profile/' +
                                                beautyProvider.uid!,
                                      )
                                    : Image.asset(
                                        strDefaultProfileImage,
                                        height: sizeImageProfile,
                                        width: sizeImageProfile,
                                        fit: BoxFit.cover,
                                      ))),
                  ),
                ),

                Y(),
                if (!beautyProvider.username!.contains('+'))
                  GWdgtTextTitle(
                    string: beautyProvider.username,
                  ),
                Y(),
                RatingBarFlutter.readOnly(
                  maxRating: 5,
                  initialRating:
                      (beautyProvider.points! / beautyProvider.achieved!),
                  filledIcon: CommunityMaterialIcons.heart,
                  emptyIcon: CommunityMaterialIcons.heart_outline,
                  halfFilledIcon: CommunityMaterialIcons.heart_half,
                  isHalfAllowed: true,
                  filledColor: colorIconFavorite,
                  size: sizeIconFavorite,
                ),
                Y(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  // childAspectRatio: 0.3,
                  children: <Widget>[
                    InfoItem(
                      icon: CommunityMaterialIcons.gift,
                      title: strMyPoints,
                      value: beautyProvider.points.toString(),
                    ),
                    CustomDivider(),
                    InfoItem(
                      icon: CommunityMaterialIcons.certificate,
                      title: strAcheivedOrders,
                      value: beautyProvider.achieved! < 100
                          ? 'اقل من 100 طلب'
                          : beautyProvider.achieved as String?,
                    ),
                    CustomDivider(),
                    InfoItem(
                      icon: CommunityMaterialIcons.map_plus,
                      title: strLocation,
                      value: beautyProvider.city.toString(),
                    ),
                    CustomDivider(),
                    InfoItem(
                      icon: CommunityMaterialIcons.whatsapp,
                      title: strMobile,
                      value: beautyProvider.phone.toString(),
                    ),
                  ],
                ),
                Y(
                  height: heightBottomContainer,
                )
                // Y()
              ],
            ),
          ));
    });
  }

  Function onProfileImageChangeComplete() {
    return () async {
      imageLoad = false;
      setState(() {}); // showToast(strUpdateDone);
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

class InfoItem extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? value;
  const InfoItem({Key? key, this.icon, this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      // height: ScreenUtil().setHeight(200),
      child: Column(
        children: <Widget>[
          GWdgtTextProfile(
            string: title,
          ),
          Icon(
            icon,
            size: sizeIconDetails,
            color: colorIconDetails,
          ),
          Y(
            height: BoxHeight.heightBtwContainers,
          ),
          GWdgtTextProfile(
            string: value,
          )
        ],
      ),
    );
  }
}

class MyImage extends StatelessWidget {
  final String? url;
  final width;
  final height;
  const MyImage({Key? key, this.url, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url!,
      useOldImageOnUrlChange: true,
      placeholder: (_, __) {
        return GetLoadingWidget();
      },
      errorWidget: (_, __, ___) {
        return Image.asset(
          strDefaultProfileImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      },
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}

class ImageFirebase extends StatelessWidget {
  final String? url;
  final width;
  final height;
  final useCache;
  const ImageFirebase(
      {Key? key, this.useCache = true, this.url, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Image.asset(
          strDefaultProfileImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      },
      image: FirebaseImage(url!,
          shouldCache: false,
          cacheRefreshStrategy: CacheRefreshStrategy.BY_METADATA_DATE
          // cache: false,
          // durationExpiration: Duration(milliseconds: 10)
          // duration: Duration(days: 7),
          ),
    );
  }
}
