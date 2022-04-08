import 'package:get/state_manager.dart';
import 'package:get/get.dart';

abstract class AsyncApiGetx<T> extends GetxController {
  final Future<T> api;
  Rx<T> value;
  RxBool isLoading = RxBool(false);
  RxBool isError = RxBool(false);
  AsyncApiGetx({required this.api, required this.value});

  @override
  void onInit() {
    super.onInit();
    loadApi();
  }

  loadApi() async {
    isLoading.value = true;
    isError.value = false;
    try {
      value.value = await api;
      // value = res.obs;
    } catch (e) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
