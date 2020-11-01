import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/my_salon/functions.dart';
import 'package:beautina_provider/prefrences/services.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_provided_services.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/foundation.dart';

class SharedSalon with ChangeNotifier {
  bool build = true;
  ModelBeautyProvider _beautyProvider;
  Map<String, dynamic> _providedServices = {};

  Map<String, dynamic> get providedServices => _providedServices;

  set providedServices(Map<String, dynamic> providedServices) {
    _providedServices = providedServices;
    notifyListeners();
  }

  ModelBeautyProvider get beautyProvider => _beautyProvider;

  set beautyProvider(ModelBeautyProvider beautyProvider) {
    _beautyProvider = beautyProvider;
    notifyListeners();
  }

  SharedSalon({this.build = true}) {
    if (build) init();
  }

  init() async {
    beautyProvider = await sharedUserProviderGetInfo();
    providedServices = await memoryGetServices();
    try {
      ModelBeautyProvider beautyProviderTest = await updateDataFromServer();
      Map<String, dynamic> providedServicesTest = await apiProvidedServices();
      if (beautyProviderTest != null) beautyProvider = beautyProviderTest;

      if (providedServicesTest != null) providedServices = providedServicesTest;
    } catch (e) {
      showToast(e.toString());
    }
  }
}
