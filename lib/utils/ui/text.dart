import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GWdgtTextTitle extends StatelessWidget {
  final TextDirection textDirection;
  final TextAlign textAlign;

  final Color fontColor = null;
  final String string;
  const GWdgtTextTitle(
      {Key key,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.rtl,
      @required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
        color: fontColor,
      ),
    );
  }
}

class GWdgtTextTitleDesc extends StatelessWidget {
  final String string;
  const GWdgtTextTitleDesc({Key key, @required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(14),
      ),
    );
  }
}

class GWdgtTextButton extends StatelessWidget {
  final String string;
  const GWdgtTextButton({Key key, @required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 40.sp,
      ),
    );
  }
}

class GWdgtTextToggle extends StatelessWidget {
  final String string;
  const GWdgtTextToggle({Key key, @required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
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
  final String string;
  const GWdgtTextProfile(
      {Key key,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.rtl,
      this.fontColor = brightColor,
      // this.fontSize,
      @required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(22),
        color: fontColor,
      ),
    );
  }
}

class GWdgtTextPickerSubmit extends StatelessWidget {
  final String string;
  const GWdgtTextPickerSubmit({Key key, @required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.blue),
    );
  }
}

class GWdgtTextPickerCancel extends StatelessWidget {
  final String string;
  const GWdgtTextPickerCancel({Key key, @required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.red),
    );
  }
}

class GWdgtTextChip extends StatelessWidget {
  final String string;
  const GWdgtTextChip({Key key, @required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.blue),
    );
  }
}

class GWdgtTextSmall extends StatelessWidget {
  final String string;
  final Color color;
  final TextAlign textAlign;
  final TextDirection textDirection;
  const GWdgtTextSmall(
      {Key key,
      @required this.string,
      this.color,
      this.textAlign,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(20),
        color: color,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}

class GWdgtTextCalendarDay extends StatelessWidget {
  final String string;
  final Color color;
  final TextAlign textAlign;
  final TextDirection textDirection;
  const GWdgtTextCalendarDay(
      {Key key,
      @required this.string,
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
      ),
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
    );
  }
}

class GWdgtTextBadge extends StatelessWidget {
  final String string;
  final Color color;
  final TextAlign textAlign;
  final TextDirection textDirection;
  const GWdgtTextBadge(
      {Key key,
      @required this.string,
      this.color,
      this.textAlign,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(20),
        color: color ?? Colors.white,
      ),
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
    );
  }
}
