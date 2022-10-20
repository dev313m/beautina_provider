import 'package:beautina_provider/blocks/add_service/block_add_service.dart';
import 'package:beautina_provider/core/controller/my_services_controller.dart';
import 'package:beautina_provider/core/global_values/responsive/my_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:beautina_provider/core/models/response/my_service.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BlockMyServicesRepo {
  final servicesIcons = 'assets/services_icons/';
  late GlobalValMyServices globalValMyServices;

  BlockMyServicesRepo() {
    globalValMyServices = Get.find<GlobalValMyServices>();
  }

  bool isLoadError() {
    return globalValMyServices.isError.value;
  }

  bool isLoading() {
    return !globalValMyServices.isReady.value;
  }

  reLoadServices() {
    MyServicesController().startOrRefresh();
  }

  List<ModelService> getRootNodes() {
    return globalValMyServices.servicesListAsRootLeaf
        .where((service) => service.isRoot)
        .toList();
  }

  // Future<List<ModelService>> getLeafs(ModelService modelService) async {
  //   return await compute(computeLeafs, modelService);
  // }

  showAddService(BuildContext context,
      {required ModelService modelService,
      required ModelMyService? modelMyService}) {
    blockAddService(context,
        modelService: modelService, modelMyService: modelMyService);
  }
}

// List<ModelService> computeLeafs(ModelService modelService) {
//   return modelService.children.where((element) => !element.isCategory).toList();
// }
