import 'package:beautina_provider/constants/app_colors.dart';
import 'package:beautina_provider/models/chat/rooms.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/screens/chat_pages/chat_room/index.dart';
import 'package:beautina_provider/screens/chat_pages/rooms/vm/vm_chats_data.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/badge.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class PageChatRooms extends StatefulWidget {
  final providerId;
  final providerToken;
  const PageChatRooms(
      {Key key, @required this.providerId, @required this.providerToken})
      : super(key: key);

  @override
  _PageChatRoomsState createState() => _PageChatRoomsState();
}

class _PageChatRoomsState extends State<PageChatRooms> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.blueOpcity,
        //   actions: [
        //     Center(child: GWdgtTextNavTitle(string: 'الدردشات')),
        //     SizedBox(
        //       width: 50.w,
        //     )
        //   ],
        // ),
        // bottomSheet: Icon(Icons.sanitizer),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusDefault),
                  bottomRight: Radius.circular(radiusDefault)),
              child: Container(
                child: Center(child: GWdgtTextNavTitle(string: 'الدردشات')),
                color: AppColors.blueOpcity,
                height: heightTopBar,
              ),
            ),
            Obx(() {
              List<ModelRoom> listRoom =
                  Get.find<VMChatRooms>().chatRooms.value;

              if (listRoom == null || listRoom.length == 0) return SizedBox();
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  itemCount: listRoom.length,
                  itemBuilder: (_, index) {
                    ModelRoom room = listRoom[index];
                    return InkWell(
                      onTap: () async {
                        var user = await sharedUserProviderGetInfo();
                        Get.to(ChatPageFromChatRooms(
                            room: room, clientUid: user.uid));
                      },
                      child: Card(
                        elevation: 0,
                        borderOnForeground: false,
                        margin: EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage(('assets/images/icon.png')),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GWdgtTextTitle(
                                string: room.clientName,
                                color: Colors.black,
                              ),
                              GWdgtBadgeCircle(
                                number: room.notReadCountProvider,
                              ),
                              // Container(
                              //   height: 40.w,
                              //   width: 40.w,
                              //   child: CircleAvatar(
                              //     backgroundColor: Colors.pink,
                              //     child: Center(
                              //         child: GWdgtTextBadge(
                              //             string:
                              //                 room.notReadCount.toString())),
                              //   ),
                              // )
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: GWdgtTextTitleDesc(
                                  string: room.lastMessage,
                                  color: Colors.black38,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.start,
                                  // textAlign: TextAlign.left,
                                  maxLine: 1,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              GWdgtTextSmall(
                                string: timeago.format(room.lastMessageDate,
                                    locale: 'ar'),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                color: Colors.black87,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
