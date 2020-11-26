import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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

Map<String, dynamic> getNewServicesMap(BuildContext context, showOther,
    chosenService, priceBefore, priceAfter, otherServiceName) {
  ModelBeautyProvider beautyProvider =
      Provider.of<VMSalonData>(context).beautyProvider;
  Map<String, dynamic> map =
      new Map<String, dynamic>.of(beautyProvider.servicespro);
  Map<String, dynamic> newMap = copyDeepMap(map);

  if (!showOther) {
    List<String> services = chosenService.split('-');
    List<double> numbers =
        priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];

    if (newMap[services[0]] == null)
      newMap[services[0]] = {services[1]: numbers};
    else
      newMap[services[0]][services[1]] = numbers;
  } else {
    if (newMap['other'] == null)
      newMap['other'] = {
        otherServiceName:
            priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore]
      };
    else
      newMap['other'][otherServiceName] =
          priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];
  }
  return newMap;
}

///
///   * 1- get now beautyProvider from shared
///   * 2- send update request to server and save in shared
///   * 3- get shared and notifylisteners
///   * handle errors
///   finally, send [toast] to notify user
updateProviderServices(
    BuildContext context,
    showOther,
    chosenService,
    priceBefore,
    priceAfter,
    otherServiceName,
    RoundedLoadingButtonController _btnController) async {
  _btnController.start();

  ModelBeautyProvider bp = await sharedUserProviderGetInfo();
  try {
    Provider.of<VMSalonData>(context).beautyProvider =
        await apiBeautyProviderUpdate(bp
          ..servicespro = getNewServicesMap(context, showOther, chosenService,
              priceBefore, priceAfter, otherServiceName));
    // setState(() {});
    showToast('تمت الاضافة بنجاح');
    _btnController.success();
    await Future.delayed(Duration(seconds: 3));
    _btnController.reset();
  } catch (e) {
    showToast('حدث خطأ، لم يتم الاضافة');
    _btnController.error();
    await Future.delayed(Duration(seconds: 3));
    _btnController.reset();
  }
}

Map<String, dynamic> copyDeepMap(Map<String, dynamic> map) {
  Map<String, dynamic> newMap = {};

  map.forEach((key, value) {
    newMap[key] = (value is Map) ? copyDeepMap(value) : value;
  });

  return newMap;
}
