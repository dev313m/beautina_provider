
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/models/chat/message.dart';
import 'package:beautina_provider/models/chat/rooms.dart';
import 'package:beautina_provider/screens/chat_pages/chat_room/functions.dart';
import 'package:beautina_provider/screens/chat_pages/chat_room/ui/chat_input_field.dart';
import 'package:beautina_provider/screens/chat_pages/chat_room/ui/message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPageFromChatRooms extends StatefulWidget {
  final ModelRoom room;
  final String clientUid;
  const ChatPageFromChatRooms({
    Key key,
    this.room,
    @required this.clientUid,
  }) : super(key: key);
  @override
  _ChatPageFromChatRoomsState createState() => _ChatPageFromChatRoomsState();
}

class _ChatPageFromChatRoomsState extends State<ChatPageFromChatRooms> {
  var messageCount = 0;
  @override
  void initState() {
    super.initState();

    cleanNewMessages(widget.room.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: StreamBuilder(
                      stream: ModelMessage.apiMessageStream(widget.room.chatId),
                      builder: (_, snapshot) {
                        if (snapshot.hasData && snapshot.data != null)
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              // if(Message)
                              //
                              return Message(message: snapshot.data[index]);
                              // return snapshot.data[index];
                            },
                          );
                        return SizedBox();
                      },
                    )),
              ),
              ChatInputFieldFromChatRoom(
                room: widget.room,
              ),
            ],
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon.png"),
          ),
          SizedBox(width: 20 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.room.providerName,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        // IconButton(
        //   icon: Icon(Icons.videocam),
        //   onPressed: () {},
        // ),
        SizedBox(width: 20 / 2),
      ],
    );
  }
}

class ChatPage extends StatefulWidget {
  final String clientUid;

  /// it false means chat room is exist and known, if true means search if chat even exist
  final ModelBeautyProvider beautyProvider;
  const ChatPage({
    Key key,
    @required this.clientUid,
    @required this.beautyProvider,
  }) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messageCount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          body: StreamBuilder(
            stream: ModelMessage.apiMessageStreamByUid(
                widget.beautyProvider.uid, widget.clientUid),
            builder: (_, snapshot) {
              if (snapshot.hasData && snapshot.data != null)
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          // if(Message)
                          //
                          return Message(
                              message: snapshot.data[index]);
                          // return snapshot.data[index];
                        },
                      ),
                    ),
                    ChatInputField(
                      beautyProvider: widget.beautyProvider,
                      isNewMessage: snapshot.data.length==0? true:false,
                    ),
                  ],
                );
              return SizedBox();
            },
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon.png"),
          ),
          SizedBox(width: 20 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.beautyProvider.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        // IconButton(
        //   icon: Icon(Icons.videocam),
        //   onPressed: () {},
        // ),
        SizedBox(width: 20 / 2),
      ],
    );
  }
}
