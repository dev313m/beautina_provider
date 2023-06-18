import 'package:beautina_provider/core/states/responsive/global_val.dart';

class GlobalValFunController {
  static Future load(
      {required Function load,
      required Function onError,
      required Function onFinally,
      required GlobalValLoad globalVal}) async {
    globalVal.isLoading.value = true;
    globalVal.isError.value = false;
    try {
      await load();
      globalVal.isFinishSuccess.value = true;
      // value = res.obs;
    } catch (e) {
      globalVal.isError.value = true;
    } finally {
      globalVal.isLoading.value = false;
    }
  }
}
