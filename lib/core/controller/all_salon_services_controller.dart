import 'package:beautina_provider/core/db/all_services.dart';
import 'package:beautina_provider/core/models/response/model_service.dart';
import 'package:flutter/foundation.dart';

class AllSalonServices {
  static Future<List<ModelService>> getServices() async {
    DBAllServices _allServices = DBAllServices();

    var apiList = await _allServices.apiAllServices();

    var modelList = await compute(convertToModel, apiList);
    var tree = await compute(buildTree, modelList);

    return tree;
  }
}

List<ModelService> convertToModel(List<dynamic> list) {
  return list.map((service) => ModelService.fromMap(service ?? {})).toList();
}

/// 1- take the parent node of each item
/// 2- add the node to its parent
List<ModelService> buildTree(List<ModelService> nodes) {
  var copyNode = nodes.map((e) => e.copy(e)).toList();
  var updatedNode = nodes.map((e) => e.copy(e)).toList().cast<ModelService>();

  copyNode.forEach((node) {
    if (node.isRoot == false) {
      var parentNodeIndex = updatedNode
          .indexWhere((parentNode) => parentNode.code == node.parentCode);
      updatedNode[parentNodeIndex] = updatedNode[parentNodeIndex]
        ..children.add(node);
    }
  });

  return updatedNode;
}
