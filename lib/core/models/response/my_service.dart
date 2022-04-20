import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ModelMyService {
  String? id;

  String providerName = '';
  String providerId = '';
  String prvd_img = '';
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
    required this.prvd_img,
    required this.providerDesc,
    required this.city,
    required this.country,
    required this.isActive,
    this.duration,
    this.cost,
     this.viewCount  = 0,
     this.orderCount = 0,
    this.id,
    required this.serviceCode,
    this.createDate,
    this.geo,
    this.startDate,
    this.finishDate,
  });

  ModelMyService copyWith({
    String? providerName,
    String? providerId,
    String? prvd_img,
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
      prvd_img: prvd_img ?? this.prvd_img,
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
      'prvd_nm': providerName,
      'prvd_id': providerId,
      'prvd_img': prvd_img,
      'prvd_desc': providerDesc,
      'city': city,
      'cntry': country,
      'active': isActive,
      'duration': duration,
      'cost': cost,
      'view_cnt': viewCount,
      'order_cnt': orderCount,
      'service_code': serviceCode,
      // 'crt_dt': createDate.toString(),
      'lng': geo?.longitude,
      'lat': geo?.latitude,
      // 'strt_dt': startDate?.toString(),
      // 'finishDate': finishDate?.millisecondsSinceEpoch,
    };
  }

  factory ModelMyService.fromMap(Map<String, dynamic> map) {
    return ModelMyService(
      providerName: map['prvd_nm'] ?? '',
      providerId: map['prvd_id'] ?? '',
      prvd_img: map['prvd_img'] ?? '',
      providerDesc: map['prvd_desc'] ?? '',
      city: map['city'] ?? '',
      country: map['cntry'] ?? '',
      isActive: map['active'] ?? false,
      duration: map['duration']?.toDouble(),
      cost: map['cost']?.toDouble(),
      viewCount: map['view_cnt']?.toInt() ?? 0,
      orderCount: map['order_cnt']?.toInt() ?? 0,
      serviceCode: map['service_code'] ?? '',
      createDate: map['crt_dt'] != null
          ? DateTime.parse(map['crt_dt'])
          : null,
      geo: map['geo'] != null
          ? GeoPoint(map['geo']['coordinates'][1].toDouble(), map['geo']['coordinates'][0].toDouble())
          : null,
      startDate: map['strt_dt'] != null
          ? DateTime.parse(map['strt_dt'])
          : null,
      finishDate: map['fnsh_dt'] != null
          ? DateTime.parse(map['fnsh_dt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelMyService.fromJson(String source) =>
      ModelMyService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ModelMyService(providerName: $providerName, providerId: $providerId, prvd_img: $prvd_img, providerDesc: $providerDesc, city: $city, country: $country, isActive: $isActive, duration: $duration, cost: $cost, viewCount: $viewCount, orderCount: $orderCount, serviceCode: $serviceCode, createDate: $createDate, geo: $geo, startDate: $startDate, finishDate: $finishDate)';
  }
}
