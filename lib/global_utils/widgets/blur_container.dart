import 'dart:ui';

import 'package:flutter/material.dart';

class GlobalWidgetBlurContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final double opcity;
  final double borderRadius;
  final AlignmentGeometry alignment;
  final double blurLevel;
  final Widget child;
  const GlobalWidgetBlurContainer(
      {Key key,
      this.alignment,
      this.borderRadius = 15,
      this.opcity = 0.15,
      this.width,
      this.backgroundColor = Colors.white,
      this.blurLevel = 8,
      this.child,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor.withOpacity(opcity),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurLevel, sigmaY: blurLevel),
            child: child == null ? SizedBox() : child),
      ),
    );
  }
}
