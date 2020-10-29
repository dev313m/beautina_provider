import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/duration.dart';
import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/pages/dates/functions.dart';
import 'package:beautina_provider/pages/dates/index.dart';
import 'package:beautina_provider/pages/my_salon/beauty_provider_page/index.dart';
import 'package:beautina_provider/pages/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/pages/my_salon/ui_choose_service.dart';
import 'package:beautina_provider/pages/my_salon/ui_how_I_look.dart';
import 'package:beautina_provider/pages/packages/constants.dart';
import 'package:beautina_provider/pages/root/constants.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:spring_button/spring_button.dart';

class PagePackage extends StatefulWidget {
  const PagePackage({Key key}) : super(key: key);

  @override
  _PagePackageState createState() => _PagePackageState();
}

class _PagePackageState extends State<PagePackage> {
  bool showPay = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedSalon>(builder: (_, sharedSalon, child) {
      return Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            body: LayoutBuilder(builder: (context, constaint) {
              return ListView(
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(200),
                  ),
                  !checkPackage(sharedSalon.beautyProvider.package)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            color: Colors.white38,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                ExtendedText(
                                  string: 'انت مشترك في باقة اضافة التخفيضات',
                                  fontSize: ExtendedText.xbigFont,
                                ),
                                Icon(Icons.subtitles,
                                    size: ScreenUtil().setSp(200)),
                                ExtendedText(
                                  string:
                                      'ينتهي الاشتراك في: ${getDateString(DateTime.parse(sharedSalon.beautyProvider.package['01']['to']))}',
                                )
                              ],
                            ),
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: constaint.maxWidth,
                            height: ScreenUtil().setHeight(850),
                            color: Colors.white30,
                            child: Stack(
                              children: <Widget>[
                                FlareActor(
                                  'assets/rive/night.flr',
                                  fit: BoxFit.fitWidth,
                                  animation: 'idle',
                                ),
                                Column(
                                  children: <Widget>[
                                    // FlareActor(
                                    //   'assets/rive/night.flr',
                                    //   fit: BoxFit.fitWidth,
                                    // ),
                                    Container(
                                      child: Center(
                                          child: ExtendedText(
                                        string: 'باقة اضافة الخصومات',
                                        fontSize: ScreenUtil().setSp(40),
                                      )),
                                    ),
                                    // Container(
                                    //     width: ScreenUtil().setWidth(200),
                                    //     child: Image.asset(
                                    //       'assets/images/gift.png',
                                    //     )),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(300),
                                    ),
                                    // Icon(
                                    //   CommunityMaterialIcons.gift,
                                    //   size: ScreenUtil().setSp(300),
                                    //   color: Colors.pinkAccent,
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(8)),
                                      child: Wrap(
                                        children: <Widget>[
                                          ExtendedText(
                                            string: PackageStr.aboutPackage,
                                            fontSize: ScreenUtil().setSp(30),
                                            textAlign: TextAlign.right,
                                            fontColor: Colors.white38,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: ScreenUtil().setHeight(50),
                                      color: Colors.white60,
                                      endIndent: ScreenUtil().setWidth(200),
                                      indent: ScreenUtil().setWidth(200),
                                    ),

                                    WidgetHowLook(),

                                    Divider(
                                      height: ScreenUtil().setHeight(50),
                                      color: Colors.white60,
                                      endIndent: ScreenUtil().setWidth(200),
                                      indent: ScreenUtil().setWidth(200),
                                    ),

                                    Center(
                                      child: Container(
                                        height: ScreenUtil().setHeight(90),
                                        width: ScreenUtil().setWidth(700),
                                        child: SpringButton(
                                          SpringButtonType.OnlyScale,
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: Ink(
                                              // width: 200,
                                              child: Material(
                                                color: AppColors.blue,
                                                child: Center(
                                                    child: ExtendedText(
                                                  string: 'تفعيل 99\$ دولار',
                                                  fontSize:
                                                      ExtendedText.bigFont,
                                                )),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            showPay = true;
                                            setState(() {});
                                          },
                                          scaleCoefficient: 0.9,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                AnimatedSwitcher(
                                    duration: Duration(
                                        milliseconds: durationCalender),
                                    child: showPay ? WidgetPay() : SizedBox())
                              ],
                            ),
                          ),
                        ),
                ],
              );
            }),
          ),
        ],
      );
    });
  }
}

class WidgetPay extends StatefulWidget {
  const WidgetPay({
    Key key,
  }) : super(key: key);

  @override
  _WidgetPayState createState() => _WidgetPayState();
}

class _WidgetPayState extends State<WidgetPay> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;
  RoundedLoadingButtonController _roundedLoadingButtonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Column(children: <Widget>[
              Container(
                child: CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView:
                      showBackView, //true when you want to show cvv(back) view
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      RoundedLoadingButton(
                        animateOnTap: false,
                        child: ExtendedText(
                          string: 'دفع',
                          fontSize: ExtendedText.bigFont,
                        ),
                        controller: _roundedLoadingButtonController,
                        onPressed: () {},
                        // color: C,
                      )
                    ],
                  ),
                ),
              ),
            ])));
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }
}

class WidgetHowLook extends StatelessWidget {
  const WidgetHowLook({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
              height: ScreenUtil().setHeight(90),
              width: ScreenUtil().setHeight(260),
              child: SpringButton(
                SpringButtonType.OnlyScale,
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Ink(
                    // width: 200,
                    child: Material(
                      color: AppColors.pinkBright.withOpacity(0.4),
                      child: Center(
                          child: ExtendedText(
                        string: 'صفحتي في البحث بعد تفعيل الباقة',
                        fontSize: ExtendedText.bigFont,
                      )),
                    ),
                  ),
                ),
                onTap: () {
                  ModelBeautyProvider modelBeautyProvider =
                      Provider.of<SharedSalon>(context).beautyProvider;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PageHowILookSearch(
                              beautyProvider: modelBeautyProvider,
                            )),
                  );
                },
                scaleCoefficient: 0.9,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Expanded(
          child: Center(
            child: Container(
              height: ScreenUtil().setHeight(90),
              width: ScreenUtil().setHeight(260),
              child: SpringButton(
                SpringButtonType.OnlyScale,
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Ink(
                    // width: 200,
                    child: Material(
                      color: AppColors.pinkBright.withOpacity(0.4),
                      child: Center(
                          child: ExtendedText(
                        string: 'صفحتي بعد تفعيل الباقة',
                        fontSize: ExtendedText.bigFont,
                      )),
                    ),
                  ),
                ),
                onTap: () {
                  ModelBeautyProvider modelBeautyProvider =
                      Provider.of<SharedSalon>(context).beautyProvider;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BeautyProviderPage(
                              modelBeautyProvider: modelBeautyProvider,
                              withHero: false,
                            )),
                  );
                },
                scaleCoefficient: 0.9,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
