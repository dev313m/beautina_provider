import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ErrorController {
  static final unableToLoginError = 'unable_to_login';

  var r;
  var e;

  static logError(
      {required Object exception,
      Iterable<Object>? info,
      required String eventName}) async {
    await FirebaseCrashlytics.instance
        .setCustomKey(eventName, exception.toString());
    await FirebaseCrashlytics.instance.recordError(
      exception,
      null,
      fatal: false,
    );
  }
}
