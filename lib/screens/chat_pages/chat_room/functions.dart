import 'package:beautina_provider/models/chat/rooms.dart';

/// show that all messages are read
void cleanNewMessages(String chatId) async {
  await ModelRoom.resetNotRead(chatId);
}
