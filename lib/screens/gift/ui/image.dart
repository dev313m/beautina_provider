import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class GWdgtGift50 extends StatefulWidget {
  const GWdgtGift50({Key key}) : super(key: key);

  @override
  _GWdgtGift50State createState() => _GWdgtGift50State();
}

class _GWdgtGift50State extends State<GWdgtGift50> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.h,
      child: Image.asset(
        'assets/images/50.png',
        // height: 800.h,
        width: double.infinity,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
