import 'dart:io';
import 'package:beautina_provider/blocks/constants/app_colors.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/controller/push_notification.dart';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/models/user.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    this.avatarColor,
    required this.room,
  }) : super(key: key);

  final types.Room room;
  final Color? avatarColor;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id,
            BeautyProviderController.getBeautyProviderProfile().uid!);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id,
            BeautyProviderController.getBeautyProviderProfile().uid!);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  _onMessageVisible(types.Message message, bool visibleChanges) {
    String authorId = FirebaseAuth.instance.currentUser!.uid;
    if (visibleChanges &&
        message.status != types.Status.seen &&
        message.author.id != authorId) {
      var ms = message.copyWith(status: types.Status.seen);
      FirebaseChatCore.instance.updateMessage(
          message.copyWith(status: types.Status.seen), widget.room.id);
      _updateLastMessageToSeen(
        widget.room,
        message,
      );
    }
  }

  _updateLastMessageToSeen(types.Room room, types.Message message) async {
    await FirebaseChatCore.instance.updateRoom(
      room.copyWith(lastMessages: [
        room.lastMessages!.first.copyWith(status: types.Status.seen)
      ]),
      false,
    );
  }

  _updateReplaceRoomLastMessage(types.Room room, types.Message message) async {
    await FirebaseChatCore.instance.updateRoom(
      room.copyWith(
          lastMessages: [message],
          updatedAt: DateTime.now().millisecondsSinceEpoch),
      true,
    );
  }

  void _handleSendPressed(types.PartialText message) async {
    try {
      types.Message? messageMap = await FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
          BeautyProviderController.getBeautyProviderProfile().uid!);
      _updateReplaceRoomLastMessage(widget.room, messageMap!);

      final notiCntr = PushNotificationController();
      String token = '';
      try {
        widget.room.users[0].id ==
                BeautyProviderController.getBeautyProviderProfile().uid
            ? widget.room.users[1].metadata!['token']
            : widget.room.users[0].metadata?['token'];
      } catch (e) {}

      if (token != "") notiCntr.send(message: message.text, token: token);
      // final pushCntr = PushNotificationController();
      // pushCntr.send(
      //     message: message.text,
      //     token: widget.room.users.last.metadata?['token']);
      // widget.room.users;
    } catch (e) {}
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Row(
          children: [
            _buildAvatar(widget.room),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.room.name!),
              ],
            ),
          ],
        ),
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Chat(
                  showUserAvatars: false,
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleAtachmentPressed,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  usePreviewData: true,
                  theme: DarkChatTheme(backgroundColor: AppColors.purpleColor),
                  onMessageVisibilityChanged: _onMessageVisible,
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAvatar(types.Room room) {
    var color = widget.avatarColor;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != FirebaseAuth.instance.currentUser!.uid,
        );

        // color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage =
        BeautyProviderController.getBeautyProviderProfile().image != '';
    final name = room.name ?? '';

    return Hero(
      tag: 'chat${widget.room.id}',
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: CircleAvatar(
          backgroundColor: hasImage ? Colors.transparent : color,
          backgroundImage: hasImage
              ? FirebaseImage(FIREBASE_STORAGE_URL +
                  BeautyProviderController.getBeautyProviderProfile().uid!)
              : null,
          radius: 22,
          child: !hasImage
              ? Text(
                  name.isEmpty ? '' : name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final double barHeight = 50.0;
  MainAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 100.0);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: ClipPath(
          clipper: WaveClip(),
          child: Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                title,
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight + 100));
  }
}
