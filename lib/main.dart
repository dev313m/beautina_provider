import 'package:beautina_provider/core/controller/refresh_controller.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:beautina_provider/screens/root/index.dart';
import 'package:beautina_provider/screens/signing_pages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'package:home_indicator/home_indicator.dart';

void main() async {
  bool? registered = await mainInit();
  return runApp(MyApp(
    registered: registered,
  ));
}

class MyApp extends StatelessWidget {
  final registered;
  const MyApp({this.registered});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, ___) {
        return GetMaterialApp(
            initialBinding: getBinding(),
            theme: ThemeData(
              fontFamily: 'Tajawal',
            ),
            home: registered != null ? PageRoot() : LoginPage());
      },
      designSize: Size(1080, 2340),
    );
  }

  Bindings getBinding() {
    if (registered != null) return InitialBindingRegistered();
    return InitialBinding();
  }
}
