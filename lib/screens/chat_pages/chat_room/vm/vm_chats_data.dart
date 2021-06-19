import 'package:beautina_provider/models/chat/chat_user.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class VMChatRoomData extends GetxController {
  String userToken = "";

  // VMChatRoomData() {
  //   init();
  // }

  Future<String> getToken(String uid) async {
    try {
      if (userToken == "") userToken = await ModelChatUser.getUserToken(uid);
      return userToken;
    } catch (e) {
      return userToken = "";
    }
  }
}
