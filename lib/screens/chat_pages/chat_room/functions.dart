import 'package:beautina_provider/models/chat/rooms.dart';

/// show that all messages are read
void updateRoomDetails({String chatId, String lastMessage}) async {
  await ModelRoom.updateRoomDetails(chatId:chatId);
}
