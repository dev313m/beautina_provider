import 'package:beautina_provider/core/models/response/model_service.dart';

class CommonController {
  /// 1- take the parent node of each item
  /// 2- add the node to its parent
  static List<ModelService> buildTree(List<dynamic> nodes) {
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
}
