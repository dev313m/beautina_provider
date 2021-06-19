import 'package:beautina_provider/models/chat/rooms.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// return # of not read (new) messages
Future<int> getNewMsgCount(List<ModelRoom> rooms) async {
  int newMessages = 0;
  newMessages = await compute(computeNewMessages, rooms);
  return newMessages;
}

int computeNewMessages(List<ModelRoom> list) {
  int newMessages = 0;
  list.forEach((element) {
    if (element.notReadCountProvider != 0)
      newMessages += element.notReadCountProvider;
  });
  return newMessages;
}
