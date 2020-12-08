import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///[size]
double sizeContainer = 120.h;

///[radius]
double radius = 12;

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
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: sizeContainer,
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

            borderRadius: BorderRadius.circular(radius),
            children: <Widget>[
              Container(
                  width: 0.49.sw,
                  child: GWdgtTextToggle(
                    string: 'هذا حساب مشغل',
                  )),
              Container(
                  width: 0.49.sw,
                  child: GWdgtTextToggle(
                    string: 'أنا خبيرة',
                  )),
            ],
            isSelected: accountTypeBool,
          ),
        ),
      ),
    );
  }
}
