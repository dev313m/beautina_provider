import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GWdgtTextTitle extends StatelessWidget {
  final TextDirection textDirection;
  final TextAlign textAlign;

  final Color fontColor = null;
  final String string;
  const GWdgtTextTitle({Key key, this.textAlign = TextAlign.center, this.textDirection = TextDirection.rtl, @required this.string})
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
        fontSize: ScreenUtil().setSp(14),
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
  final double fontSize;
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
      this.fontSize,
      @required this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(fontSize),
        color: fontColor,
      ),
    );
  }
}

class GWdgtTextPickerSubmit extends StatelessWidget {
  final String string;
  const GWdgtTextPickerSubmit({Key key, @required this.string}) : super(key: key);

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
  const GWdgtTextPickerCancel({Key key, @required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.red),
    );
  }
}
