import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class ModelMessage {
  /// combination of providerUid+|+clientUid
  String key;
  String receiverFirebaseUid;
  String message = '';
  String id;
  DateTime date;
  bool read;
  bool fromProvider; // if 1 then from provider else from sender

  ModelMessage({this.date, this.fromProvider, this.read, this.message});

  ModelMessage.fromFirebase(dynamic message, String id) {
    this.key = message['key'] ?? "";
    this.message = message['msg'] ?? "";
    this.read = message['read'] ?? true;
    this.id = id;
    this.fromProvider = message['from'];
    this.date =
        DateTime.fromMicrosecondsSinceEpoch(message['dt']) ?? DateTime.now();
  }

  Future<Map<String, dynamic>> getMap(String providerId) async {
      var user = await sharedUserProviderGetInfo();
    return {
      "msg": message,
      "key": "$providerId|${user.uid}",
      "read": false, // it must be initialized with false
      "from": false, // it must always be false
      "dt": date.microsecondsSinceEpoch
    };
  }

  /// get providerId to generate key with client uid

  static Future apiCreateMassage(
      ModelMessage message, String chatId, String providerId) async {
    final fb = FirebaseDatabase.instance;
    fb.setPersistenceEnabled(true);

    try {
      await fb
          .reference()
          .child('msg/$chatId/msgs')
          .push()
          .set(await message.getMap(providerId));
      //  await fb.reference().once().then((value) => showToast(value.value.toString())
      //       );

    } catch (e) {
      throw Exception('حدث خطآ ما');
    }
  }

  /// create key for the message and put firebase client uid and provider_uid for security
  static Future apiCreateKeyForMessage(
      String chatId, String providerId, String providerFirebaseUid) async {
    final fb = FirebaseDatabase.instance;
    // fb.setPersistenceEnabled(true);
      var user = await sharedUserProviderGetInfo();
    var key = providerId + "|" + user.uid;

    try {
      await fb.reference().child('msg/$chatId').set({
        'key': key,
        "provider_frbase_uid": providerFirebaseUid,
        "client_frbase_uid": FirebaseAuth.instance.currentUser.uid
      });
      //  await fb.reference().once().then((value) => showToast(value.value.toString())
      //       );

    } catch (e) {
      throw Exception('حدث خطآ ما');
    }
  }

  /// to get list of messages using chatId
  static Stream<List<ModelMessage>> apiMessageStream(String chatId) {
    return FirebaseDatabase.instance
        .reference()
        .child('msg/$chatId')
        // .orderByChild('dt')
        .onValue
        .asyncMap((event) async => getModel(event.snapshot));
  }

  /// to get list of messages if exist using provider uid and client uid
  static dynamic apiMessageStreamByUid(String providerUid, String clientUid) {
    return FirebaseDatabase.instance
        .reference()
        .child('msg')
        .orderByChild('key')
        .equalTo(providerUid + "|" + clientUid)
        // .orderByChild('dt')
        .onValue
        .asyncMap((event) async {
      if (event.snapshot.value == null) return [];
      return getModel(event.snapshot);
    });
  }
}

List<ModelMessage> getModel(DataSnapshot dataSnapshot) {
  if (dataSnapshot == null) return [];
  List<ModelMessage> list = [];
  var messages = dataSnapshot.value.values.first;

  messages['msgs'].forEach((key, value) {
    list.add(ModelMessage.fromFirebase(value, key));
  });
  list.sort((a, b) => (b.date.compareTo(a.date)));
  return list;
}

// Future<List<ModelMessage>> apiGetStreamMessage(String chatId) async {
// var user = await sharedUserGetInfo();

//   final fb = FirebaseDatabase.instance;
//   fb.reference().child(chatId).orderByKey().onValue;
//   return compute(parseNewList, snapshot);
// }
