import 'package:beautina_provider/blocks/add_service/block_add_service.dart';
import 'package:beautina_provider/core/global_values/responsive/all_salon_services.dart';
import 'package:beautina_provider/core/global_values/responsive/my_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BlockMyServicesRepo {
  final servicesIcons = 'assets/services_icons/';
  late GlobalValMyServices globalValMyServices;

  BlockMyServicesRepo() {
    globalValMyServices = Get.find<GlobalValMyServices>();
  }

  bool isLoadError() {
    return globalValMyServices.isServicesListAsRootLeafError.value;
  }

  bool isLoading() {
    return !globalValMyServices.isServicesListAsRootLeafReady.value;
  }

  reLoadServices() {
    globalValMyServices.loadApi();
  }

  List<ModelService> getRootNodes() {
    return globalValMyServices.servicesListAsRootLeaf.value
        .where((service) => service.isRoot)
        .toList();
  }

  Future<List<ModelService>> getLeafs(ModelService modelService) async {
    return await compute(computeLeafs, modelService);
  }

  showAddService(BuildContext context, {required ModelService modelService, required bool isUpdate}) {
    blockAddService(context, modelService: modelService, isUpdate: isUpdate);
  }
}

List<ModelService> computeLeafs(ModelService modelService) {
  return modelService.children.where((element) => !element.isCategory).toList();
}
