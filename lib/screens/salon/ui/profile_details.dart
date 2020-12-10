import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

/// [radius]
const double radiusButton = 14;
const double radiusContainer = 14;

///[edge]
double edgeMainContainer = 15.h;
double edgeMainText = 8.h;

///[colors]
Color colorContainerBg = Colors.white38;
Color colorIconFavorite = Colors.amber;
Color colorIconDetails = Colors.pink;

///[Strings]
final strImageServerUrl = 'https://resorthome.000webhostapp.com/upload/';
final strImageExtension = '.jpg';
final strMyPoints = 'نقاطي';
final strAcheivedOrders = 'الطلبات المنجزة';
final strLocation = 'الموقع';
final strMobile = 'الجوال';
final strDefaultProfileImage = 'assets/images/default.png';

///[sizes]
final double sizeIconFavorite = ScreenUtil().setSp(39);
final double sizeImageProfile = 299.h;
final double sizeIconDetails = 44.sp;

class WdgtSalonProfileDetails extends StatefulWidget {
  WdgtSalonProfileDetails({Key key}) : super(key: key);

  @override
  _WdgtSalonProfileDetailsState createState() =>
      _WdgtSalonProfileDetailsState();
}

class _WdgtSalonProfileDetailsState extends State<WdgtSalonProfileDetails> {
  bool imageLoad = false;
  ModelBeautyProvider beautyProvider;

  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;

    return Padding(
      padding: EdgeInsets.all(edgeMainContainer),
      child: Container(
          decoration: BoxDecoration(
              color: colorContainerBg,
              // image: AsssetImage(assetName),
              borderRadius: BorderRadius.circular(radiusContainer)),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () async {
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
                      key: Key('ovalkey'),
                      // clipper: ,
                      // height: ScreenUtil().setHeight(300),
                      child: AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: imageLoad
                              ? Loading()
                              : MyImage(
                                  key: ValueKey('imagelk'),
                                  url:
                                      '$strImageServerUrl${beautyProvider.uid}$strImageExtension',
                                ))),
                ),
              ),
              Y(
                height: BoxHeight.heightBtwContainers,
              ),
              RatingBar.readOnly(
                maxRating: 5,
                initialRating:
                    (beautyProvider.points / beautyProvider.achieved),
                filledIcon: CommunityMaterialIcons.heart,
                emptyIcon: CommunityMaterialIcons.heart_outline,
                halfFilledIcon: CommunityMaterialIcons.heart_half,
                isHalfAllowed: true,
                filledColor: colorIconFavorite,
                size: sizeIconFavorite,
              ),
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
                    value: beautyProvider.achieved < 100
                        ? 'اقل من 100 طلب'
                        : 'اكثر من ${beautyProvider.achieved % 100} طلب',
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
                    value: beautyProvider.username.toString(),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Function onProfileImageChangeComplete() {
    return () async {
      // showToast(strUpdateDone);
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
  final IconData icon;
  final String title;
  final String value;
  const InfoItem({Key key, this.icon, this.title, this.value})
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
  final String url;
  const MyImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      useOldImageOnUrlChange: true,
      placeholder: (_, __) {
        return Loading();
      },
      errorWidget: (_, __, ___) {
        return Image.asset(
          strDefaultProfileImage,
          height: sizeImageProfile,
          width: sizeImageProfile,
          fit: BoxFit.cover,
        );
      },
      height: sizeImageProfile,
      width: sizeImageProfile,
      fit: BoxFit.cover,
    );
  }
}
