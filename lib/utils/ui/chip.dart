import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GWdgtChip extends StatelessWidget {
  final Function function;
  final Color color;
  const GWdgtChip({Key key, this.function, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
              onTap: () {
                function();
              },
              child: Chip(
                label: ExtendedText(string: getCountry(context)),
                backgroundColor: AppColors.pinkBright,
                labelStyle: TextStyle(color: ExtendedText.brightColor),
              )),
          SizedBox(
            width: ScreenUtil().setWidth(8),
          ),
          InkWell(
              onTap: () {
                function();
              },
              child: Chip(
                label: ExtendedText(string: getCity(context)),
                backgroundColor: color,
              )),
          SizedBox(
            width: ScreenUtil().setWidth(8),
          ),
        ],
      ),
    );
  }
}