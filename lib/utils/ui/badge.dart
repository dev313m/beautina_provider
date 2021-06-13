import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GWdgtBadge extends StatelessWidget {
  final int number;
  const GWdgtBadge({Key key, this.number = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (number == 0) return SizedBox();
    return Container(
      height: 40.w,
      width: 40.w,
      child: CircleAvatar(
        backgroundColor: Colors.pink,
        child: Center(child: GWdgtTextBadge(string: number.toString())),
      ),
    );
  }
}
