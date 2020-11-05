import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/screens/signing_pages/function.dart';
import 'package:beautina_provider/screens/signing_pages/shared_variable.dart';
import 'package:beautina_provider/reusables/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:provider/provider.dart';

AnimationController _controller;

Widget RegisterBtn(AnimationController controller) {
  _controller = controller;
}

class PhoneTextFieldUI extends StatefulWidget {
  const PhoneTextFieldUI({Key key}) : super(key: key);

  @override
  _PhoneTextFieldUIState createState() => _PhoneTextFieldUIState();
}

class _PhoneTextFieldUIState extends State<PhoneTextFieldUI> {
  final txtController = TextEditingController(text: '');

  validateText() {
    Provider.of<SignInSharedVariable>(context).phoneNum = txtController.text;
    print(Provider.of<SignInSharedVariable>(context).phoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: txtController,
      maxLength: 9,
      maxLengthEnforced: true,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.pink),
      onChanged: (str) {
        validateText();
      },
      decoration: InputDecoration(
        fillColor: Colors.blue,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue)),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.blue,
        ),
        labelText: '+966',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.pink)),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.pink)),
      ),
    );
  }
}

class CodeTextField extends StatelessWidget {
  // final txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      // enabled: true,
      // controller: txtController,
      maxLength: 9,
      keyboardType: TextInputType.number,
      // style: TextStyle(color: Colors.white),
      onChanged: (str) {
        Provider.of<SignInSharedVariable>(context).code = str;
      },
      decoration: InputDecoration(
        labelText: 'Code',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.green)),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.green)),
      ),
    );
  }
}

class CityWidget extends StatelessWidget {
  final Function function;
  final Color color;
  const CityWidget({Key key, this.function, this.color}) : super(key: key);

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

class TextHolder extends StatelessWidget {
  final double height;
  final double width;
  final Color borderColor;
  final BorderRadius borderRadius;
  final Function function;
  final Widget textWidget;
  final Color backgroundColor;
  final Widget iconWidget;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  TextHolder(
      {Key key,
      this.backgroundColor,
      this.edgeInsetsGeometry,
      this.iconWidget,
      this.textWidget,
      this.borderRadius,
      this.width,
      this.height,
      this.borderColor,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          // boxShadow: [
          //   BoxShadow(color: Colors.white, blurRadius: 2, spreadRadius: 1),
          //                 BoxShadow(color: Colors.pink, blurRadius: 2, spreadRadius: 1)

          // ]
          // border: new Border.all(color: borderColor),
        ),
        child: InkWell(
            onTap: () {
              function();
            },
            child: Padding(
              padding: edgeInsetsGeometry,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  textWidget,
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),
                  iconWidget
                ],
              ),
            )));
  }
}
