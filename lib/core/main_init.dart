import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/db/local/hive_adapters.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

GetIt getIt = GetIt.instance;

Future<bool?> mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Firebase.initializeApp();
  HiveAdapters.init();
  bool? registered = await sharedGetRegestered();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  getIt.registerSingleton<ModelBeautyProvider>(
      await sharedUserProviderGetInfo());

  initGlobalVariablesRegistered();
  return registered;
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
    Get.put(
      VMSalonDataTest(build: true),
      permanent: true,
    );

    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: true), permanent: true);
    Get.put(VmDateDataTest(build: true));
    Get.put(VMSettingsDataTest(), permanent: true);
  }
}

initGlobalVariablesRegistered() async {
  BeautyProviderController().registerObjFromLocalStorage();
}

initGlobalVariablesNotRegistered() async {}



refreshApp(BuildContext context) {
  Get.find<VMRootDataTest>().shareRoot();
  Get.find<VMSalonDataTest>().init();
  Get.find<VmDateDataTest>().iniState();
}

refreshResume(BuildContext context) async {
  Get.find<VmDateDataTest>().iniState();
  Get.find<VMRootDataTest>().initNotificationDb();
}
