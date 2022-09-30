import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/db/notification.dart';
import 'package:beautina_provider/models/notification.dart';

class PushNotificationController {
  Future send({required String message, required String token}) async {
    DBNotification().send(
        data: MyNotification.toFireStore(
                token: token,
                describ: message,
                createDate: DateTime.now().toString(),
                type: NotificationType.chatMessage,
                title:
                    'رسالة من ${BeautyProviderController.getBeautyProviderProfile().name!}')
            .toFirestoreMap(),
        token: token);
  }
}
