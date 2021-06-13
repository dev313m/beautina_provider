
import 'package:beautina_provider/models/chat/rooms.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class VMChatRooms extends GetxController {
  bool isLoading = true;

  bool isError = false;

  Rx<List<ModelRoom>> chatRooms = Rx<List<ModelRoom>>();
  RxInt newMessages = 0.obs;
  @override
  void onInit() {
    super.onInit();
    init();
  }

  // VMChatRooms() {}

  init() async {
    reset();
    try {
      // final ipa = InstaPublicApi('beautina.app');
      // posts = await ipa.getAllPosts();
      var user = await sharedUserProviderGetInfo();
      chatRooms.bindStream(ModelRoom.apiGetRooms(user.uid));
      chatRooms.listen((value) async {
        newMessages.value = await getNewMsgCount(value);
      });
      isLoading = false;
    } catch (e) {
      isError = true;
    }
    update();
  }

  reset() {
    isError = false;
    isLoading = true;
    update();
  }
}
