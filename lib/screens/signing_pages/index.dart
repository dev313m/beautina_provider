import 'dart:io';

import 'package:beautina_provider/core/controller/erros_controller.dart';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/ui/flare_animation.dart';
import 'package:beautina_provider/screens/signing_pages/ui/location.dart';
import 'package:beautina_provider/screens/signing_pages/ui/login_buttons.dart';
import 'package:beautina_provider/screens/signing_pages/ui/name.dart';
import 'package:beautina_provider/screens/signing_pages/ui/phone.dart';
import 'package:beautina_provider/screens/signing_pages/ui/user_type.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginPage extends StatefulWidget {
  // final GlobalKey<State<StatefulWidget>> globalKey;
  // Index({this.globalKey});
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  FlareController? flareController;
  @override
  void initState() {
    super.initState();
  }

  final txtController = TextEditingController(text: '');

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    txtController.dispose();
    super.dispose();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VMLoginDataTest>(builder: (vmLoginData) {
      return Scaffold(
        key: _globalKey,
        backgroundColor: ConstLoginColors.backgroundColor,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.all(paddingScreen),
            child: ListView(
              children: <Widget>[
                WdgtLoginFlare(),
                Y(),
                WdgtLoginName(),
                Y(),
                WdgtLoginLocation(
                  globalKey: _globalKey,
                ),
                Y(),
                WdgtLoginUserType(),
                Y(
                  height: heightBtwLoginBtn,
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: getSwitchedWidget(vmLoginData.phoneNum)),
                Y(
                  height: heightBtwLoginBtn,
                ),
                WdgtLoginPhone(
                  key: ValueKey('phoneke'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getSwitchedWidget(String phoneNum) {
    try {
      if (loading)
        return Container(
          ///must match the height of the login buttons so animation go smooth
          height: heightTextField,
          width: heightTextField,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orangeAccent,
            ),
          ),
        );
      else if (!loading && Platform.isAndroid && phoneNum.length == 9)
        return WdgtLoginButtonGoogle(
          onPress: () {
            loading = true;
            setState(() {});
          },
          onError: () {
            setState(() {
              loading = false;
            });
          },
          contextT: context,
        );
      else if (!loading && Platform.isIOS && phoneNum.length == 9)
        return WdgtLoginButtonIos(
          onPress: () {
            loading = true;
            setState(() {});
          },
          onError: () {
            loading = false;
            setState(() {});
          },
          contextT: context,
        );
      else
        return SizedBox(
          height: heightLoginBtns,
        );
    } catch (e) {
      if (loading)
        return Container(
          ///must match the height of the login buttons so animation go smooth
          height: heightTextField,
          width: heightTextField,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orangeAccent,
            ),
          ),
        );
      else if (phoneNum.length == 9)
        return WdgtLoginButtonGoogle(
          onPress: () {
            loading = true;
            setState(() {});
          },
          onError: () {
            setState(() {
              loading = false;
            });
          },
          contextT: context,
        );
      else
        return SizedBox(
          height: heightLoginBtns,
        );
    }
  }
}

///[height]
final double heightBtwLoginBtn = 50;
