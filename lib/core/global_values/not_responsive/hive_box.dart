import 'package:beautina_provider/core/db/local/local_db_constants.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:hive/hive.dart';

class GlobalValHiveBox {
  Future init() async {
    getIt.registerSingleton<Box>(
        await Hive.openBox(LocalDBConstants().HIVE_BOX));
  }

  static Box getHiveBox() {
    return getIt<Box>();
  }
}
