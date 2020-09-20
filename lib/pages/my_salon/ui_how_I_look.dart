import 'dart:math';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_bar/rating_bar.dart';

class PageHowILookSearch extends StatelessWidget {
  final ModelBeautyProvider beautyProvider;
  const PageHowILookSearch({Key key, this.beautyProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(300),
        ),
        // SizedBox(height: ScreenUtil().setHeight(350)),
        // RoundWithCircleContainer(
        //   desc: 'any',
        //   modelBeautyProvider: beautyProvider,
        // ),
        RoundWithCircleContainerNoOffer(
          desc: 'any',
          modelBeautyProvider: beautyProvider,
        ),
      ],
    );
  }
}

class RoundWithCircleContainer extends StatefulWidget {
  final String name;
  final String desc;
  final int star;
  final String img;
  final String price;
  final String beforePrice;
  final ModelBeautyProvider modelBeautyProvider;
  // final DocumentSnapshot snapshot;

  RoundWithCircleContainer(
      {@required this.desc,
      this.img,
      this.name,
      this.star,
      this.price,
      this.beforePrice,
      this.modelBeautyProvider});

  @override
  _RoundWithCircleContainerState createState() =>
      _RoundWithCircleContainerState();
}

class _RoundWithCircleContainerState extends State<RoundWithCircleContainer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Ink(
                decoration: BoxDecoration(
                    color: ConstSalonColors.beautyContainer,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: ConstSalonColors.beautyBorder),
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: ConstSalonColors.beautyContainer,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(0.0), //
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => BeautyProviderPage(
                      //           modelBeautyProvider:
                      //               widget.modelBeautyProvider),
                      //       maintainState: false),
                      // );
                      // Navigator.of(context).push(
                      //   FadeRoute(

                      //       page: OrderPage(
                      //     snapshot: widget.snapshot,
                      //   )),
                      // );
                    },
                    highlightColor: Colors.transparent,
                    borderRadius: new BorderRadius.circular(25),
                    splashColor: Colors.pink,
                    child: Container(
                      height: ScreenUtil().setHeight(
                          ConstSalonSizes.containerTotalHeight + 100),
                      constraints: BoxConstraints(
                          // minHeight: ScreenUtil().setHeight(500),
                          maxHeight: ScreenUtil()
                              .setHeight(ConstSalonSizes.containerTotalHeight)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              ExtendedText(
                                string: '~${widget.modelBeautyProvider.name}~',
                                // fontColor: Colors.pink,
                                fontSize: ExtendedText.defaultFont,
                                // overflow: TextOverflow.fade,
                                // style: TextStyle(
                                //     fontSize: ScreenUtil().setSp(20),
                                //     color: Colors.pink,
                                //     fontFamily: 'Tajawal'),
                              ),
                              SizedBox(height: 4),
                              Center(
                                child: Container(
                                    height: ScreenUtil()
                                        .setHeight(ConstSalonSizes.imageHeight),
                                    width: ScreenUtil()
                                        .setHeight(ConstSalonSizes.imageHeight),
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              color: AppColors.purpleColor,
                                              spreadRadius: 5),
                                          BoxShadow(
                                              blurRadius: 20,
                                              color:
                                                  ConstSalonColors.beautyImage,
                                              spreadRadius: 0.005)
                                        ],
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new NetworkImage(
                                              'https://resorthome.000webhostapp.com/upload/${widget.modelBeautyProvider.uid}.jpg',
                                            )))),
                              ),
                              ExtendedText(
                                  string: widget.modelBeautyProvider.type
                                              .toString() ==
                                          '0'
                                      ? ConstSalonStrings.typeExpert
                                      : ConstSalonStrings.typeSalon,
                                  fontColor: Colors.pink,
                                  fontSize: ExtendedText.xbigFont),
                              Center(
                                child: ExtendedText(
                                  string: widget.modelBeautyProvider.voter < 100
                                      ? 'اقل من 100 طلب'
                                      : 'اكثر من ${widget.modelBeautyProvider.voter % 100} طلب',
                                ),
                              ),
                              Center(
                                child: RatingBar.readOnly(
                                  size: ScreenUtil()
                                      .setHeight(ConstSalonSizes.star),
                                  initialRating:
                                      widget.modelBeautyProvider.rating /
                                          widget.modelBeautyProvider.voter,
                                  maxRating: 5,
                                  emptyIcon:
                                      CommunityMaterialIcons.heart_outline,
                                  filledIcon: CommunityMaterialIcons.heart,
                                  halfFilledIcon:
                                      CommunityMaterialIcons.heart_half,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Visibility(
                                        visible: true, child: SizedBox()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(22),
                                            right: ScreenUtil().setWidth(22)),
                                        child: ExtendedText(
                                          string:
                                              widget.modelBeautyProvider.intro,
                                          fontSize: ExtendedText.bigFont,
                                          // overflow: TextOverflow
                                          //     .fade, // it wont aloow the the text to go in a new line
                                          // style: TextStyle(
                                          //     fontSize: ScreenUtil().setSp(20),
                                          //     fontFamily: 'Tajawal'),
                                          // textDirection: TextDirection.rtl,
                                          // textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // widget.modelBeautyProvider.price != 0 &&
                          //         widget.modelBeautyProvider.beforePrice == 0
                          //     ?

                          Positioned(
                            left: -40,
                            top: 10,
                            child: Transform.rotate(
                              angle: pi * -0.27,
                              child: Container(
                                width: 120,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${444}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                      // RichText(
                                      //   text: TextSpan(
                                      //       text: 'عرض خاص',
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.bold),
                                      //       children: [
                                      //         TextSpan(
                                      //             text: '\n${widget.price} ',
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                     FontWeight.bold))
                                      //       ]),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // : SizedBox(),
                          // widget.modelBeautyProvider.price != 0 &&
                          //         widget.modelBeautyProvider.beforePrice != 0
                          //     ?

                          Positioned(
                            left: -40,
                            top: 10,
                            child: Transform.rotate(
                              angle: pi * -0.27,
                              child: Container(
                                width: 120,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${333} SR',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // : SizedBox(),
                          // widget.modelBeautyProvider.beforePrice != 0 &&
                          //         widget.modelBeautyProvider.price != 0
                          //     ?

                          Positioned(
                            left: -105,
                            top: 44,
                            child: Transform.rotate(
                              angle: pi * -0.27,
                              child: Container(
                                width: 300,
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        CommunityMaterialIcons.emoticon_kiss,
                                        color: Colors.white,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text:
                                                ConstSalonStrings.offerSpecial,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                            children: [
                                              TextSpan(
                                                  text: '\n${400} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          // : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RoundWithCircleContainerNoOffer extends StatefulWidget {
  final String name;
  final String desc;
  final int star;
  final String img;
  final String price;
  final String beforePrice;
  final ModelBeautyProvider modelBeautyProvider;
  // final DocumentSnapshot snapshot;

  RoundWithCircleContainerNoOffer(
      {@required this.desc,
      this.img,
      this.name,
      this.star,
      this.price,
      this.beforePrice,
      this.modelBeautyProvider});

  @override
  _RoundWithCircleContainerStateN createState() =>
      _RoundWithCircleContainerStateN();
}

class _RoundWithCircleContainerStateN
    extends State<RoundWithCircleContainerNoOffer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Ink(
                decoration: BoxDecoration(
                    color: ConstSalonColors.beautyContainer,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: ConstSalonColors.beautyBorder),
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: ConstSalonColors.beautyContainer,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(0.0), //
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => BeautyProviderPage(
                      //           modelBeautyProvider:
                      //               widget.modelBeautyProvider),
                      //       maintainState: false),
                      // );
                      // Navigator.of(context).push(
                      //   FadeRoute(

                      //       page: OrderPage(
                      //     snapshot: widget.snapshot,
                      //   )),
                      // );
                    },
                    highlightColor: Colors.transparent,
                    borderRadius: new BorderRadius.circular(25),
                    splashColor: Colors.pink,
                    child: Container(
                      height: ScreenUtil().setHeight(
                          ConstSalonSizes.containerTotalHeight + 100),
                      constraints: BoxConstraints(
                          // minHeight: ScreenUtil().setHeight(500),
                          maxHeight: ScreenUtil()
                              .setHeight(ConstSalonSizes.containerTotalHeight)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              ExtendedText(
                                string: '~${widget.modelBeautyProvider.name}~',
                                // fontColor: Colors.pink,
                                fontSize: ExtendedText.defaultFont,
                                // overflow: TextOverflow.fade,
                                // style: TextStyle(
                                //     fontSize: ScreenUtil().setSp(20),
                                //     color: Colors.pink,
                                //     fontFamily: 'Tajawal'),
                              ),
                              SizedBox(height: 4),
                              Center(
                                child: Container(
                                    height: ScreenUtil()
                                        .setHeight(ConstSalonSizes.imageHeight),
                                    width: ScreenUtil()
                                        .setHeight(ConstSalonSizes.imageHeight),
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              color: AppColors.purpleColor,
                                              spreadRadius: 5),
                                          BoxShadow(
                                              blurRadius: 20,
                                              color:
                                                  ConstSalonColors.beautyImage,
                                              spreadRadius: 0.005)
                                        ],
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              'https://resorthome.000webhostapp.com/upload/${widget.modelBeautyProvider.uid}.jpg',
                                            )))),
                              ),
                              ExtendedText(
                                  string: widget.modelBeautyProvider.type
                                              .toString() ==
                                          '0'
                                      ? ConstSalonStrings.typeExpert
                                      : ConstSalonStrings.typeSalon,
                                  fontColor: Colors.pink,
                                  fontSize: ExtendedText.xbigFont),
                              Center(
                                child: ExtendedText(
                                  string: widget.modelBeautyProvider.voter < 100
                                      ? 'اقل من 100 طلب'
                                      : 'اكثر من ${widget.modelBeautyProvider.voter % 100} طلب',
                                ),
                              ),
                              Center(
                                child: RatingBar.readOnly(
                                  size: ScreenUtil()
                                      .setHeight(ConstSalonSizes.star),
                                  initialRating:
                                      widget.modelBeautyProvider.rating /
                                          widget.modelBeautyProvider.voter,
                                  maxRating: 5,
                                  emptyIcon:
                                      CommunityMaterialIcons.heart_outline,
                                  filledIcon: CommunityMaterialIcons.heart,
                                  halfFilledIcon:
                                      CommunityMaterialIcons.heart_half,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Visibility(
                                        visible: true, child: SizedBox()),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(22),
                                            right: ScreenUtil().setWidth(22)),
                                        child: ExtendedText(
                                          string:
                                              widget.modelBeautyProvider.intro,
                                          fontSize: ExtendedText.bigFont,
                                          // overflow: TextOverflow
                                          //     .fade, // it wont aloow the the text to go in a new line
                                          // style: TextStyle(
                                          //     fontSize: ScreenUtil().setSp(20),
                                          //     fontFamily: 'Tajawal'),
                                          // textDirection: TextDirection.rtl,
                                          // textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // widget.modelBeautyProvider.price != 0 &&
                          //         widget.modelBeautyProvider.beforePrice == 0
                          //     ?

                          Positioned(
                            left: -40,
                            top: 10,
                            child: Transform.rotate(
                              angle: pi * -0.27,
                              child: Container(
                                width: 120,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${444}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                      // RichText(
                                      //   text: TextSpan(
                                      //       text: 'عرض خاص',
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.bold),
                                      //       children: [
                                      //         TextSpan(
                                      //             text: '\n${widget.price} ',
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                     FontWeight.bold))
                                      //       ]),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // : SizedBox(),
                          // widget.modelBeautyProvider.price != 0 &&
                          //         widget.modelBeautyProvider.beforePrice != 0
                          //     ?

                          Positioned(
                            left: -40,
                            top: 10,
                            child: Transform.rotate(
                              angle: pi * -0.27,
                              child: Container(
                                width: 120,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${333} SR',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          // decoration:
                                          //     TextDecoration.lineThrough
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // : SizedBox(),
                          // widget.modelBeautyProvider.beforePrice != 0 &&
                          //         widget.modelBeautyProvider.price != 0
                          //     ?

                          // Positioned(
                          //   left: -105,
                          //   top: 44,
                          //   child: Transform.rotate(
                          //     angle: pi * -0.27,
                          //     child: Container(
                          //       width: 300,
                          //       color: Colors.red,
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: <Widget>[
                          //             Icon(
                          //               CommunityMaterialIcons.emoticon_kiss,
                          //               color: Colors.white,
                          //             ),
                          //             RichText(
                          //               text: TextSpan(
                          //                   text:
                          //                       ConstSalonStrings.offerSpecial,
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.bold,
                          //                       fontSize: 10),
                          //                   children: [
                          //                     TextSpan(
                          //                         text: '\n${400} ',
                          //                         style: TextStyle(
                          //                             fontWeight:
                          //                                 FontWeight.bold))
                          //                   ]),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                          // : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConstSalonColors {
  static Color search = Colors.purple;
  static Color title = Colors.pink;
  static Color optionContainer = Colors.black26;
  static Color optionBorder = Colors.purple;
  static Color option = Colors.purple; //one item
  static Color apple = Colors.orangeAccent;
  static Color city = Colors.pink;
  static Color beautyContainer = AppColors.purpleColor.withOpacity(0.9);
  static Color beautyBorder = Colors.transparent;
  static Color beautyImage = Colors.transparent;
}

//sizes
class ConstSalonSizes {
  /// search
  static final searchPadding = 44;

  //options container
  static final optionsTitle = 150;
  static const optionsHeight = 400;

  static final optionsIntroImage = 120;
  static final optionsItems = 110;
  // static final

  //container beauty
  static final containerTotalHeight = 420;
  static final imageHeight = 150;
  static final star = 20;

  // region
  static final regionHeight = 100;
}
//Strings

class ConstSalonStrings {
  static final salonServices = 'خدمات الصالون';
  static final offerSpecial = 'عروض خاصة';
  static final search = 'ابحث';
  static final typeExpert = 'خبيرة';
  static final typeSalon = 'مشغل';
  static final typeAll = 'الكل';

  static final optionMoreOrder = 'الأكثر طلبا';
  static final optionLowPrice = 'الأقل سعرا';
}

final raduis = 15;
