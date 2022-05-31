import 'package:beautina_provider/blocks/add_service/block_add_service.dart';
import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/global_values/responsive/my_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BlockAllServicesRepo {
  final servicesIcons = 'assets/services_icons/';
  late GlobalValAllServices globalValAllServices;
  late GlobalValMyServices globalValMyServices;

  BlockAllServicesRepo() {
    globalValAllServices = Get.find<GlobalValAllServices>();
    globalValMyServices = Get.find<GlobalValMyServices>();
  }

  bool isLoadError() {
    return globalValAllServices.isError.value;
  }

  bool isLoading() {
    return globalValAllServices.isLoading.value &&
        globalValMyServices.isFinishSuccess.value;
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

  showAddService(BuildContext context,
      {required ModelService modelService, required bool isUpdate}) {
    blockAddService(context, modelService: modelService, isUpdate: isUpdate);
  }
}

List<ModelService> computeLeafs(ModelService modelService) {
  return modelService.children.where((element) => !element.isCategory).toList();
}
