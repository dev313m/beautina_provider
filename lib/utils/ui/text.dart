import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GWdgtTextNavTitle extends StatelessWidget {
  final TextDirection textDirection;
  final TextAlign textAlign;

  final String string;
  const GWdgtTextNavTitle(
      {Key? key,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.rtl,
      required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: 55.sp,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.w600,
         color: Colors.white,
      ),
    );
  }
}

class GWdgtTextTitle extends StatelessWidget {
  final TextDirection textDirection;
  final TextAlign textAlign;
  final Color? color;
  final String? string;
  const GWdgtTextTitle(
      {Key? key,
      this.textAlign = TextAlign.center,
      this.color = Colors.white,
      this.textDirection = TextDirection.rtl,
      required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string!,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: 45.sp,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.w600,
         color: color ?? Colors.white,
      ),
    );
  }
}

class GWdgtTextTitleDesc extends StatelessWidget {
  final String? string;
  final TextAlign? textAlign;
  final Color? color;
  const GWdgtTextTitleDesc(
      {Key? key, required this.string, this.textAlign, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string!,
      textAlign: textAlign ?? TextAlign.center,
      textDirection: TextDirection.rtl,
      style: TextStyle(
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
         fontSize: 38.sp,
        color: color ?? Colors.white60,
      ),
    );
  }
}

class GWdgtTextDescDesc extends StatelessWidget {
  final String? string;
  final TextAlign? textAlgin;
  final Color? color;
  const GWdgtTextDescDesc(
      {Key? key, required this.string, this.textAlgin, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string!,
      textAlign: textAlgin ?? TextAlign.center,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: 35.sp,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
         color: color ?? Colors.white70,
      ),
    );
  }
}

class GWdgtTextButton extends StatelessWidget {
  final String string;
  final Color? color;
  const GWdgtTextButton({Key? key, required this.string, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 34.sp,
        color: color ?? Colors.white70,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.w500,
       ),
    );
  }
}

class GWdgtTextToggle extends StatelessWidget {
  final String? string;
  const GWdgtTextToggle({Key? key, required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        string!,
        style: TextStyle(
          fontSize: 29.sp,
          color: Colors.white.withOpacity(0.7),
              fontFamily: 'Tajawal',
          fontWeight: FontWeight.normal,
           ),
      ),
    );
  }
}

class GWdgtTextProfile extends StatelessWidget {
  // final double fontSize;
  static final double xxbigFont = 30;

  final TextDirection textDirection;
  final TextAlign textAlign;
  static const brightColor = Colors.white;
  static Color brightColors2 = Colors.white.withOpacity(0.8);
  static const darkColor = Color(0xff37474f);
  static final colorFull = Colors.pink;
  final Color fontColor;
  final String? string;
  const GWdgtTextProfile(
      {Key? key,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.rtl,
      this.fontColor = brightColor,
      // this.fontSize,
      required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string!,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(26),
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
         color: fontColor.withOpacity(0.6),
      ),
    );
  }
}

class GWdgtTextPickerSubmit extends StatelessWidget {
  final String string;
  const GWdgtTextPickerSubmit({Key? key, required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
        color: Colors.blue,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
       ),
    );
  }
}

class GWdgtTextPickerCancel extends StatelessWidget {
  final String string;
  const GWdgtTextPickerCancel({Key? key, required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
        color: Colors.red,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
       ),
    );
  }
}

class GWdgtTextChip extends StatelessWidget {
  final String? string;
  const GWdgtTextChip({Key? key, required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string!,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(26),
        color: Colors.white70,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
       ),
    );
  }
}

class GWdgtTextSmall extends StatelessWidget {
  final String string;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  const GWdgtTextSmall(
      {Key? key,
      required this.string,
      this.color,
      this.textAlign,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(25),
        color: color ?? Colors.white70,
        fontWeight: FontWeight.normal,
            fontFamily: 'Tajawal',
       ),
      textAlign: textAlign ?? TextAlign.center,
      textDirection: textDirection ?? TextDirection.rtl,
    );
  }
}

class GWdgtTextCalendarDay extends StatelessWidget {
  final String string;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  const GWdgtTextCalendarDay(
      {Key? key,
      required this.string,
      this.color,
      this.textAlign,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(24),
        color: color ?? Colors.white38,
        fontWeight: FontWeight.normal,
            fontFamily: 'Tajawal',
       ),
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
    );
  }
}

class GWdgtTextBadge extends StatelessWidget {
  final String string;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  const GWdgtTextBadge(
      {Key? key,
      required this.string,
      this.color,
      this.textAlign,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(24),
        color: color ?? Colors.white,
            fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
       ),
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
    );
  }
}

class GWdgtTextPickerChoices extends StatelessWidget {
  final String string;
  final TextAlign? textAlign;
  const GWdgtTextPickerChoices({Key? key, required this.string, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: textAlign ?? TextAlign.center,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: 34.sp,
        fontWeight: FontWeight.normal,
            fontFamily: 'Tajawal',
         color: Colors.blue,
      ),
    );
  }
}
