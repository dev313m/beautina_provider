import 'package:beautina_provider/reusables/text.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WdgtLoginUserType extends StatefulWidget {
  const WdgtLoginUserType({Key key}) : super(key: key);

  @override
  _WdgtLoginUserTypeState createState() => _WdgtLoginUserTypeState();
}

class _WdgtLoginUserTypeState extends State<WdgtLoginUserType> {
  List<bool> accountTypeBool = [false, false];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: ScreenUtil().setHeight(100),
          // width: ScreenUtil().setWidth(200),
          color: Colors.blue.withOpacity(0.5),
          child: ToggleButtons(
            onPressed: (index) {
              showAlert(context,
                  msg: 'لايمكنك تغيير نوع الحساب لاحقا', dismiss: 'تم');
              accountTypeBool = [false, false];
              accountTypeBool[index] = true;
              setState(() {});
              // showToast(index.toString());
              Provider.of<VMLoginData>(context).accountType =
                  index == 1 ? 1 : 0;
            },

            // color: Colors.blue,
            // fillColor: Colors.blue,
            color: Colors.blue.withOpacity(0.6),
            fillColor: Colors.blue,

            borderRadius: BorderRadius.circular(12),
            children: <Widget>[
              Container(
                  width: ScreenUtil().setWidth(340),
                  child: ExtendedText(
                    string: 'هذا حساب مشغل',
                    fontSize: ExtendedText.bigFont,
                  )),
              Container(
                  width: ScreenUtil().setWidth(340),
                  child: ExtendedText(
                    string: 'أنا خبيرة',
                    fontSize: ExtendedText.bigFont,
                  )),
            ],
            isSelected: accountTypeBool,
          ),
        ),
      ),
    );
  }
}
