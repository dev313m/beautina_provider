import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///This represents the heights inside the sizedBox
class BoxHeight {
  ///Space btw containers
  static final double heightBtwContainers = 10.h;

  ///Space above submit button
  static final double heightBtwSubmitButton = 15.h;

  ///Space before and after title
  static final double heightBtwTitle = 20.h;

  ///Space to handle after main and categories
  static final double widthBtwTitle = 10.w;
}

/// This widget puts verticval box for spacing purpuses
class Y extends StatelessWidget {
  final height;
  const Y({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? BoxHeight.heightBtwContainers,
    );
  }
}

/// This widget puts verticval box for spacing purpuses
class GWdgtSizedBoxX extends StatelessWidget {
  final width;
  const GWdgtSizedBoxX({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
