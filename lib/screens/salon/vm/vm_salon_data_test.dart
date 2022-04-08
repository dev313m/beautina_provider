import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/salon/functions.dart';
import 'package:beautina_provider/prefrences/services.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_provided_services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class VMSalonDataTest extends GetxController {
  bool build = true;
  ModelBeautyProvider _beautyProvider =
      BeautyProviderController.getBeautyProviderProfile();
  Map<String, dynamic>? _providedServices = {};

  Map<String, dynamic>? get providedServices => _providedServices;

  set providedServices(Map<String, dynamic>? providedServices) {
    _providedServices = providedServices;
    update();
  }

  ModelBeautyProvider get beautyProvider => _beautyProvider;

  set beautyProvider(ModelBeautyProvider beautyProvider) {
    _beautyProvider = beautyProvider;
    update();
  }

  VMSalonDataTest({this.build = true}) {
    if (build) init();
  }

  init() async {
    beautyProvider = BeautyProviderController.getBeautyProviderProfile();
    providedServices = await memoryGetServices();
    try {
      ModelBeautyProvider? beautyProviderTest = await updateDataFromServer();
      Map<String, dynamic>? providedServicesTest = await apiProvidedServices();
      if (beautyProviderTest != null) beautyProvider = beautyProviderTest;

      if (providedServicesTest != null) providedServices = providedServicesTest;
    } catch (e) {
      showToast(e.toString());
    }
  }
}
