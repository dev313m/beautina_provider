import 'package:beautina_provider/blocks/constants/app_colors.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/services/constants/api_config.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import '../screens/salon/ui/profile_details.dart';
import 'chat.dart';
import 'util.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoomsPage extends StatefulWidget {
  const RoomsPage({
    Key? key,
  }) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool _error = false;
  bool _initialized = false;
  User? _user;
  Color? avatarColor;
  @override
  void initState() {
    initializeFlutterFire();

    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
        avatarColor = color;
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage =
        BeautyProviderController.getBeautyProviderProfile().image != '';
    final name = room.name ?? '';

    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.purpleColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                // height: ScreenUtil().setHeight(ConstRootSizes.topContainer),
                decoration: BoxDecoration(
                    color: colorContainerBg,
                    borderRadius: BorderRadius.circular(radiusDefault)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Y(
                      height: heightBottomContainer,
                    ),
                    Center(
                        child: GWdgtTextTitle(
                      string: ' المحادثات',
                    )),
                    Y(),
                    Hero(
                      tag: 'chatRoom',
                      child: Icon(
                        CupertinoIcons.chat_bubble_2,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    // GWdgtTextTitleDesc(
                    //   string: 'قائمة المحادثات ',
                    // ),
                    Y(
                      height: heightBottomContainer,
                    )
                  ],
                ),
              ),
              _user == null
                  ? Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        bottom: 200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not authenticated'),
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     fullscreenDialog: true,
                              //     builder: (context) => const LoginPage(),
                              //   ),
                              // );
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    )
                  : StreamBuilder<List<types.Room>>(
                      stream: FirebaseChatCore.instance.rooms(),
                      initialData: const [],
                      builder: (context, snapshot) {
                        var user = FirebaseAuth.instance.currentUser;
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              bottom: 200,
                            ),
                            child: const Text('...'),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          // itemExtent: heightNavBar,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var room = snapshot.data![index];

                            var lastMessage = room.lastMessages?.first;
                            if (lastMessage?.type == types.TextMessage)
                              lastMessage = lastMessage as types.TextMessage;
                            else if (lastMessage?.type == types.ImageMessage)
                              lastMessage = lastMessage as types.ImageMessage;

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      avatarColor: avatarColor,
                                      room: room,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                // margin: EdgeInsets.only(
                                //   left: 20,
                                //   right: 20,
                                // ),
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(10),
                                //   //color: Colors.white
                                //   border: Border.all(
                                //     color: Colors.white10,
                                //     width: 2,
                                //   ),
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      // width: MediaQuery.of(context).size.width * 0.13,
                                      // height: MediaQuery.of(context).size.width * 0.13,
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(30),
                                      //     color: Colors.indigoAccent[700]),
                                      child: Hero(
                                          tag: 'chat${room.id}',
                                          child: _buildAvatar(room)),
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 15, left: 10),
                                          child: Row(
                                            //crossAxisAlignment: CrossAxisAlignment.end,
                                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                room.name!,
                                                style: TextStyle(
                                                    fontFamily: "RobotoBold",
                                                    color: Colors.grey[200],
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (lastMessage is types.TextMessage)
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 10),
                                            child: Text(
                                              lastMessage.text,
                                              style: TextStyle(
                                                  fontFamily: "RobotoMedium",
                                                  color: Colors.grey[400],
                                                  fontSize: 15),
                                            ),
                                          )
                                        else if (lastMessage
                                            is types.ImageMessage)
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Icon(
                                                  CupertinoIcons.photo_fill))
                                        else
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 10),
                                              child: Icon(
                                                  CupertinoIcons.link_circle))
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(children: [
                                        if (room.updatedAt != null)
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 60, top: 15),
                                            child: Text(
                                              timeago.format(
                                                  Timestamp
                                                          .fromMillisecondsSinceEpoch(
                                                              room.updatedAt!)
                                                      .toDate()
                                                      .toLocal(),
                                                  allowFromNow: true,
                                                  clock: DateTime.now(),
                                                  locale: 'ar'),
                                              style: TextStyle(
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                        if (lastMessage is types.TextMessage ||
                                            lastMessage is types.ImageMessage)
                                          Visibility(
                                            visible: lastMessage?.status !=
                                                    types.Status.seen &&
                                                FirebaseAuth.instance
                                                        .currentUser!.uid !=
                                                    lastMessage?.author.id,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 70, top: 10),
                                              child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: 15,
                                                    color: AppColors.pinkBright,
                                                  )),
                                            ),
                                          ),
                                      ]),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainChat extends StatefulWidget {
  const MainChat({Key? key}) : super(key: key);

  @override
  _MainChatState createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: Text(
          'Chats',
          style: TextStyle(fontFamily: "RobotoMedium"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   // return DetailChat();
              // }));
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Container(
        color: Colors.black54,
        child: Stack(children: [
          ListView(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                //padding: EdgeInsets.all(),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontFamily: "RobotoMedium",
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.white
                  border: Border.all(
                    color: Colors.white10,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.13,
                      height: MediaQuery.of(context).size.width * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: Colors.white
                      ),
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image(
                            image: AssetImage("assets/RoseProfil.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.greenAccent[400],
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                          ),
                        ),
                      ]),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 10),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                " Roseane Park",
                                style: TextStyle(
                                    fontFamily: "RobotoBold",
                                    color: Colors.grey[200],
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            " Sure we are going to lea...",
                            style: TextStyle(
                                fontFamily: "RobotoMedium",
                                color: Colors.grey[400],
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, bottom: 20),
                      child: Text(
                        " 14.23",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.white
                  border: Border.all(
                    color: Colors.white10,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.13,
                      height: MediaQuery.of(context).size.width * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.indigoAccent[700]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                              child: Text(
                            "EB",
                            style: TextStyle(
                                fontFamily: "RobotoBold", color: Colors.white),
                          ))),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 10),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                " Edwar Boy",
                                style: TextStyle(
                                    fontFamily: "RobotoBold",
                                    color: Colors.grey[200],
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            " Hi Ahmed! How's are you?",
                            style: TextStyle(
                                fontFamily: "RobotoMedium",
                                color: Colors.grey[400],
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 60, top: 15),
                        child: Text(
                          " 8.42",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 70, top: 10),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: Center(
                              child: Text(
                            "1",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.white
                  border: Border.all(
                    color: Colors.white10,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.13,
                      height: MediaQuery.of(context).size.width * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.indigoAccent[700]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                              child: Text(
                            "SA",
                            style: TextStyle(
                                fontFamily: "RobotoBold", color: Colors.white),
                          ))),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 10),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                " Shabrina A",
                                style: TextStyle(
                                    fontFamily: "RobotoBold",
                                    color: Colors.grey[200],
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            " Am contacting you beca...",
                            style: TextStyle(
                                fontFamily: "RobotoMedium",
                                color: Colors.grey[400],
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 50, top: 15),
                        child: Text(
                          " 10.00",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 70, top: 10),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: Center(
                              child: Text(
                            "3",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.group_outlined,
                          size: 30,
                          color: Colors.white,
                        )),
                  ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Chat",
                          style: TextStyle(
                              fontFamily: "RobotoMedium",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                        )
                      ]),
                  Column(children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings_outlined,
                          size: 30,
                          color: Colors.white,
                        )),
                  ]),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
