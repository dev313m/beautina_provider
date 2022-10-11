import 'package:beautina_provider/reusables/text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

///[size]
double sizeContainer = 1000.h;
double sizeY = 190.h;
double sizeBeautinaHeight = 400.h;
double sizeBeautinaWidth = 180.h;

class WdgtLoginFlare extends StatelessWidget {
  const WdgtLoginFlare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeContainer,
      child: Stack(
        children: <Widget>[
          // Align(
          //     alignment: Alignment.bottomRight,
          //     child: introWidget(
          //         'Beauty', 'Order', screenWidth, screenHeight)),
          Positioned(
            right: 60.w,
            bottom: sizeY,
            child: Container(
                width: sizeBeautinaHeight,
                height: sizeBeautinaWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                        "اناواو",
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 60.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.pink,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      // padding: EdgeInsets.fromLTRB(87.0, 50.0, 0.0, 0.0),
                      child: Text(
                        "صالونك الالكتروني",
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.pink,
                        ),
                        textAlign: TextAlign.end,
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
