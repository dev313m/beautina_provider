import 'dart:io';

import 'package:beautina_provider/constants/resolution.dart';
import 'package:beautina_provider/pages/root/constants.dart';
import 'package:beautina_provider/pages/signing_pages/constants.dart';
import 'package:beautina_provider/pages/signing_pages/function.dart';
import 'package:beautina_provider/pages/signing_pages/shared_variable.dart';
import 'package:beautina_provider/pages/signing_pages/ui.dart';
import 'package:beautina_provider/reusables/beauty_textfield.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/auth/apple_auth.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1496, allowFontScaling: true);

    return ChangeNotifierProvider(
      builder: (_) => SignInSharedVariable(),

      child: Index(),
      // builder: (context, _, child)=>Text(''),
    );
  }
}

class Index extends StatefulWidget {
  // final GlobalKey<State<StatefulWidget>> globalKey;
  // Index({this.globalKey});
  @override
  _IndexState createState() => new _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  // double screenWidth, screenHeight;
  bool loading = false;

  List<bool> accountTypeBool = [false, false];

  FlareController flareController;
  @override
  void initState() {
    super.initState();

    // flareController = new FlareController();
  }

//This widget shows A brief nice home intro for pages.

  final txtController = TextEditingController(text: '');

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    txtController.dispose();
    super.dispose();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // screenWidth = MediaQuery.of(context).size.width;
    // screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      top: false,
      child: Stack(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(580),
            child: FlareActor(
              "assets/rive/bg.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'Flow',
            ),
          ),
          Scaffold(
            key: _globalKey,
            backgroundColor: ConstLoginColors.backgroundColor,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(600),
                    child: Stack(
                      children: <Widget>[
                        // Align(
                        //     alignment: Alignment.bottomRight,
                        //     child: introWidget(
                        //         'Beauty', 'Order', screenWidth, screenHeight)),
                        Positioned(
                          right: 1,
                          bottom: ScreenUtil().setHeight(60),
                          child: Container(
                              width: ScreenUtil().setWidth(220),
                              height: ScreenUtil().setHeight(180),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: Text('Beautina',
                                        style: GoogleFonts.pacifico(
                                            fontSize: ExtendedText.xbigFont,
                                            fontWeight: FontWeight.bold,
                                            color: ExtendedText.colorFull)

                                        // TextStyle(
                                        //     fontSize: ExtendedText.xbigFont,
                                        //     fontWeight: FontWeight.bold,
                                        //     color: ExtendedText.colorFull)

                                        ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    // padding: EdgeInsets.fromLTRB(87.0, 50.0, 0.0, 0.0),
                                    child: Text(
                                      "      بيوتينا",
                                      style: TextStyle(
                                        fontFamily: ArabicFonts.Tajawal,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.pink,
                                        package: 'google_fonts_arabic',
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        FlareActor(
                          "assets/rive/goodone.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: 'Swing',
                        ),
                      ],
                    ),
                  ),
                  // Image.asset('assets/images/test.jpg'),
                  // SizedBox(
                  //   height: 100,
                  // ),

                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: BeautyTextfieldT(
                      enabled: true,
                      textStyle: TextStyle(
                          fontSize: ExtendedText.defaultFont,
                          color: ExtendedText.darkColor),
                      // fontWeight: 2,
                      // maxLength: 30,
                      onChanged: (text) {
                        saveName(context, text);
                      },
                      height: ScreenUtil()
                          .setHeight(ConstLoginSizes.nameTextHeight),
                      // textBaseline: TextBaseline.alphabetic,
                      inputType: TextInputType.text,
                      duration: Duration(seconds: 1),
                      prefixIcon: Icon(Icons.info_outline),
                      width: 0,
                      cornerRadius: BorderRadius.circular(25),
                      placeholder: ' الاسم',
                      wordSpacing: 2,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      TextHolder(
                        backgroundColor: ConstLoginColors.regionColor,
                        borderColor: ConstLoginColors.regionColor,
                        borderRadius: BorderRadius.circular(25),
                        function: () {
                          showPicker(context, _globalKey);
                        },
                        edgeInsetsGeometry:
                            EdgeInsets.symmetric(horizontal: 22),
                        height: ScreenUtil()
                            .setHeight(ConstLoginSizes.regionHeight),
                        iconWidget: Icon(
                          CommunityMaterialIcons.home_city_outline,
                          size: ScreenUtil().setSp(40),
                          color: ExtendedText.brightColor,
                        ),
                        textWidget: ExtendedText(
                          string: 'المنطقة',
                          fontSize: ExtendedText.bigFont,
                        ),
                        width: ScreenUtil().setWidth(688),
                      ),
                    ],
                  ),
                  isCityChosen(context)
                      ? CityWidget(
                          color: ConstLoginColors.city,
                          function: () {
                            showPicker(context, _globalKey);
                          },
                        )
                      : SizedBox(),

                  SizedBox(
                    height: ScreenUtil().setHeight(14),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: ScreenUtil().setHeight(100),
                        // width: ScreenUtil().setWidth(200),
                        color: Colors.blue.withOpacity(0.5),
                        child: ToggleButtons(
                          onPressed: (index) {
                            showAlert(context,
                                msg: 'لايمكنك تغيير نوع الحساب لاحقا',
                                dismiss: 'تم');
                            accountTypeBool = [false, false];
                            accountTypeBool[index] = true;
                            setState(() {});
                            // showToast(index.toString());
                            Provider.of<SignInSharedVariable>(context)
                                .accountType = index == 1 ? 1 : 0;
                          },

                          // color: Colors.blue,
                          // fillColor: Colors.blue,
                          color: Colors.blue.withOpacity(0.6),
                          fillColor: Colors.blue,

                          borderRadius: BorderRadius.circular(25),
                          children: <Widget>[
                            Container(
                                width: ScreenUtil().setWidth(340),
                                child: ExtendedText(
                                  string: 'هذا حساب مشغل',
                                  fontSize: ExtendedText.bigFont,
                                )),
                            Container(
                                width: ScreenUtil().setWidth(340),
                                child: ExtendedText(
                                  string: 'أنا خبيرة',
                                  fontSize: ExtendedText.bigFont,
                                )),
                          ],
                          isSelected: accountTypeBool,
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //   decoration: BoxDecoration(

                  //     color: Colors.white24
                  //   ),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Icon(
                  //         Icons.error_outline,
                  //         color: Colors.red,
                  //       ),
                  //       ExtendedText(
                  //           string:
                  //               'تأكدي من نوع الحساب (خبيرة او مشغل) لايمكن تغييره لاحقا',
                  //           fontSize: ExtendedText.xbigFont)
                  //     ],
                  //   ),
                  // ),

                  Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20)),
                      child: Column(
                        children: <Widget>[
                          if (Provider.of<SignInSharedVariable>(context)
                                  .phoneNum
                                  .length !=
                              9)
                            SizedBox()
                          else if (loading)
                            CircularProgressIndicator(
                              backgroundColor: Colors.orangeAccent,
                            )
                          else
                            Platform.isAndroid
                                ? InkWell(
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      try {
                                        await loginWithGoogle(context);
                                      } catch (e) {
                                        showToast(e.toString());
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Container(
                                        color: ConstLoginColors.google,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              ScreenUtil().setHeight(16)),
                                          child: Column(
                                            children: <Widget>[
                                              ExtendedText(
                                                string: 'التسجيل بواسطة جوجل',
                                                fontSize: ExtendedText.xbigFont,
                                              ),
                                              Icon(
                                                CommunityMaterialIcons.google,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            setState(() {
                                              loading = true;
                                            });
                                            try {
                                              await loginWithApple(context);
                                            } catch (e) {
                                              showToast(e.toString());
                                            }
                                            setState(() {
                                              loading = false;
                                            });
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              color: ConstLoginColors.apple,
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    ScreenUtil().setHeight(16)),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'التسجيل بواسطة ابل',
                                                      style: TextStyle(
                                                          // fontSize: 19,
                                                          color: Colors.white),
                                                    ),
                                                    Icon(
                                                      CommunityMaterialIcons
                                                          .apple,
                                                      color: Colors.white,
                                                      // size: 35,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '( يجب اضافة صلاحية دخول الايميل )',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10),
                                          // fontColor: Colors.white,
                                          // fontSize: ExtendedText.smallFont,
                                        ),
                                      ),
                                    ],
                                  ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          PhoneTextFieldUI(),
                        ],
                      )),

                  // Divider(
                  //   height: 30.0,
                  //   color: Colors.white,
                  //   endIndent: 20,
                  //   indent: 20,
                  // ),
                  // Visibility(
                  //   visible: Provider.of<SignInSharedVariable>(context).showCode,
                  //   child: Container(
                  //       padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  //       child: Column(
                  //         children: <Widget>[
                  //           CodeTextField(),
                  //           AnimatedSubmitButton(
                  //             animationDuration: Duration(seconds: 1),
                  //             color: Colors.green,
                  //             height: screenHeight / 10,
                  //             insideWidget: Text('تسجيل'),
                  //             splashColor: Colors.blue,
                  //             width: screenWidth / 1.2,
                  //             function: onConfirmCodeNumber(context),
                  //           )
                  //         ],
                  //       )),
                  // ),
                ],
              ),
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
    );
  }
}
