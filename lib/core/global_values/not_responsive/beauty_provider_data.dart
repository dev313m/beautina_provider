import 'package:beautina_provider/core/db/local/local_db_constants.dart';
import 'package:beautina_provider/core/global_values/not_responsive/hive_box.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GlobalVarLocalBeautyProvider {
  Future storeToLocalDB(ModelBeautyProvider modelBeautyProvider) async {
    await GlobalValHiveBox.getHiveBox()
        .put(LocalDBConstants().HIVE_BEAUTY_PROVIDER, modelBeautyProvider);
  }

  Future<ModelBeautyProvider?> getFromLocalDB() async {
    try {
      var s = await GlobalValHiveBox.getHiveBox()
          .get(LocalDBConstants().HIVE_BEAUTY_PROVIDER);

      return s;
    } catch (e) {
      // var g;
    }
  }

  Future storeTokenToLocalDB(String token) async {
    await GlobalValHiveBox.getHiveBox().put(LocalDBConstants().TOKEN, token);
  }

  String? getTokenFromLocalDB() {
    try {
      String s = GlobalValHiveBox.getHiveBox().get(LocalDBConstants().TOKEN);

      return s;
    } catch (e) {
      var g;
    }
  }
}
