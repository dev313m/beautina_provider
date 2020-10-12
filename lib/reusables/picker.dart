import 'dart:convert';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

cityPicker({@required Function onConfirm, @required BuildContext context}) {
  FocusScope.of(context).requestFocus(new FocusNode());

  Picker picker = Picker(
      adapter: PickerDataAdapter<String>(isArray: false, pickerdata: JsonDecoder().convert(Countries.countriesList)),
      changeToFirst: true,
      // cancel: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Icon(Icons.cancel, color: Colors.red),
      // ),
      cancelText: 'عودة',
      confirmText: 'تأكيد',
      containerColor: AppColors.pinkBright,
      backgroundColor: Colors.transparent,
      headercolor: AppColors.pinkBright,
      // confirm: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Icon(CommunityMaterialIcons.check_circle_outline,
      //       color: Colors.blue),
      // ),
      textAlign: TextAlign.left,
      textStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        package: 'google_fonts_arabic',
      ),
      cancelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        package: 'google_fonts_arabic',
      ),
      selectedTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        package: 'google_fonts_arabic',
      ),
      confirmTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        package: 'google_fonts_arabic',
      ),
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) async {
        await onConfirm(picker, value);
      });
  picker.showModal(context);
}
