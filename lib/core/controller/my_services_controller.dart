import 'dart:convert';

import 'package:beautina_provider/core/controller/all_salon_services_controller.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/controller/common_controller.dart';
import 'package:beautina_provider/core/controller/erros_controller.dart';
import 'package:beautina_provider/core/controller/functions.dart';
import 'package:beautina_provider/core/db/my_services.dart';
import 'package:beautina_provider/core/global_values/responsive/my_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:beautina_provider/core/models/response/my_service.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class MyServicesController {
  static final ErrMyServicesNoLoading = 'my_services_err';
  static Future disableService(ModelMyService service) async {
    DBMyService _myServices = DBMyService();
    await _myServices.disableService(service.id!);
  }

  static Future addService(
      ModelService modelService, double duration, double price) async {
    DBMyService _myServices = DBMyService();

    ModelBeautyProvider _beautyProvider =
        BeautyProviderController.getBeautyProviderProfile();
    ModelMyService modelMyService = ModelMyService(
        city: _beautyProvider.city!,
        country: _beautyProvider.country!,
        prvd_img: '',
        isActive: true,
        cost: price,
        providerDesc: _beautyProvider.intro!,
        providerId: _beautyProvider.uid!,
        serviceCode: modelService.code,
        duration: duration,
        providerName: _beautyProvider.name!,
        geo: GeoPoint(10.1, 0.2));
    await _myServices.addAService(modelMyService.toMap());

    // var apiList = await _myServices.apiAllServices();
    // return tree;
  }

  Future startOrRefresh() async {
    try {
      List<ModelMyService> fullList = await getMyServicesList();
      List<ModelMyService> myServicesList =
          fullList.where((e) => e.isActive).toList();
      networkStatefulVarStarter(
          networkStatefulVarClass: Get.find<GlobalValMyServices>(),
          onStart: () async {
            Get.find<GlobalValMyServices>().myService.value = myServicesList;
          });

      setMyServicesAsNodes(myServicesList);
    } catch (e) {
      ErrorController.logError(exception: e, eventName: ErrMyServicesNoLoading);
    }
  }

  Future setMyServicesAsNodes(List<ModelMyService> myServicesList) async {
    AllSalonServicesController _cntrl = AllSalonServicesController();
    try {
      _cntrl.listenSuccessfulDownload().listenAndPump((isDownloaded) async {
        if (isDownloaded) {
          print('Print: this is all service ok');

          List<ModelService> allServices = _cntrl.getList();
          List<ModelService> allNodes = [];
          ModelService modelService;
          isServicesSuccessfullyDownloaded().listenAndPump((isDone) async {
            if (isDone) {
              getGlobalValMyServicesList().forEach((myService) {
                modelService = allServices.firstWhere(
                    (element) => element.code == myService.serviceCode);
                // add leaf
                allNodes.add(modelService);
                // add category
                if (modelService.rootCode != modelService.parentCode)
                  allNodes.add(allServices
                      .firstWhere(
                          (element) => element.code == modelService.parentCode)
                      .copyWith(children: []));
                // add root
                allNodes.add(allServices
                    .firstWhere(
                        (element) => element.code == modelService.rootCode)
                    .copyWith(children: []));
              });
              print('Print: this is my services level 2  just before compute');

              List<ModelService> tree = await compute(
                  CommonController.buildTree, allNodes.toSet().toList());
              await Future.delayed(Duration(seconds: 1));
              setServicesNodesList(tree);
              Get.find<GlobalValMyServices>().isReady.value = true;
            }
          });
        }
      });
    } catch (e) {
      return [];
    }

    return [];
  }

  Future<List<ModelMyService>> getMyServicesList() async {
    DBMyService _myServices = DBMyService();
    List<dynamic> _myServicesList;
    try {
      var json = await _myServices.getMyServices(
          BeautyProviderController.getBeautyProviderProfile().uid!);
      _myServicesList = await compute(jsonToMyService, json);

      return _myServicesList.cast<ModelMyService>();
    } catch (e) {
      throw e;
    }
  }

  setServicesNodesList(List<ModelService> list) {
    Get.find<GlobalValMyServices>().servicesListAsRootLeaf.assignAll(list);
    Get.find<GlobalValMyServices>().servicesListAsRootLeaf.refresh();

    // Get.find<GlobalValMyServices>().update();
  }

  List<ModelMyService> getGlobalValMyServicesList() {
    return Get.find<GlobalValMyServices>().myService;
  }

  RxBool isServicesSuccessfullyDownloaded() {
    return Get.find<GlobalValMyServices>().isFinishSuccess;
  }

  bool isError() {
    return Get.find<GlobalValMyServices>().isError.value;
  }

  bool isReady() {
    return Get.find<GlobalValMyServices>().isReady.value;
  }

  // Future<bool> addService()
}

List<dynamic> jsonToMyService(String json) {
  var map = jsonDecode(json);
  return map.map((item) => ModelMyService.fromMap(item)).toList();
}
