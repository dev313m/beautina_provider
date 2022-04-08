import 'package:beautina_provider/reusables/animated_textfield.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beautina_provider/screens/root/functions.dart';
class WdgtLoginPhone extends StatefulWidget {
  const WdgtLoginPhone({Key? key}) : super(key: key);

  @override
  _WdgtLoginPhoneState createState() => _WdgtLoginPhoneState();
}

class _WdgtLoginPhoneState extends State<WdgtLoginPhone> {
  final txtController = TextEditingController(text: '');

  // validateText() {
  //   Get.find<VMLoginDataTest>().phoneNum = txtController.text;
  //   print(Get.find<VMLoginDataTest>().phoneNum);
  // }


  validateText() {
    Get.find<VMLoginDataTest>().phoneNum =
        convertArabicToEnglish(txtController.text);
    print(Get.find<VMLoginDataTest>().phoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return BeautyTextfield(
      enabled: true,
      controller: txtController,
      maxLength: 9,
      // maxLengthEnforced: true,
      inputType: TextInputType.number,
      // style: TextStyle(color: Colors.pink),
      onChanged: (str) {
        validateText();
      },
      prefixIcon: Icon(
        Icons.phone,
        color: Colors.blue,
      ),
      helperText: '+966',
      // decoration: InputDecoration(
      //   fillColor: Colors.blue,
      //   enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(12),
      //       borderSide: BorderSide(color: Colors.blue)),
      //   prefixIcon: Icon(
      //     Icons.phone,
      //     color: Colors.blue,
      //   ),
      //   labelText: '+966',
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(radius)),
      //       borderSide: BorderSide(color: Colors.pink)),
      //   labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.pink),
      //   focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(radius)),
      //       borderSide: BorderSide(color: Colors.pink)),
      // ),
    );
  }
}
