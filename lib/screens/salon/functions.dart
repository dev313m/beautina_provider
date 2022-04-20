import 'dart:io';

import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:beautina_provider/services/api/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Future<ModelBeautyProvider?> updateDataFromServer() async {
  try {
    ModelBeautyProvider? beautyProvider = await apiLoadOneBeautyProvider();
    if(beautyProvider!= null)
    await BeautyProviderController().storeToLocalDB(beautyProvider);
    // sharedUserProviderSet(beautyProvider: beautyProvider);
    return beautyProvider;
  } catch (e) {
    return BeautyProviderController.getBeautyProviderProfile();
    // showToast('')
  }
}

///When user adds some new services, this function generate the new services map from new one ;
Map<String, dynamic> getNewServicesMap(BuildContext context, showOther,
    chosenService, priceBefore, priceAfter, otherServiceName) {
  // ModelBeautyProvider beautyProvider =
  //     Get.find<GlobalValBeautyProviderListenable>().beautyProvider;
  // Map<String, dynamic> map =
  //     new Map<String, dynamic>.of(beautyProvider.servicespro!);
  // Map<String, dynamic> newMap = copyDeepMap(map);

  // if (!showOther) {
  //   List<String> services = chosenService.split('-');
  //   List<double> numbers =
  //       priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];

  //   if (newMap[services[0]] == null)
  //     newMap[services[0]] = {services[1]: numbers};
  //   else
  //     newMap[services[0]][services[1]] = numbers;
  // } else {
  //   if (newMap['other'] == null)
  //     newMap['other'] = {
  //       otherServiceName:
  //           priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore]
  //     };
  //   else
  //     newMap['other'][otherServiceName] =
  //         priceBefore == 0 ? [priceAfter] : [priceAfter, priceBefore];
  // }
  // return newMap;
  return {};
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
    String chosenService,
    priceBefore,
    priceAfter,
    otherServiceName,
    serviceDuration,
    RoundedLoadingButtonController _btnController) async {
  _btnController.start();

  ModelBeautyProvider bp =
     BeautyProviderController.getBeautyProviderProfile();
  try {
    // if (showOther)
    //   bp.service_duration![otherServiceName] = serviceDuration;
    // else
    //   bp.service_duration![chosenService.split('-')[1]] = serviceDuration;

    // ModelBeautyProvider newBp = await apiBeautyProviderUpdate(bp
    //   ..servicespro = getNewServicesMap(context, showOther, chosenService,
    //       priceBefore, priceAfter, otherServiceName));

    // Get.find<GlobalValBeautyProviderListenable>().beautyProvider = newBp;

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
    newMap[key] =
        (value is Map) ? copyDeepMap(value as Map<String, dynamic>) : value;
  });

  return newMap;
}

///
///                     * 1- get now beautyProvider from shared
///                     * 2- update and save in shared
///                     * 3- get shared and notifylisteners
///                    */

removeServiceByCodeAndUpdate(
    BuildContext context,
    String? serviceCode,
    String? serviceRoot,
    Function onDeleteServiceSuccess,
    Function onDeleteServiceError,
    Function onDeleteServiceLoad,
    Function onDeleteServiceComplete) async {
  // onDeleteServiceLoad();

  // /// 1- Get current userData
  // ModelBeautyProvider bp =
  //    BeautyProviderController.getBeautyProviderProfile();

  // /// 2- Remove
  // Map<String, dynamic> newMap = bp.servicespro!;
  // newMap[serviceRoot!].remove(serviceCode);

  // /// 3- update
  // try {
  //   Get.find<GlobalValBeautyProviderListenable>().beautyProvider =
  //       await apiBeautyProviderUpdate(bp..servicespro = newMap);
  //   onDeleteServiceSuccess();
  // } catch (e) {
  //   onDeleteServiceError();
  // }
  // onDeleteServiceComplete();
}

/**
                             * 1- get now beautyProvider from shared
                             * 2- update and save in shared
                             * 3- get shared and notifylisteners
                             */

updateUserDefaults(
    BuildContext context,
    Function onDefaultsChangeSuccess,
    Function onDefaultsChangeLoad,
    Function onADefaultsChangeError,
    Function onDefaultsChangeComplete,
    {required bool? defaultAccept,
    required int? defaultAfterAccept}) async {
  onDefaultsChangeLoad();
  try {
    ModelBeautyProvider mbp =
      BeautyProviderController.getBeautyProviderProfile();

    await apiBeautyProviderUpdate(mbp
      ..default_accept = defaultAccept
      ..default_after_accept = defaultAfterAccept);

    // Get.find<VMSalonDataTest>().beautyProvider = mbp;
    // setState(() {});
    Get.find<GlobalValBeautyProviderListenable>().beautyProvider =
        BeautyProviderController.getBeautyProviderProfile();
    onDefaultsChangeSuccess();
    // var don;
  } catch (e) {
    onADefaultsChangeError();
  }

  onDefaultsChangeComplete();
}

/**
                             * 1- get now beautyProvider from shared
                             * 2- update and save in shared
                             * 3- get shared and notifylisteners
                             */

updateUserAvailability(
  BuildContext context,
  Function onAvailableChangeSuccess,
  Function onAvailableChangeLoad,
  Function onAvailableChangeError,
  Function onAvailableChangeComplete,
) async {
  onAvailableChangeLoad();
  try {
    ModelBeautyProvider mbp =
       BeautyProviderController.getBeautyProviderProfile();

    await apiBeautyProviderUpdate(mbp..available = !mbp.available!);

    // Get.find<VMSalonDataTest>().beautyProvider = mbp;
    // setState(() {});
    Get.find<GlobalValBeautyProviderListenable>().beautyProvider =
       BeautyProviderController.getBeautyProviderProfile();
    onAvailableChangeSuccess();
    // var don;
  } catch (e) {
    onAvailableChangeError();
  }

  onAvailableChangeComplete();
}

updateProfileImage(
    BuildContext context,
    Function onProfileImageChangeLoad,
    Function onProfileImageChangeSuccess,
    Function onProfileImageChangeError,
    Function onProfileImageChangeComplete) async {
  XFile file = await (imageChoose() as Future<XFile>);
  if (await File(file.path).exists() == false) return;
  DefaultCacheManager manager = new DefaultCacheManager();
  ModelBeautyProvider beautyProvider =
      Get.find<GlobalValBeautyProviderListenable>().beautyProvider;
  manager.emptyCache();
  onProfileImageChangeLoad();
  bool response = await imageUpload(file, beautyProvider.uid);
  if (response) {
    try {
      // imageCache.clear();
      // painting.imageCache.clear();
      manager.emptyCache();

      await Future.delayed(Duration(seconds: 8));
      // super.setState(() {});
      // setState(() {});

      ModelBeautyProvider mbp =
          BeautyProviderController.getBeautyProviderProfile();

      await apiBeautyProviderUpdate(mbp..available = mbp.available);

      // Get.find<VMSalonDataTest>().beautyProvider = mbp;
      // setState(() {});
      Get.find<GlobalValBeautyProviderListenable>().beautyProvider =
         BeautyProviderController.getBeautyProviderProfile();
    } catch (e) {
      onProfileImageChangeError();
    }
    onProfileImageChangeComplete();
  }
}
