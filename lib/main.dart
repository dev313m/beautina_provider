import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/screens/root/index.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/signing_pages/index.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:home_indicator/home_indicator.dart';

void main() async {
  //just be aware here.
  WidgetsFlutterBinding.ensureInitialized();

  bool registered = await sharedGetRegestered();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // FullScreen fullscreen = FullScreen();

  await HomeIndicator.hide();

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
    return GetMaterialApp(
        initialBinding:
            getBinding(),
        theme: ThemeData(
          fontFamily: ArabicFonts.Tajawal,
        ),
        home: registered != null ? PageRoot() : LoginPage());
  }

   Bindings getBinding(){
    if(registered!=null)
    return InitialBindingRegistered(); 
    return InitialBinding(); 
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: false), permanent: true);
    Get.put(VmDateDataTest(build: false));
    Get.put(VMSettingsDataTest(), permanent: true);
    Get.put(VMLoginDataTest(), permanent: true);

    Get.put(VMSalonDataTest(build: false), permanent: true);
  }
}

class InitialBindingRegistered extends Bindings {
  @override
  void dependencies() {
    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: true), permanent: true);
    Get.put(VmDateDataTest(build: true));
    Get.put(VMSettingsDataTest(), permanent: true);
    Get.put(VMSalonDataTest(build: true), permanent: true);
  }
}
