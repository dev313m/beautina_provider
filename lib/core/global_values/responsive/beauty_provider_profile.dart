import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GlobalValBeautyProviderListenable extends GetxController {
  late ModelBeautyProvider _beautyProvider;

  GlobalValBeautyProviderListenable() {
    init();
  }

  Future init() async {
    beautyProvider = BeautyProviderController.getBeautyProviderProfile();
  }

  ModelBeautyProvider get beautyProvider => _beautyProvider;

  set beautyProvider(ModelBeautyProvider beautyProvider) {
    _beautyProvider = beautyProvider;
    update();
  }
}
