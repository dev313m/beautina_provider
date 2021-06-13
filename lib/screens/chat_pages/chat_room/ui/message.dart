
import 'package:beautina_provider/models/chat/message.dart';
import 'package:beautina_provider/screens/chat_pages/chat_room/ui/text_message.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Message extends StatelessWidget {
  const Message({
    Key key,
    this.message,
  }) : super(key: key);

  final ModelMessage message;

  @override
  Widget build(BuildContext context) {
    // Widget messageContaint(ModelMessage message) {
    //   switch (message.messageType) {
    //     case ChatMessageType.text:
    //       return TextMessage(message: message);
    //     case ChatMessageType.audio:
    //       return AudioMessage(message: message);
    //     case ChatMessageType.video:
    //       return VideoMessage();
    //     default:
    //       return SizedBox();
    //   }
    // }

    return Padding(
      padding: EdgeInsets.only(
          top: 30.h,
          right: message.fromProvider ? 30.w : 0,
          left: message.fromProvider ? 0 : 30.w),
      child: Row(
          mainAxisAlignment: !message.fromProvider
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (!message.from) ...[

            if (!message.fromProvider)
              Row(
                children: [
                  SizedBox(width: 0.15.sw),
                  GWdgtTextSmall(
                    string: timeago.format(message.date, locale: 'ar'),
                    color: Colors.black,
                  ),
                ],
              ),
            // ],
            Container(
              constraints: BoxConstraints(maxWidth: 0.63.sw),
              // width: 0.63.sw,
              child: TextMessage(
                message: message,
              ),
            ),
            if (message.fromProvider)
              Row(
                children: [
                  MessageStatusDot(status: message.read),
                  GWdgtTextSmall(
                    string: timeago.format(message.date, locale: 'ar'),
                    color: Colors.black,
                  ),
                  SizedBox(width: 0.15.sw),
                ],
              ),
          ]),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final bool status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color dotColor(MessageStatus status) {
    //   switch (status) {
    //     case MessageStatus.not_sent:
    //       return kErrorColor;
    //     case MessageStatus.not_view:
    //       return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
    //     case MessageStatus.viewed:
    //       return kPrimaryColor;
    //     default:
    //       return Colors.transparent;
    //   }
    // }

    return Container(
      // margin: EdgeInsets.only(left: 30.w),
      padding: EdgeInsets.symmetric(horizontal:15.w),
      decoration: BoxDecoration(
        // color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.cloud_done_rounded,
        size: 50.sp,
        color: status == true ? Colors.grey : Colors.grey,
      ),
    );
  }
}
