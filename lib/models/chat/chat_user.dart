import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ModelChatUser {
  String id;
  String firebaseUid;
  DateTime lastSeen;
  String token;

  ModelChatUser({this.id, this.lastSeen, this.token});

  ModelChatUser.fromMap(Map<String, dynamic> data) {
    // this.id = id;
    this.token = data['token'];
    // this.lastSeen =
    //     DateTime.fromMicrosecondsSinceEpoch(data['last_seen']) ?? DateTime.now();
  }

  static Future<String> getUserToken(String uid) async {
    var user =
        await FirebaseDatabase.instance.reference().child("user/$uid").once();
    return user.value["token"];
  }

  ModelChatUser.fromFirebase(
      Map<String, dynamic> data, String id, String token) {
    this.id = id;
    this.token = token;
    this.lastSeen = DateTime.fromMicrosecondsSinceEpoch(data['last_seen']) ??
        DateTime.now();
  }

  // Future<String> getUser(String uid) async{
  //  var user =await FirebaseDatabase.instance.reference().child("user/$uid").once();
  //  user.
  // }

  Map<String, dynamic> toMap() {
    return {"last_seen": DateTime.now().microsecondsSinceEpoch, "token": token};
  }

  static Future apiCreateChatUser(String token) async {
    final fb = FirebaseDatabase.instance;
    fb.setPersistenceEnabled(true);

    try {
      var user = await sharedUserProviderGetInfo();
      var reference = fb.reference().child('user/${user.uid}');
      // await storeUserChatId(reference.key);
      var firebaseUser = FirebaseAuth.instance.currentUser.uid;
      await reference.set({
        "last_seen": DateTime.now().microsecondsSinceEpoch,
        "token": token,
        "frbase_uid": firebaseUser
      });
      //  await fb.reference().once().then((value) => showToast(value.value.toString())
      //       );

    } catch (e) {
      throw Exception('حدث خطآ ما');
    }
  }

  static updateLastSeen({String userChatId}) async {
    final fb = FirebaseDatabase.instance;
    fb.setPersistenceEnabled(true);

    try {
      fb
          .reference()
          .child('user$userChatId')
          .update({"last_seen": DateTime.now().microsecondsSinceEpoch});
    } catch (e) {
      throw Exception("User not updated $e");
    }
  }

  // static Future storeUserChatId(String chatId) async {
  //   var user = await sharedUserGetInfo();
  //   sharedUserSet(user..chatId = chatId);
  // }
}
