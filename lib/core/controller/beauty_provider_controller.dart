import 'package:beautina_provider/core/global_values/not_responsive/beauty_provider_data.dart';
import 'package:beautina_provider/core/global_values/responsive/beauty_provider_profile.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BeautyProviderController {
  static final ErrUsername = 'username_update_err';
  static final ErrImageUpdate = 'image_update_err';
  static final ErrNotAvailable = 'not_available_update_err';
  static final ErrBookngDefaults = 'default_booking_update_err';
  static final Errlocation = 'location_update_err';
  static final ErrLogout = 'logout_err';
  static final ErrProfileInfo = 'profile_info_update_err';
  storeToken(String token) async {
    await GlobalVarLocalBeautyProvider().storeTokenToLocalDB(token);
  }

  String? getToken() {
    return GlobalVarLocalBeautyProvider().getTokenFromLocalDB();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    getIt.reset();
    await getIt.unregister<ModelBeautyProvider>();
    await GlobalVarLocalBeautyProvider().clearDB();
    await sharedPreferencesLogout();
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

  ModelBeautyProvider getListenable() {
    return Get.find<GlobalValBeautyProviderListenable>().beautyProvider;
  }

  Future initListenableData() async {
    updateListenableVal(getBeautyProviderProfile());
  }
}
