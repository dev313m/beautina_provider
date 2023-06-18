import 'dart:convert';

import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';

cityPicker({required Function onConfirm, required BuildContext context}) {
  FocusScope.of(context).requestFocus(new FocusNode());

  Picker picker = Picker(
      smooth: 3,
      adapter: PickerDataAdapter<String>(
          isArray: false,
          pickerData: JsonDecoder().convert(Countries.countriesList)),
      changeToFirst: true,
      // cancel: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Icon(Icons.cancel, color: Colors.red),
      // ),
      headerColor: AppColors.purpleColor,
      cancelText: 'عودة',
      confirmText: 'تأكيد',
      containerColor: AppColors.purpleColor,
      backgroundColor: AppColors.purpleColor,

      // confirm: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Icon(CommunityMaterialIcons.check_circle_outline,
      //       color: Colors.blue),
      // ),
      textAlign: TextAlign.left,
      textStyle: const TextStyle(
        color: Colors.white54,
        fontWeight: FontWeight.w600,
        fontFamily: 'Tajawal',
      ),
      cancel: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      // confirm: IconButton(
      //   icon: Icon(
      //     CupertinoIcons.back,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     Get.back();
      //   },
      // ),
      cancelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontFamily: 'Tajawal',
      ),
      selectedTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Tajawal',
      ),
      confirmTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Tajawal',
      ),
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) async {
        await onConfirm(picker, value);
      });
  picker.showModal(
    context,
    builder: (_, wid) => Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        child: wid,
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    backgroundColor: Colors.black,
    isScrollControlled: true,
  );
}
