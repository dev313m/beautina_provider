import 'package:beautina_provider/core/global_values/not_responsive/beauty_provider_data.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class BeautyProviderController {
  storeToken(String token) async {
    await GlobalVarLocalBeautyProvider().storeTokenToLocalDB(token);
  }

  String? getToken() {
    return GlobalVarLocalBeautyProvider().getTokenFromLocalDB();
  }

  /**
  * Get the stored beautyprovider from local DB and put it in the 
  * the global instance
  */
  registerObjFromLocalStorage() async {
    var s = await GlobalVarLocalBeautyProvider().getFromLocalDB();
    getIt.registerSingleton<ModelBeautyProvider>(s!);
  }

  Future storeToLocalDB(ModelBeautyProvider modelBeautyProvider) async {
    await GlobalVarLocalBeautyProvider().storeToLocalDB(modelBeautyProvider);
    updateListenableVal(modelBeautyProvider);
  }

  Future<ModelBeautyProvider?> getFromLocalDB() async {
    return await GlobalVarLocalBeautyProvider().getFromLocalDB();
  }

  static ModelBeautyProvider getBeautyProviderProfile() {
    return getIt.get<ModelBeautyProvider>();
  }

  registerObj(ModelBeautyProvider modelBeautyProvider) {
    if (!getIt.isRegistered<ModelBeautyProvider>())
      getIt.registerSingleton<ModelBeautyProvider>(modelBeautyProvider);
  }

  updateBeautyProviderProfile(ModelBeautyProvider modelBeautyProvider) async {
    await getIt.unregister<ModelBeautyProvider>();
    registerObj(modelBeautyProvider);
    updateListenableVal(modelBeautyProvider);
  }

  Future updateFromRemote() async {
    try {
      ModelBeautyProvider? beautyProviderUpdated =
          await apiLoadOneBeautyProvider();
      if (beautyProviderUpdated != null)
        updateListenableVal(beautyProviderUpdated);
    } catch (e) {
      // showToast(e.toString());
    }
  }

  updateListenableVal(ModelBeautyProvider modelBeautyProvider) {
    Get.find<GlobalValBeautyProviderListenable>().beautyProvider =
        modelBeautyProvider;
  }

  Future initListenableData() async {
    updateListenableVal(getBeautyProviderProfile());
  }
}
