import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class ModelRoom {
  // "customer_name":"customer_name",
  // "provider_id":"providerid",
  // "provider_name":"providername",
  // "chat_id":"id",
  // "talking_with": "someid",
  // "last_message": "last message",
  // "last_message_date": "date",
  // "read": true

  String clientId;
  String clientName;
  String providerId;
  String providerName;
  DateTime lastMessageDate;
  String lastMessage;
  int notReadCount;
  int notReadCountProvider;
  String chatId;
  String clientFirebaseUid;
  String providerFirebaseUid;

  ModelRoom(
      {this.lastMessage,
      this.lastMessageDate,
      this.providerId,
      this.providerName,
      this.notReadCountProvider,
      this.notReadCount,
      this.clientFirebaseUid,
      this.providerFirebaseUid,
      this.clientId,
      this.chatId,
      this.clientName});

  ModelRoom.fromMap(dynamic map, String chatId) {
    lastMessage = map['last_msg'];
    lastMessageDate = DateTime.fromMicrosecondsSinceEpoch(map['last_msg_date']);
    providerId = map['provider_id'];
    providerName = map['provider_name'];
    notReadCount = map['msg_client_count'];
    clientName = map['client_name'];
    providerFirebaseUid = map['client_frbase_uid'];
    clientId = map["client_id"];
    notReadCountProvider = map['msg_provider_count'];
    this.chatId = chatId;
    clientFirebaseUid = map["client_frbase_uid"];
  }

  Map<String, dynamic> getMapForFirebase() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['last_msg'] = this.lastMessage;
    map['last_msg_date'] = this.lastMessageDate.microsecondsSinceEpoch;
    map['provider_id'] = this.providerId;
    map['provider_name'] = this.providerName;
    map['msg_client_count'] = this.notReadCount;
    map['client_id'] = this.clientId;
    map['client_name'] = this.clientName;
    map['msg_provider_count'] = this.notReadCountProvider;
    map['key'] = this.providerId + "|" + this.clientId;
    map['client_frbase_uid'] = this.clientFirebaseUid;
    map['provider_frbase_id'] = this.providerFirebaseUid;
    return map;
  }

  static Future<String> apiCreateRoom(ModelRoom modelChatRoom) async {
    final fb = FirebaseDatabase.instance;
    try {
      var reference = fb.reference().child('room').push();

      await reference.set(modelChatRoom.getMapForFirebase());
      return reference.key;
      //  await fb.reference().once().then((value) => showToast(value.value.toString())
      //       );
    } catch (e) {
      throw Exception('حدث خطآ ما');
    }
  }

  static Stream<List<ModelRoom>> apiGetRooms(String providerId) {
    final fb = FirebaseDatabase.instance;
    try {
      return fb
          .reference()
          .child("room")
          .orderByChild('provider_id')
          .equalTo(providerId)
          .onValue
          .asyncMap((event) async => await compute(getModel, event.snapshot));
    } catch (e) {
      throw Exception('حدث خطآ ما');
    }
  }

  /// update lastmessage, lastmaessagedate and not read for provider, it should be used after creating a message
  static Future updateRoomDetails(
      {String chatId, String lastMessage = ""}) async {
    final fb = FirebaseDatabase.instance;

    var body;
    if (lastMessage == "")
      body = {"msg_provider_count": 0};
    else
      body = {
        "msg_provider_count": 0,
        "last_msg": lastMessage,
        "last_msg_date": DateTime.now().microsecondsSinceEpoch
      };
    try {
      await fb.reference().child('room/$chatId').update(body);
    } catch (e) {
      throw Exception(e.toString());
    }
    return;
  }

  static Future<String> getRoomId({String clientId, String providerID}) async {
    final fb = FirebaseDatabase.instance;

    final key = providerID + "|" + clientId;

    try {
      var result = await fb
          .reference()
          .child('room')
          .orderByChild('key')
          .equalTo(key)
          .once();
      Map map = result.value;

      return map.keys.first;
    } catch (e) {
      throw Exception(e);
    }
  }
}

List<ModelRoom> getModel(DataSnapshot dataSnapshot) {
  if (dataSnapshot == null) return [];
  List<ModelRoom> list = [];
  dataSnapshot.value.forEach((key, value) {
    list.add(ModelRoom.fromMap(value, key));
  });
  return list;
}
