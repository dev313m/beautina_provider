import 'package:beautina_provider/core/db/local/local_db_constants.dart';
import 'package:beautina_provider/core/global_values/not_responsive/hive_box.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:hive/hive.dart';

class BeautyProviderController {
  registerObjFromLocalStorage() {
    getIt.registerSingleton<ModelBeautyProvider>(
        GlobalValHiveBox.getHiveBox().get('beauty_provider'));
  }

  Future storeToLocalDB(ModelBeautyProvider modelBeautyProvider) async {
    await GlobalValHiveBox.getHiveBox()
        .put(LocalDBConstants(), modelBeautyProvider);
  }

  Future<ModelBeautyProvider?> getFromLocalDB() async {
    var box =
        await Hive.openBox<ModelBeautyProvider>('beauty_provider_profile');
    return box.get('profile');
  }

  static ModelBeautyProvider getBeautyProviderProfile() {
    return getIt.get<ModelBeautyProvider>();
  }

  registerObj(ModelBeautyProvider modelBeautyProvider) {
    getIt.registerSingleton<ModelBeautyProvider>(modelBeautyProvider);
  }

  updateBeautyProviderProfile(ModelBeautyProvider modelBeautyProvider) async {
    await getIt.unregister<ModelBeautyProvider>();
    registerObj(modelBeautyProvider);
  }
}
