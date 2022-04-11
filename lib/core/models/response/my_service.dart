import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ModelMyService {
  String providerName = '';
  String providerId = '';
  String img = '';
  String providerDesc = '';
  String city = '';
  String country = '';
  bool isActive = false;
  double? duration;
  double? cost;
  int viewCount = 0;
  int orderCount = 0;
  String serviceCode = '';
  DateTime? createDate;
  GeoPoint? geo;
  DateTime? startDate;
  DateTime? finishDate;
  ModelMyService({
    required this.providerName,
    required this.providerId,
    required this.img,
    required this.providerDesc,
    required this.city,
    required this.country,
    required this.isActive,
    this.duration,
    this.cost,
    required this.viewCount,
    required this.orderCount,
    required this.serviceCode,
    this.createDate,
    this.geo,
    this.startDate,
    this.finishDate,
  });

  ModelMyService copyWith({
    String? providerName,
    String? providerId,
    String? img,
    String? providerDesc,
    String? city,
    String? country,
    bool? isActive,
    double? duration,
    double? cost,
    int? viewCount,
    int? orderCount,
    String? serviceCode,
    DateTime? createDate,
    GeoPoint? geo,
    DateTime? startDate,
    DateTime? finishDate,
  }) {
    return ModelMyService(
      providerName: providerName ?? this.providerName,
      providerId: providerId ?? this.providerId,
      img: img ?? this.img,
      providerDesc: providerDesc ?? this.providerDesc,
      city: city ?? this.city,
      country: country ?? this.country,
      isActive: isActive ?? this.isActive,
      duration: duration ?? this.duration,
      cost: cost ?? this.cost,
      viewCount: viewCount ?? this.viewCount,
      orderCount: orderCount ?? this.orderCount,
      serviceCode: serviceCode ?? this.serviceCode,
      createDate: createDate ?? this.createDate,
      geo: geo ?? this.geo,
      startDate: startDate ?? this.startDate,
      finishDate: finishDate ?? this.finishDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'providerName': providerName,
      'providerId': providerId,
      'img': img,
      'providerDesc': providerDesc,
      'city': city,
      'country': country,
      'isActive': isActive,
      'duration': duration,
      'cost': cost,
      'viewCount': viewCount,
      'orderCount': orderCount,
      'serviceCode': serviceCode,
      'createDate': createDate?.millisecondsSinceEpoch,
      'geo': geo,
      'startDate': startDate?.millisecondsSinceEpoch,
      'finishDate': finishDate?.millisecondsSinceEpoch,
    };
  }

  factory ModelMyService.fromMap(Map<String, dynamic> map) {
    return ModelMyService(
      providerName: map['providerName'] ?? '',
      providerId: map['providerId'] ?? '',
      img: map['img'] ?? '',
      providerDesc: map['providerDesc'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      isActive: map['isActive'] ?? false,
      duration: map['duration']?.toDouble(),
      cost: map['cost']?.toDouble(),
      viewCount: map['viewCount']?.toInt() ?? 0,
      orderCount: map['orderCount']?.toInt() ?? 0,
      serviceCode: map['serviceCode'] ?? '',
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'])
          : null,
      geo: map['geo'] != null
          ? GeoPoint(map['geo']['coordinates'][1], map['geo']['coordinates'][0])
          : null,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      finishDate: map['finishDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['finishDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelMyService.fromJson(String source) =>
      ModelMyService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ModelMyService(providerName: $providerName, providerId: $providerId, img: $img, providerDesc: $providerDesc, city: $city, country: $country, isActive: $isActive, duration: $duration, cost: $cost, viewCount: $viewCount, orderCount: $orderCount, serviceCode: $serviceCode, createDate: $createDate, geo: $geo, startDate: $startDate, finishDate: $finishDate)';
  }
}
