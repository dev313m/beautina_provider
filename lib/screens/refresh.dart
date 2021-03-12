import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

refreshApp(BuildContext context) {
  Get.find<VMRootDataTest>().shareRoot();
  Get.find<VMSalonDataTest>().init();
  Get.find<VmDateDataTest>().iniState();
}

refreshResume(BuildContext context) async {
  Get.find<VmDateDataTest>().iniState();
  Get.find<VMRootDataTest>().initNotificationDb();
}
