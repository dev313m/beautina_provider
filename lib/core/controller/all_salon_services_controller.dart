import 'dart:convert';

import 'package:beautina_provider/core/controller/common_controller.dart';
import 'package:beautina_provider/core/db/all_services.dart';
import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class AllSalonServicesController {
  static Future<List<ModelService>> getServices() async {
    DBAllServices _allServices = DBAllServices();

    var apiList = await _allServices.apiAllServices();
    try {
      var list = jsonToModel(apiList);
      // var list = await compute(jsonToModel, apiList);
      return list;
    } catch (e) {
      throw Exception('error');
    }
  }

  List<ModelService> getList() {
    return Get.find<GlobalValAllServices>().value.value;
  }

  RxBool listenSuccessfulDownload() {
    return Get.find<GlobalValAllServices>().isFinishSuccess;
  }
}

List<ModelService> jsonToModel(String json) {
  var list = jsonDecode(json)['services'];
  var newList = list.map((service) {
    return ModelService.fromMap(service ?? {});
  }).toList();
  return CommonController.buildTree(newList);
}
