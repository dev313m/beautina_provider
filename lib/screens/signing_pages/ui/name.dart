import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:flutter/material.dart';

class WdgtLoginName extends StatelessWidget {
  const WdgtLoginName({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BeautyTextfield(
        enabled: true,
        textStyle: TextStyle(
            fontSize: ExtendedText.defaultFont, color: ExtendedText.darkColor),
        // fontWeight: 2,
        // maxLength: 30,
        onChanged: (text) {
          saveName(context, text);
        },
        // height: ScreenUtil().setHeight(ConstLoginSizes.nameTextHeight),
        // textBaseline: TextBaseline.alphabetic,
        inputType: TextInputType.text,
        duration: Duration(seconds: 1),
        prefixIcon: Icon(Icons.info_outline),
        // width: 0,
        // cornerRadius: BorderRadius.circular(12),
        helperText: ' الاسم',
        // wordSpacing: 2,
      ),
    );
  }
}
