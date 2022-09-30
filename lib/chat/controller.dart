import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class ChatController {
  int unReadNotiCount() {
    VMRootDataTest vmRootData = Get.find<VMRootDataTest>();
    int count = vmRootData.notificationList
        .where(
            (element) => element.type == 'chat_message' && element.status == 0)
        .toList()
        .length;
    return count;
  }

  Future checkAndCreate() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      ModelBeautyProvider _beautyPrvdr =
          BeautyProviderController.getBeautyProviderProfile();

      var doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!doc.exists)
        await FirebaseChatCore.instance.createUserInFirestore(types.User(
            id: uid,
            // createdAt: DateTime.now().microsecondsSinceEpoch,
            firstName: _beautyPrvdr.name,
            imageUrl: FIREBASE_STORAGE_URL + _beautyPrvdr.uid!,
            lastName: '',
            metadata: {
              'token': BeautyProviderController.getBeautyProviderProfile().token
            },
            // lastSeen: DateTime.now().microsecondsSinceEpoch,
            // updatedAt: DateTime.now().microsecondsSinceEpoch,
            role: types.Role.admin));
    } catch (e) {
      throw Exception('There is a problem with the chat');
    }
  }
}
