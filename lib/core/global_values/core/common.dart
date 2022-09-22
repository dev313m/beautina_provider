import 'package:get/state_manager.dart';

abstract class NetworkStatefulVar extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isError = RxBool(false);
  RxBool isReady = RxBool(false);
  RxBool isFinishSuccess = RxBool(false);
}
