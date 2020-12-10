import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

double edgePage = 15.w;
double edgeContainer = 10.w;
double edgeText = 12.w;

double heightBtn = 100.h;
double heightNavBar = 150.h;
double heightTopBar = 250.h;

double iconDefault = 50.sp;

double radiusDefault = 12;

class Y extends StatelessWidget {
  final height;
  const Y({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 15.h,
    );
  }
}
