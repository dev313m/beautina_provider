import 'dart:io';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/index.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/services/api/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

class WdgtSalonProfileDetails extends StatefulWidget {
  WdgtSalonProfileDetails({Key key}) : super(key: key);

  @override
  _WdgtSalonProfileDetailsState createState() => _WdgtSalonProfileDetailsState();
}

class _WdgtSalonProfileDetailsState extends State<WdgtSalonProfileDetails> {
  bool imageLoad = false;
  ModelBeautyProvider beautyProvider;

  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<VMSalonData>(context).beautyProvider;

    return Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(33)),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            // image: AsssetImage(assetName),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () async {
                File file = await imageChoose();
                if (await file.exists() == false) return;
                DefaultCacheManager manager = new DefaultCacheManager();
                manager.emptyCache();
                imageLoad = true;
                setState(() {});
                bool response = await imageUpload(file, beautyProvider.uid);
                if (response) {
                  try {
                    // imageCache.clear();
                    // painting.imageCache.clear();
                    manager.emptyCache();

                    await Future.delayed(Duration(seconds: 8));
                    // super.setState(() {});
                    setState(() {});
                  } catch (e) {
                    showToast('حدث خطأ في التحديث ${e.toString()}');
                  }
                  imageLoad = false;
                }
              },
              child: Container(
                height: ScreenUtil().setHeight(399),
                width: ScreenUtil().setHeight(399),
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
                                url: 'https://resorthome.000webhostapp.com/upload/${beautyProvider.uid}.jpg',
                              ))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
              child: RatingBar.readOnly(
                maxRating: 5,
                initialRating: (beautyProvider.points / beautyProvider.achieved),
                filledIcon: CommunityMaterialIcons.heart,
                emptyIcon: CommunityMaterialIcons.heart_outline,
                halfFilledIcon: CommunityMaterialIcons.heart_half,
                isHalfAllowed: true,
                filledColor: Colors.amber,
                size: ScreenUtil().setSp(39),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              // childAspectRatio: 0.3,
              children: <Widget>[
                InfoItem(
                  icon: CommunityMaterialIcons.gift,
                  title: 'نقاطي',
                  value: beautyProvider.points.toString(),
                ),
                CustomDivider(),
                InfoItem(
                  icon: CommunityMaterialIcons.certificate,
                  title: 'الطلبات المنجزة',
                  value: beautyProvider.achieved < 100 ? 'اقل من 100 طلب' : 'اكثر من ${beautyProvider.achieved % 100} طلب',
                ),
                CustomDivider(),
                InfoItem(
                  icon: CommunityMaterialIcons.map_plus,
                  title: 'الموقع',
                  value: beautyProvider.city.toString(),
                ),
                CustomDivider(),
                InfoItem(
                  icon: CommunityMaterialIcons.whatsapp,
                  title: 'الجوال',
                  value: beautyProvider.username.toString(),
                ),
              ],
            ),
          ],
        ));
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const InfoItem({Key key, this.icon, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      // height: ScreenUtil().setHeight(200),
      child: Column(
        children: <Widget>[
          ExtendedText(string: title, textAlign: TextAlign.center, textDirection: TextDirection.rtl),
          Icon(
            icon,
            size: ScreenUtil().setSp(60),
            color: AppColors.pinkBright,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          ExtendedText(
            string: value,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
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
          'assets/images/default.jpg',
          height: ScreenUtil().setHeight(399),
          width: ScreenUtil().setHeight(399),
          fit: BoxFit.cover,
        );
      },
      height: ScreenUtil().setHeight(399),
      width: ScreenUtil().setHeight(399),
      fit: BoxFit.cover,
    );
  }
}
