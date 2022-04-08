import 'dart:io';

import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/**
 * This class is a model for the type Notification
 */

class MyNotification {
  int? _colId;
  String? _title;
  String? _describ;
  String? _createDate = '';
  String? _readDate = '';
  int? _status = 0;
  String? _type;
  String? _icon = '';
  String? _image = '';
  String? from_name;
  String? client_id;
  Timestamp? t;

  MyNotification.empty();
  MyNotification.fromFirebase(Map<String, dynamic> map) {
    _title = map['title'] ?? '';
    _describ = map['describ'] ?? '';
    from_name = map['from_name'] ?? "";
    _createDate = map['create_date']?.toDate().toString() ?? "";
    _type = map['type'] ?? '';
    _icon = map['icon'] ?? '';
    _image = map['image'] ?? "";
  }

  /**
   * Constructur that is build upon Map<String, dynamic>()
   */
  MyNotification.fromMapObject(Map<String, dynamic> map) {
    _colId = map['id'];
    _title = map['title'];
    _describ = map['describ'];
    _createDate = map['create_date'];
    _readDate = map['read_date'];
    _status = map['status'];
    _type = map['type'];
    _icon = map['icon'];
    _image = map['image'];
  }

  /**
   * Setters 
   */

  int? get colId => _colId;

  set colId(int? colId) {
    _colId = colId;
  }

  String? get title => _title;

  set title(String? title) {
    _title = title;
  }

  String? get describ => _describ;

  set describ(String? describ) {
    _describ = describ;
  }

  String? get createDate => _createDate;

  set createDate(String? createDate) {
    _createDate = createDate;
  }

  String? get image => _image;

  set image(String? image) {
    _image = image;
  }

  String? get icon => _icon;

  set icon(String? icon) {
    _icon = icon;
  }

  String? get type => _type;

  set type(String? type) {
    _type = type;
  }

  int? get status => _status;

  set status(int? status) {
    _status = status;
  }

  String? get readDate => _readDate;

  set readDate(String? readDate) {
    _readDate = readDate;
  }

/**
 * 
 * method converter to get mapped value
 */

  Map<String, dynamic> toFirestoreMap() {
    var map = new Map<String, dynamic>();

    map['title'] = _title;
    map['describ'] = _describ;
    map['create_date'] = _createDate;
    map['icon'] = _icon;
    map['image'] = _image;
    map['type'] = _type;
    return map;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _colId;
    map['title'] = _title;
    map['describ'] = _describ;
    map['create_date'] = _createDate;
    map['read_date'] = _readDate;
    map['status'] = _status;
    map['type'] = _type;
    map['icon'] = _icon;
    map['image'] = _image;

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
  DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('notifications')
      .doc(id)
      .get();
  return MyNotification.fromFirebase(querySnapshot.data() as Map<String, dynamic>);
}

Future<String?> getClientId() async {
  ModelBeautyProvider user = await (sharedUserProviderGetInfo() as FutureOr<ModelBeautyProvider>);
  return user.uid;
}

//Load all new notification based on last time as string
Future<List<MyNotification>> dbServerloadAllNewNotification(
    String lastDate) async {
  String? client_id = await getClientId();

  Timestamp date = Timestamp.fromDate(DateTime.parse(lastDate));
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('notifications')
      .where("client_id", isEqualTo: client_id)
      .where('create_date', isGreaterThan: date)
      .orderBy('create_date')
      .get();

  return compute(computeMe, querySnapshot);
}

List<MyNotification> computeMe(QuerySnapshot querySnapshot) {
  return querySnapshot.docs
      .map((item) => MyNotification.fromFirebase(item.data() as Map<String, dynamic>))
      .toList();
}

List<MyNotification> parseNewList(QuerySnapshot? querySnapshot) {
  List<MyNotification> notificationMap = querySnapshot!.docs
      .map((item) => MyNotification.fromFirebase(item.data() as Map<String, dynamic>))
      .toList();

  return notificationMap;
}

/**
 * Get all notifications for the current user
 */
Future<List<MyNotification>> dbServerloadAllNotification() async {
  String? client_id = await getClientId();

  QuerySnapshot? snapshot;

  try {
    snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('client_id', isEqualTo: client_id)
        .orderBy('create_date')
        .get();
  } catch (e) {
    showToast(e.toString());
  }
  return compute(parseNewList, snapshot);
}
