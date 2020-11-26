import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/constants.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/functions.dart';
import 'package:beautina_provider/screens/salon/ui/beauty_provider_page/ui.dart';
import 'package:beautina_provider/screens/root/utils/constants.dart';
import 'package:beautina_provider/reusables/divider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading/loading.dart';
// import '../../../../static/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

class BeautyProviderPage extends StatefulWidget {
  ModelBeautyProvider modelBeautyProvider;
  bool withHero = true;
  String uid = ''; //if we want to get from database
  BeautyProviderPage({this.modelBeautyProvider, this.withHero = true, this.uid = '', Key key}) : super(key: key);

  @override
  _BeautyProviderPageState createState() => _BeautyProviderPageState();
}

class _BeautyProviderPageState extends State<BeautyProviderPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Index(
      modelBeautyProvider: widget.modelBeautyProvider,
      withHero: widget.withHero,
    );
  }
}

class Index extends StatefulWidget {
  final ModelBeautyProvider modelBeautyProvider;
  bool withHero = true;
  Index({this.modelBeautyProvider, @required this.withHero, Key key}) : super(key: key);

  @override
  _Index createState() => _Index();
}

class _Index extends State<Index> with TickerProviderStateMixin {
  Animatable<Color> background;

  Animation _animation;
  AnimationController _animationCntr;
  OrderUi _orderUi = OrderUi();
  @override
  void dispose() {
    _animationCntr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationCntr = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationCalender),
    )..forward();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationCntr);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new Stack(
      children: <Widget>[
        WillPopScope(
          child: new Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: ConstShopColors.backgroundColor,
            body: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: FlareActor(
                    'assets/rive/background2.flr',
                    fit: BoxFit.fitWidth,
                    animation: 'Flow',
                  ),
                ),
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(children: <Widget>[
                    new Center(
                      child: new Column(
                        children: <Widget>[
                          // new SizedBox(
                          //   height: ScreenUtil()
                          //       .setHeight(ConstShopSizes.paddingImage),
                          // ),

                          Container(
                            height: ScreenUtil().setHeight(600),
                            child: ClipRRect(
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent],
                                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: CachedNetworkImage(
                                  imageUrl: 'https://resorthome.000webhostapp.com/upload/${widget.modelBeautyProvider.uid}.jpg',
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          ),
                          // CircleAvatar(
                          //   radius: ScreenUtil().setHeight(ConstShopSizes.image),
                          //   backgroundImage:
                          //       NetworkImage(widget.modelBeautyProvider.image),
                          // ),

                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  // Colors.black,
                                  // Colors.transparent,
                                ],
                              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(33)),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  // image: AssetImage(assetName),
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    ExtendedText(
                                      string: widget.modelBeautyProvider.name,
                                      fontSize: ExtendedText.bigFont,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                                      child: RatingBar.readOnly(
                                        maxRating: 5,
                                        initialRating: (widget.modelBeautyProvider.points / widget.modelBeautyProvider.achieved),
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
                                          title: 'التقييمات',
                                          value: widget.modelBeautyProvider.voter.toString().toString(),
                                        ),
                                        CustomDivider(),
                                        InfoItem(
                                          icon: CommunityMaterialIcons.book,
                                          title: 'الطلبات المنجزة',
                                          value: widget.modelBeautyProvider.achieved.toString(),
                                        ),
                                        CustomDivider(),
                                        InkWell(
                                          onTap: () {
                                            getLaunchMapFunction(widget.modelBeautyProvider.location)();
                                          },
                                          child: InfoItem(
                                            icon: CommunityMaterialIcons.map_plus,
                                            title: 'الموقع',
                                            value: widget.modelBeautyProvider.city.toString(),
                                          ),
                                        ),
                                        CustomDivider(),
                                        InkWell(
                                          onTap: () {
                                            getWhatsappFunction(widget.modelBeautyProvider.username)();
                                          },
                                          child: InfoItem(
                                            icon: CommunityMaterialIcons.whatsapp,
                                            title: 'الجوال',
                                            value: widget.modelBeautyProvider.username.toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),

                          InkWell(
                            child: Icon(
                              CommunityMaterialIcons.heart_circle,
                              size: ScreenUtil().setSp(80),
                              color: AppColors.pinkBright,
                            ),
                            onTap: () async {
                              try {} catch (e) {}
                            },
                          ),
                          // new SizedBox(
                          //   height:
                          //       ScreenUtil().setHeight(ConstShopSizes.padding),
                          // ),

                          // new Divider(color: Colors.cyan.withOpacity(0.8)),
                          SizedBox(
                            height: _height / 15,
                          ),

                          // Container(
                          //   width: _width,
                          //   child: new ExtendedText(
                          //     string: "~  ${ConstShopStrings.myServices}  ~",
                          //     fontColor: AppColors.pinkBright,
                          //     fontSize: ExtendedText.bigFont,
                          //   ),
                          // ),
                          ExtendedText(
                            string: widget.modelBeautyProvider.intro,
                            fontSize: ExtendedText.bigFont,
                          ),

                          SizedBox(
                            height: ScreenUtil().setHeight(50),
                          )
                        ],
                      ),
                    ),
                    // ...getAllTest(widget.modelBeautyProvider, context),
                    SizedBox(
                      height: ScreenUtil().setHeight(150),
                    )
                  ]
                      // ..addAll(funGetAllSelectionRows(widget.modelBeautyProvider)),
                      ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.overlay,
                    child: Container(
                      color: Colors.transparent,
                      height: ScreenUtil().setHeight(ConstRootSizes.navigation),
                      width: ScreenResolution.width,
                    ),
                  ),
                ),
              ],
            ),
            extendBody: true,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        ),
      ],
    );
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
            textDirection: TextDirection.rtl,
          )
        ],
      ),
    );
  }
}
