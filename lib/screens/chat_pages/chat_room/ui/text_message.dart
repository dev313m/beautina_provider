
import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/chat/message.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final ModelMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 40.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(!message.fromProvider ? 1 : 0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(message.fromProvider ? 25 : 0),
          topRight: Radius.circular(!message.fromProvider ? 25 : 0),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: GWdgtTextTitleDesc(
        string:message.message,
        maxLine: 10,
        color: !message.fromProvider
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
      ),
    );
  }
}
