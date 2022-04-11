import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/db/local/hive_adapters.dart';
import 'package:beautina_provider/core/global_values/not_responsive/hive_box.dart';
import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/core/global_values/responsive/salon_services_cart.dart';
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
  // getIt.registerSingleton<ModelBeautyProvider>(
  //     await sharedUserProviderGetInfo());
  // refreshApp();
  if (registered ?? false)
    await initGlobalVariablesRegistered();
  else
    await initGlobalVariablesNotRegistered();
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
    Get.put(GlobalValBeautyProviderListenable(), permanent: true);
    Get.put(GlobalValAllServices(), permanent: true);

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
    Get.put(GlobalValAllServices(), permanent: true);
    Get.lazyPut(() => GlobalValSalonServicesCart());
    Get.put(GlobalValBeautyProviderListenable(), permanent: true);

    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: true), permanent: true);
    Get.put(VmDateDataTest(build: true));
    Get.put(VMSettingsDataTest(), permanent: true);
  }
}

initGlobalVariablesRegistered() async {
  await GlobalValHiveBox().init();
  await BeautyProviderController().registerObjFromLocalStorage();
}

initGlobalVariablesNotRegistered() async {
  await GlobalValHiveBox().init();
}

refreshApp() async {
  Get.find<VMRootDataTest>().shareRoot();
  await BeautyProviderController().registerObjFromLocalStorage();

  Get.find<VMSalonDataTest>().init();
  Get.find<VmDateDataTest>().iniState();
}

refreshResume(BuildContext context) async {
  Get.find<VmDateDataTest>().iniState();
  Get.find<VMRootDataTest>().initNotificationDb();
}
