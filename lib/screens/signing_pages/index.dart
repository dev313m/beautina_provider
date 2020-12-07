import 'dart:io';
import 'package:beautina_provider/screens/signing_pages/constants.dart';
import 'package:beautina_provider/screens/signing_pages/ui/flare_animation.dart';
import 'package:beautina_provider/screens/signing_pages/ui/location.dart';
import 'package:beautina_provider/screens/signing_pages/ui/login_buttons.dart';
import 'package:beautina_provider/screens/signing_pages/ui/name.dart';
import 'package:beautina_provider/screens/signing_pages/ui/phone.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 2340), allowFontScaling: true);

    return ChangeNotifierProvider(
      create: (_) => VMLoginData(),

      child: Index(),
      // builder: (context, _, child)=>Text(''),
    );
  }
}

class Index extends StatefulWidget {
  // final GlobalKey<State<StatefulWidget>> globalKey;
  // Index({this.globalKey});
  @override
  _IndexState createState() => new _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  bool loading = false;
  FlareController flareController;
  VMLoginData vmLoginData;
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
    vmLoginData = Provider.of<VMLoginData>(context);
    return Scaffold(
      key: _globalKey,
      backgroundColor: ConstLoginColors.backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: <Widget>[
            WdgtLoginFlare(),
            WdgtLoginName(),
            WdgtLoginLocation(
              globalKey: _globalKey,
            ),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: getSwitchedWidget()),
            WdgtLoginPhone(
              key: ValueKey('phoneke'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSwitchedWidget() {
    if (loading)
      return CircularProgressIndicator(
        backgroundColor: Colors.orangeAccent,
      );
    else if (!loading && Platform.isAndroid && vmLoginData.phoneNum.length == 9)
      return WdgtLoginButtonGoogle(
        onPress: () {
          loading = false;
          setState(() {});
        },
      );
    else if (!loading && Platform.isIOS && vmLoginData.phoneNum.length == 9)
      return WdgtLoginButtonIos(
        onPress: () {
          loading = false;
          setState(() {});
        },
      );
    else
      return SizedBox(
        height: 100,
      );
  }
}
