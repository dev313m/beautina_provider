import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';

class LocationAlertRepo {
  bool isLocationSet() {
    var location =
        BeautyProviderController.getBeautyProviderProfile().location?.length;
    if (location == null) return false;
    return location > 0 ? true : false;
  }
}
