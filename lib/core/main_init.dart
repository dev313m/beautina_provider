import 'package:beautina_provider/core/controller/my_services_controller.dart';
import 'package:beautina_provider/core/controller/refresh_controller.dart';
import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/core/global_values/responsive/my_services.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<bool?> mainInit() async {
  await RefreshController.onStart();
  bool? registered = await sharedGetRegestered();
  return registered;
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => VMRootUiTest(),
    );
    Get.lazyPut(
      () => VMRootDataTest(build: false),
    );
    // Get.put(VmDateDataTest(build: false));
    Get.lazyPut(
      () => VMSettingsDataTest(),
    );
    Get.lazyPut(() => VMLoginDataTest());
    Get.lazyPut(() => GlobalValBeautyProviderListenable());
    Get.lazyPut(
      () => GlobalValAllServices(),
    );
    Get.put<GlobalValMyServices>(GlobalValMyServices());

    Get.lazyPut(() => VmDateDataTest(build: true));

    Get.lazyPut(
      () => VMSalonDataTest(build: true),
    );
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
    Get.put(GlobalValBeautyProviderListenable(), permanent: true);
    Get.put<GlobalValMyServices>(GlobalValMyServices());
    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: true), permanent: true);
    Get.put(VmDateDataTest(build: true));
    Get.put(VMSettingsDataTest(), permanent: true);
  }
}
