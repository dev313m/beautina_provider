import 'dart:io';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart' as painting;

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/my_salon/beauty_provider_page/index.dart';
import 'package:beautina_provider/screens/my_salon/functions.dart';
import 'package:beautina_provider/screens/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/screens/my_salon/ui_choose_service.dart';
import 'package:beautina_provider/screens/my_salon/ui_displayed_services.dart';
import 'package:beautina_provider/screens/my_salon/ui_how_I_look.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:beautina_provider/services/api/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:spring_button/spring_button.dart';

class PageSalon extends StatefulWidget {
  const PageSalon({Key key}) : super(key: key);

  @override
  _PageSalonState createState() => _PageSalonState();
}

class _PageSalonState extends State<PageSalon> with ContractSalon {
  bool availableLoad = false;
  ModelBeautyProvider beautyProvider;
  ScrollController _scrollController = ScrollController();
  bool imageLoad = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse)
        Provider.of<VMRootUi>(context).hideBars = true;
      else if (Provider.of<VMRootUi>(context).hideBars)
        Provider.of<VMRootUi>(context).hideBars = false;
    });
    // initBeautyProvider();
  }

  // FlareControls flareCtrl = FlareControls().;
  @override
  Widget build(BuildContext context) {
    beautyProvider = Provider.of<SharedSalon>(context).beautyProvider;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.purpleColor,
            child: ListView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  height:
                      ScreenUtil().setHeight(ConstRootSizes.topContainer - 40),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(33)),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        // image: AssetImage(assetName),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            File file = await imageChoose();
                            if (await file.exists() == false) return;
                            DefaultCacheManager manager =
                                new DefaultCacheManager();
                            manager.emptyCache();
                            imageLoad = true;
                            setState(() {});
                            bool response =
                                await imageUpload(file, beautyProvider.uid);
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
                                            url:
                                                'https://resorthome.000webhostapp.com/upload/${beautyProvider.uid}.jpg',
                                          ))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                          child: RatingBar.readOnly(
                            maxRating: 5,
                            initialRating: (beautyProvider.points /
                                beautyProvider.achieved),
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
                              value: beautyProvider.achieved < 100
                                  ? 'اقل من 100 طلب'
                                  : 'اكثر من ${beautyProvider.achieved % 100} طلب',
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
                    )),
                if (Provider.of<SharedSalon>(context)
                        .beautyProvider
                        .location
                        .length !=
                    2)
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                if (Provider.of<SharedSalon>(context)
                        .beautyProvider
                        .location
                        .length !=
                    2)
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white30,
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.error_outline,
                              color: Colors.red,
                              size: ScreenUtil().setHeight(200)),
                          Padding(
                            child: ExtendedText(
                              string:
                                  'لم تقومي بتحديد موقعك في الخريطة، الرجاء الذهاب لصفحة الاعدادات والضغط على زر تحديد الخريطه',
                              fontSize: ExtendedText.xbigFont,
                            ),
                            padding: EdgeInsets.all(8.h),
                          )
                        ],
                      )),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Container(
                  height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                            child: ExtendedText(
                          string: 'فتح - اغلاق صالوني',
                          fontSize: ExtendedText.xbigFont,
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: ExtendedText(
                          string: '(اضغط على المصباح لإخفاء ظهورك عند البحث)',
                          fontColor: ExtendedText.brightColors2,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(399),
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      // width: 400,

                      height: ScreenUtil().setHeight(399),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () async {
                          availableLoad = true;
                          setState(() {});
                          try {
                            /**
                             * 1- get now beautyProvider from shared
                             * 2- update and save in shared
                             * 3- get shared and notifylisteners
                             */
                            ModelBeautyProvider mbp =
                                await sharedUserProviderGetInfo();

                            await apiBeautyProviderUpdate(
                                mbp..available = !mbp.available);

                            // Provider.of<SharedSalon>(context).beautyProvider = mbp;
                            // setState(() {});
                            Provider.of<SharedSalon>(context).beautyProvider =
                                await sharedUserProviderGetInfo();
                            // var don;
                          } catch (e) {
                            showToast('حدث خطأ اثناء التحديث');
                          }

                          availableLoad = false;
                        },
                        child: Stack(
                          children: <Widget>[
                            FlareActor(
                              'assets/rive/bulb.flr',

                              animation: beautyProvider.available
                                  ? 'lightOn'
                                  : 'lightOff',
                              shouldClip: false,
                              snapToEnd: false,
                              // controller: ,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedSwitcher(
                                duration: Duration(seconds: 1),
                                child: availableLoad ? Loading() : SizedBox(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Provider.of<SharedSalon>(context).providedServices == null
                    ? SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: WidgetServices(
                          mapServices: beautyProvider.servicespro,
                        )),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                if (Provider.of<SharedSalon>(context)
                    .providedServices
                    .containsKey('services'))
                  if (Provider.of<SharedSalon>(context)
                          .providedServices['services']
                          .keys
                          .length !=
                      0)
                    WidgetAddService(
                      mapServices: Provider.of<SharedSalon>(context)
                          .providedServices['services'],
                    ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                WidgetHowLookSearch(beautyProvider: beautyProvider),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                WidgetHowMyProfile(
                  beautyProvider: beautyProvider,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              height: ScreenUtil().setHeight(ConstRootSizes.navigation),
              width: ScreenResolution.width,
            ),
          ),
        ],
      ),
    );
  }

  @override
  changeAvailibilityError() {
    // TODO: implement changeAvailibilityError
    return null;
  }

  @override
  changeAvailibilitySuccess() {
    // TODO: implement changeAvailibilitySuccess
    return null;
  }
}

class WidgetHowLookSearch extends StatelessWidget {
  const WidgetHowLookSearch({
    Key key,
    @required this.beautyProvider,
  }) : super(key: key);

  final ModelBeautyProvider beautyProvider;

  @override
  Widget build(BuildContext context) {
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
                  Icon(
                    Icons.search,
                    size: ScreenUtil().setSp(300),
                    color: AppColors.purpleColor,
                  ),
                  Expanded(
                    child: Center(
                        child: ExtendedText(
                      string: 'كيف تظهر صفحتي في البحث',
                      fontSize: ExtendedText.bigFont,
                    )),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          PageHowILookSearch(beautyProvider: beautyProvider)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetHowMyProfile extends StatelessWidget {
  const WidgetHowMyProfile({
    Key key,
    @required this.beautyProvider,
  }) : super(key: key);

  final ModelBeautyProvider beautyProvider;

  @override
  Widget build(BuildContext context) {
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
                            modelBeautyProvider: beautyProvider,
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
          ExtendedText(
              string: title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl),
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
