import 'package:beautina_provider/reusables/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts_arabic/fonts.dart';

class WdgtLoginFlare extends StatelessWidget {
  const WdgtLoginFlare({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
