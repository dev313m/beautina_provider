import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

/**
 * This class is a model for the type Notification
 */

enum NotificationType { chatMessage, broadcast, orderStatus, other }

enum NotificationStatus { notRead, read }

class MyNotification {
  int? colId;
  String? title;
  String? describ;
  String? createDate = '';
  String? readDate = '';
  NotificationStatus? status = NotificationStatus.notRead;
  NotificationType? type;
  String? icon = '';
  String? image = '';
  String? from_name;
  String? client_id;
  Timestamp? t;

  String? token;
  NotificationType typeStringToEnum(String? typeName) {
    if (typeName == null) return NotificationType.other;
    switch (typeName) {
      case "chatMessage":
        return NotificationType.chatMessage;
      case "broadcast":
        return NotificationType.broadcast;
      case "orderStatus":
        return NotificationType.orderStatus;
      default:
        return NotificationType.other;
    }
  }

  NotificationStatus statusToEnum(String? status) {
    if (status == null) return NotificationStatus.read;
    switch (status) {
      case "read":
        return NotificationStatus.read;
      case "not_read":
        return NotificationStatus.notRead;
      default:
        return NotificationStatus.notRead;
    }
  }

  MyNotification.empty();
  MyNotification.toFireStore({
    required this.token,
    required this.describ,
    required this.title,
    required this.type,
    required this.createDate,
  });
  MyNotification.fromFirebase(Map<String, dynamic> map) {
    title = map['title'] ?? '';
    describ = map['describ'] ?? '';
    from_name = map['from_name'] ?? "";
    createDate = map['create_date']?.toDate().toString() ?? "";
    type = typeStringToEnum(map['type']);
    icon = map['icon'] ?? '';
    image = map['image'] ?? "";
  }

  /**
   * Constructur that is build upon Map<String, dynamic>()
   */
  MyNotification.fromMapObject(Map<String, dynamic> map) {
    colId = map['id'];
    title = map['title'];
    describ = map['describ'];
    createDate = map['create_date'];
    readDate = map['read_date'];
    status = statusToEnum(map['status']);
    type = typeStringToEnum(map['type']);
    icon = map['icon'];
    image = map['image'];
  }

  /**
   * Setters 
   */

/**
 * 
 * method converter to get mapped value
 */

  Map<String, String> toFirestoreMap() {
    var map = new Map<String, String>();

    map['title'] = title ?? '';
    map['describ'] = describ ?? '';
    map['create_date'] = createDate ?? '';
    map['icon'] = icon ?? '';
    map['image'] = image ?? '';
    map['type'] = type?.name ?? ' ';
    return map;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = colId;
    map['title'] = title;
    map['describ'] = describ;
    map['create_date'] = createDate;
    map['read_date'] = readDate;
    map['status'] = status?.name;
    map['type'] = type?.name;
    map['icon'] = icon;
    map['image'] = image;

    return map;
  }
}

MyNotification parse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  List<MyNotification> list = parsed
      .map<MyNotification>((json) => MyNotification.fromFirebase(json))
      .toList();
  return list[0];
}

/**
 *
 * This one is to get a specific notification where in my case 
 * a notification comes from adding a notification 
 */
Future<MyNotification> dbServerloadNotification(String id) async {
  DocumentSnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection('notifications')
      .doc(id)
      .get();
  var data = MyNotification.fromFirebase(
      querySnapshot.data()!['list'] as Map<String, dynamic>);

  return data;
}

Future<String?> getClientId() async {
  ModelBeautyProvider user =
      BeautyProviderController.getBeautyProviderProfile();
  return user.uid;
}

//Load all new notification based on last time as string
Future<List<MyNotification>> dbServerloadAllNewNotification(
    String lastDate) async {
  try {
    String? client_id = await getClientId();

    Timestamp date = Timestamp.fromDate(DateTime.parse(lastDate));
    QuerySnapshot<Map<String, dynamic>>? querySnapshot = await FirebaseFirestore
        .instance
        .collection('notifications')
        .where("client_id", isEqualTo: client_id)
        .where('create_date', isGreaterThan: date)
        .orderBy('create_date')
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> g = querySnapshot.docs;

    List<MyNotification> s = await compute(parseNewList, g);
    return s;
  } catch (e) {
    throw Exception("notification not loaded");
  }
}

List<MyNotification> computeMe(
    QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  return querySnapshot.docs
      .map((item) => MyNotification.fromFirebase(item.data()))
      .toList();
}

List<MyNotification> parseNewList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot) {
  List<MyNotification> notificationMap = querySnapshot
      .map((item) => MyNotification.fromFirebase(item.data()))
      .toList();

  return notificationMap;
}

/**
 * Get all notifications for the current user
 */
Future<List<MyNotification>> dbServerloadAllNotification() async {
  String? client_id = await getClientId();

  QuerySnapshot<Map<String, dynamic>>? snapshot;

  try {
    snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('client_id', isEqualTo: client_id)
        .orderBy('create_date')
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> g = snapshot.docs;

    List<MyNotification> s = await compute(parseNewList, g);
    return s;
  } catch (e) {
    showToast(e.toString());
    return [];
  }
}
