import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  // final type;
  const CustomDivider({Key key, this.color = Colors.white, this.height = 29, this.width = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
      border: Border(
        top: BorderSide(width: height, color: color),
        // left: BorderSide(wid÷th: 1.0, color: Colors.grey),
        right: BorderSide(width: width, color: color),
        bottom: BorderSide(width: height, color: color),
      ),
    ));
  }
}
