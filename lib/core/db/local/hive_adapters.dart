import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:hive/hive.dart';

class HiveAdapters {
  static init() async {
    Hive.registerAdapter(ModelBeautyProviderAdapter());
  }
}
