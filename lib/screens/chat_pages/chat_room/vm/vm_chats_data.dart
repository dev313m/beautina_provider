import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class VMFeedData extends GetxController {
  bool isLoading = true;

  bool isError = false;
  
  VMFeedData() {
    init();
  }

  init() async {
    reset();
    try {
      // final ipa = InstaPublicApi('beautina.app');
      // posts = await ipa.getAllPosts(); 

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
