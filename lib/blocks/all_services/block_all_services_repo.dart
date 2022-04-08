import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';

class BlockAllServicesRepo {

  final servicesIcons = 'assets/services_icons/'; 
  late GlobalValAllServices globalValAllServices;

  BlockAllServicesRepo() {
    globalValAllServices = Get.find<GlobalValAllServices>();
  }

  bool isLoadError() {
    return globalValAllServices.isError.value;
  }

  bool isLoading() {
    return globalValAllServices.isLoading.value;
  }

  reLoadServices() {
    globalValAllServices.loadApi();
  }

  List<ModelService> getRootNodes() {
    return globalValAllServices.value.value
        .where((service) => service.isRoot)
        .toList();
  }

  Future<List<ModelService>> getLeafs(ModelService modelService) async {
    return await compute(computeLeafs, modelService);
  }
}

List<ModelService> computeLeafs(ModelService modelService) {
  return modelService.children.where((element) => !element.isCategory).toList();
}
