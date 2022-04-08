import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExtendedText extends StatelessWidget {
  final double fontSize;
  static final double xxbigFont = 30;

  static final double xbigFont = 25;

  static final double bigFont = 19;

  static const double defaultFont = 14;
  static final double smallFont = 12;
  static final double xSmallFont = 9;
  static final double xXsmallFont = 6;
  final TextDirection textDirection;
  final TextAlign textAlign;
  static const brightColor = Colors.white;
  static Color brightColors2 = Colors.white.withOpacity(0.8);
  static const darkColor = Color(0xff37474f);
  static final colorFull = Colors.pink;
  final Color fontColor;
  final String? string;
  const ExtendedText({Key? key, this.textAlign = TextAlign.center, this.textDirection = TextDirection.rtl, this.fontColor = brightColor, this.fontSize = defaultFont, required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string!,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(fontSize),
        color: fontColor,
      ),
    );
  }
}
