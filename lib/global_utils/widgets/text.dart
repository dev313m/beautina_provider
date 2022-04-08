import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalWidgetText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? style;
  static final TextStyle textStyleBigFontBlack = TextStyle(
    color: Colors.black,
    fontSize: 60.sp,
  );

  static final TextStyle textStyleMediumFontBlack = TextStyle(
    color: Colors.black,
    fontSize: 40.sp,
  );

  static final TextStyle textStyleSmallFontBlack = TextStyle(
    color: Colors.black,
    fontSize: 30.sp,
  );

  static final TextStyle textStyleBigFontWhite = TextStyle(
    color: Colors.white,
    fontSize: 60.sp,
  );

  static final TextStyle textStyleMediumFontWhite = TextStyle(
    color: Colors.white,
    fontSize: 35.sp,
  );

  static TextStyle textStyleSmallFontWhite = TextStyle(
    color: Colors.white.withOpacity(0.6),
    fontSize: 30.sp,
  );
  const GlobalWidgetText(this.text,
      {Key? key, this.color, this.style, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style == null ? textStyleMediumFontWhite : style,
      textAlign: textAlign,
    );
  }
}
