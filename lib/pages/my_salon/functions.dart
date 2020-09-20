import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/foundation.dart';

Future<ModelBeautyProvider> updateDataFromServer() async {
  try {
    ModelBeautyProvider beautyProvider = await apiLoadOneBeautyProvider();
    sharedUserProviderSet(beautyProvider: beautyProvider);
    return beautyProvider;
  } catch (e) {
    return await sharedUserProviderGetInfo();
    // showToast('')
  }
}

abstract class ContractSalon {
  changeAvailibilitySuccess();
  changeAvailibilityError();
}

class SalonFunctions {
  ContractSalon contractSalon;
  SalonFunctions(this.contractSalon);

  changeAvailibility({@required available}) async {
    try {
      await Future.delayed(Duration(seconds: 5));
      contractSalon.changeAvailibilitySuccess();
    } catch (e) {
      contractSalon.changeAvailibilitySuccess();
    }
  }
}
