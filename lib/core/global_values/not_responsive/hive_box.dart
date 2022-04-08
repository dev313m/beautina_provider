import 'package:beautina_provider/core/main_init.dart';
import 'package:hive/hive.dart';

class GlobalValHiveBox {
  final boxName = 'Banafsaj_storage';

  init() async {
    getIt.registerSingleton<Box>(await Hive.openBox(boxName));
  }

  static Box getHiveBox() {
    return getIt<Box>();
  }
}
