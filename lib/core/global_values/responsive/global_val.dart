import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GlobalValLoad<T> extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isError = RxBool(false);
  RxBool isReady = RxBool(false);
  RxBool isFinishSuccess = RxBool(false);
}
