import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _STRING_VALUE = 'str_version_provider';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    _STRING_VALUE: "1.1.1",
  };

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }
    return _instance;
  }

  String get getStringValue => _remoteConfig.getString(_STRING_VALUE);

  Future initialize() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (e) {
      print("Rmeote Config fetch throttled: $e");
    } catch (e) {
      print("Unable to fetch remote config. Default value will be used");
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: Duration(seconds: 0));
    await _remoteConfig.activateFetched();

    print("string::: $getStringValue");
  }
}
