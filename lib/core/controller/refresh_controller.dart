import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/controller/my_services_controller.dart';
import 'package:beautina_provider/core/db/local/hive_adapters.dart';
import 'package:beautina_provider/core/global_values/not_responsive/hive_box.dart';

import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

class RefreshController {
  static Future onStart() async {
    await Hive.initFlutter();
    await Firebase.initializeApp();
    HiveAdapters.init();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent));
    await GlobalValHiveBox().init();
    try {
      await BeautyProviderController().registerObjFromLocalStorage();
    } catch (e) {}
  }

  static Future onStartRegistered() async {
    MyServicesController().startOrRefresh();
    // await BeautyProviderController().registerObjFromLocalStorage();
  }

  static Future onStartNotRegistered() async {}

  static Future afterLogin() async {
    await BeautyProviderController().registerObjFromLocalStorage();
    Get.find<VMRootDataTest>().reInit();
  }

  static Future afterServiceUpdate() async {
    await MyServicesController().startOrRefresh();
  }

  static Future afterProfileUpdate() async {}
}

refreshApp() async {
  Get.find<VMRootDataTest>().reInit();
  await BeautyProviderController().registerObjFromLocalStorage();

  Get.find<VMSalonDataTest>().init();
  Get.find<VmDateDataTest>().iniState();
}

refreshResume(BuildContext context) async {
  Get.find<VmDateDataTest>().iniState();
  Get.find<VMRootDataTest>().initNotificationDb();
}
