import 'package:beauty_order_provider/constants/app_colors.dart';
import 'package:beauty_order_provider/reusables/text.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showAddNewService(BuildContext context) {
  List<String> list = ['accountNames', 'good', 'hair', 'etc', 'test'];
  String test = 'test';
  Alert(
      context: context,
      // style: alertStyle,
      title: "  ",
      content: Column(
        children: <Widget>[
          DropDownField(
              value: test,
              required: true,
              strict: true,
              enabled: true,
              itemsVisibleInDropdown: 4,
              labelText: 'Account Name *',
              // icon: Icon(Icons.account_balance),
              items: list,
              setter: (dynamic newValue) {
                test = newValue;
              }),
          DropDownField(
              value: test,
              required: true,
              strict: true,
              enabled: true,
              itemsVisibleInDropdown: 4,
              labelText: 'Account Name *',
              // icon: Icon(Icons.account_balance),
              items: list,
              setter: (dynamic newValue) {
                test = newValue;
              })
        ],
      ),
      buttons: [
        DialogButton(
          width: ScreenUtil().setWidth(150),
          onPressed: () {},
          color: AppColors.blue,
          child: ExtendedText(
            string: "تحديث",
            fontSize: ExtendedText.bigFont,
          ),
        )
      ]).show();
}
