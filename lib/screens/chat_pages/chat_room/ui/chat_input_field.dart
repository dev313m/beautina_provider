
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/models/chat/message.dart';
import 'package:beautina_provider/models/chat/rooms.dart';
import 'package:beautina_provider/models/firebase_notification.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInputFieldFromChatRoom extends StatefulWidget {
  final ModelRoom room;
  const ChatInputFieldFromChatRoom({
    Key key,
    @required this.room,
  }) : super(key: key);

  @override
  _ChatInputFieldFromChatRoomState createState() =>
      _ChatInputFieldFromChatRoomState();
}

class _ChatInputFieldFromChatRoomState
    extends State<ChatInputFieldFromChatRoom> {
  var textfield;
  final textFeildCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.sentiment_satisfied_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    // SizedBox(width: 60.w),
                    Expanded(
                      child: TextField(
                        controller: textFeildCtr,
                        maxLines: 4,
                        minLines: 1,
                        // onSubmitted: (ss){},
                        decoration: InputDecoration(
                          hintText: "اكتبي هنا..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.attach_file,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    // SizedBox(width: 20),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 60.w),
            IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () {
                try {
                  var message = ModelMessage(
                    date: DateTime.now(),
                    message: textFeildCtr.text,
                  );
                  ModelMessage.apiCreateMassage(
                      message, widget.room.chatId, widget.room.providerId);

                  ///[todo] send notification
                  textFeildCtr.text = '';
                  setState(() {});
                } catch (e) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatInputField extends StatefulWidget {
  final ModelBeautyProvider beautyProvider;

  /// if true then do create chat rooms and other things for new
  final bool isNewMessage;
  const ChatInputField(
      {Key key, @required this.beautyProvider, this.isNewMessage})
      : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  var textfield;
  String chatId = '';
  final textFeildCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.sentiment_satisfied_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    // SizedBox(width: 60.w),
                    Expanded(
                      child: TextField(
                        controller: textFeildCtr,
                        maxLines: 4,
                        minLines: 1,
                        // onSubmitted: (ss){},
                        decoration: InputDecoration(
                          hintText: "اكتبي هنا..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.attach_file,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    // SizedBox(width: 20),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 60.w),
            IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () async {
                try {
      var user = await sharedUserProviderGetInfo();

                  /// if chatId is already not null
                  if (chatId == "") {
                    /// if new message create chatroom
                    if (widget.isNewMessage) {
                      // create a room
                      var chatRoom = ModelRoom(
                          providerId: widget.beautyProvider.uid,
                          notReadCount: 0,
                          clientId: user.uid,
                          notReadCountProvider: 1,
                          clientName: user.name,
                          clientFirebaseUid:
                              FirebaseAuth.instance.currentUser.uid,
                          providerFirebaseUid:
                              widget.beautyProvider.firebaseUid,
                          lastMessageDate: DateTime.now(),
                          lastMessage: textFeildCtr.text,
                          providerName: widget.beautyProvider.name);
                      chatId = await ModelRoom.apiCreateRoom(chatRoom);
                    }
                    //if not new then set chatId
                    else {
                      chatId = await ModelRoom.getRoomId(
                          clientId: user.uid,
                          providerID: widget.beautyProvider.uid);
                    }
                  }

                  // create a message inside the room using chatId
                  var message = ModelMessage(
                    date: DateTime.now(),
                    message: textFeildCtr.text,
                  );

                  if (widget.isNewMessage)
                    await ModelMessage.apiCreateKeyForMessage(
                        chatId,
                        widget.beautyProvider.uid,
                        widget.beautyProvider.firebaseUid);
                  await ModelMessage.apiCreateMassage(
                      message, chatId, widget.beautyProvider.uid);
                  ModelFirebaseNotification(
                    body: textFeildCtr.text,
                    title: "رساله من ${user.name}",
                    from: user.name,
                    // type: ,
                    token: widget.beautyProvider.token,
                  )..sendPushNotification();
                  textFeildCtr.text = '';
                  setState(() {});

                  ///[todo]
                  /// * send notification
                  /// * update room information
                } catch (e) {
                  String g = e;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
