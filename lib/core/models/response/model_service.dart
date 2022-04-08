import 'dart:convert';

class ModelService {
  String code = '';
  String parentCode = '';
  bool isCategory = false;
  bool isRoot = false;
  String arName = '';
  String enName = '';
  String rootCode = '';
  List<ModelService> children = [];
  ModelService({
    required this.code,
    required this.parentCode,
    required this.isCategory,
    required this.isRoot,
    required this.arName,
    required this.enName,
    required this.rootCode,
    required this.children,
  });

  ModelService copyWith({
    String? code,
    String? parentCode,
    bool? isCategory,
    bool? isRoot,
    String? arName,
    String? enName,
    String? rootCode,
    List<ModelService>? children,
  }) {
    return ModelService(
      code: code ?? this.code,
      parentCode: parentCode ?? this.parentCode,
      isCategory: isCategory ?? this.isCategory,
      isRoot: isRoot ?? this.isRoot,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      rootCode: rootCode ?? this.rootCode,
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'parentCode': parentCode,
      'isCategory': isCategory,
      'isRoot': isRoot,
      'arName': arName,
      'enName': enName,
      'rootCode': rootCode,
      'children': children.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelService.fromMap(Map<String, dynamic> map) {
    return ModelService(
      code: map['code'] ?? '',
      parentCode: map['parent_code'] ?? '',
      isCategory: map['is_category'] ?? false,
      isRoot: map['is_root'] ?? false,
      arName: map['ar_nm'] ?? '',
      enName: map['en_nm'] ?? '',
      rootCode: map['root_code'] ?? '',
      children: [],
    );
  }

  copy(ModelService modelService) {
    return ModelService(
        code: modelService.code,
        enName: modelService.enName,
        isCategory: modelService.isCategory,
        isRoot: modelService.isRoot,
        arName: modelService.arName,
        children: modelService.children,
        parentCode: modelService.parentCode,
        rootCode: modelService.rootCode);
  }

  String toJson() => json.encode(toMap());

  factory ModelService.fromJson(String source) =>
      ModelService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ModelService(code: $code, parentCode: $parentCode, isCategory: $isCategory, isRoot: $isRoot, arName: $arName, enName: $enName, rootCode: $rootCode, children: $children)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelService &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}
