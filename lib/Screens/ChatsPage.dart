import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Models/GetChatsList.dart';
import 'package:playgroup/Screens/Comments.dart';
import 'package:playgroup/Screens/ConversationList.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/GroupsChat.dart';
import 'package:playgroup/Screens/IndividualsChat.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat_List extends StatefulWidget {
  const Chat_List({Key? key}) : super(key: key);

  @override
  State<Chat_List> createState() => _Chat_ListState();
}

class _Chat_ListState extends State<Chat_List>
    with SingleTickerProviderStateMixin {
  // List<ChatUsers> chatUsers = [
  //   ChatUsers(
  //     name: "Jane Russel",
  //     messageText: "Awesome Setup",
  //     imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
  //     time: "Now",
  //   ),
  //   ChatUsers(
  //     name: "Glady's Murphy",
  //     messageText: "That's Great",
  //     imageURL: "https://randomuser.me/api/portraits/men/1.jpg",
  //     time: "Yesterday",
  //   ),
  // ];

  BuildContext? ctx;

  bool _isLoading = true;

//  var initialCommentCheck = true;
  AnimationController? _animationController;
  IO.Socket? _socket;

  FocusNode msgField = new FocusNode();

  List<ChatListData>? ChatData = [];

  List<String> dateFormate = [];

  // GetChatDatum() {
  //   //AppUtils.showprogress();
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   api.GetChatList(Strings.SelectedChild).then((response) {
  //     print("sts1:${response.status}");
  //     print("res1:${response.data}");
  //     if (response.status == true) {
  //       setState(() {
  //         // AppUtils.dismissprogress();
  //         GetChatData = response.data;
  //         // setState(() {
  //         //   _foundedActivity = GetMarkAvailabilityData!;
  //         // });

  //         _isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  // onSearch3(String search) {
  //   print("Searching for $search");
  //   setState(() {
  //     widget.fromOwnAvail!
  //         ? _foundedActivity = GetMarkAvailabilityData!
  //             .where((user) => user.categoryName!
  //                 .toLowerCase()
  //                 .contains(search.toLowerCase()))
  //             .toList()
  //         : _foundedActivity = AllActivity!
  //             .where((user) => user.categoryName!
  //                 .toLowerCase()
  //                 .contains(search.toLowerCase()))
  //             .toList();
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    print("100");
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initializeSocket());
  }

  void initializeSocket() {
    // initialCommentCheck = true;
    print("id1:${Strings.SelectedChild}");

    print("init state variable assigned--> $initialCommentCheck");
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animationController?.repeat(reverse: true);
    _socket = IO.io(Strings.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'token': Strings.authToken,
        'child_id': Strings.SelectedChild,
        'type': 'chatList',
        'forceNew': false,
      }
    });
    _socket?.connect();
    _socket?.onConnect((_) {
      print('connect');
    });
    print("connection established");
    _socket?.on("connect", (_) {
      print('Connected');
      print("Calling function");
      getChatsList();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();

    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();

    print("dispose variable assigned1--> $initialCommentCheck");
    // Strings.comments = [];
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Strings.appThemecolor,
          //   title: Text("Your Availability"),
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.arrow_back_sharp),
          //   ),
          // ),
          // resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return MarkAvail(newContext);
          }),
        ));
  }

  MarkAvail(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            // backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Mesaages',
                  // textScaleFactor: 1.12,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  print("open");
                  // _key.currentState?.openDrawer();
                },
                icon: ImageIcon(
                  AssetImage("assets/imgs/menu_ver2.png"),
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              actions: [
                IconButton(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  tooltip: 'Search',
                  enableFeedback: true,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(.5),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: (ChatData!.length > 0)
                    ? Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: ChatData!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 16),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        // top: (index == 0)
                                        //     ? BorderSide(
                                        //         color: Theme.of(context).dividerColor)
                                        //     : BorderSide.none,
                                        bottom: BorderSide(
                                            color:
                                                Theme.of(context).dividerColor,
                                            width: 1))),
                                // child: ConversationList(
                                //   id: (ChatData![index].type == "Group-chats")
                                //       ? ChatData![index].id!
                                //       : ChatData![index].childFriendId!,
                                //   name:
                                //       (ChatData![index].type == "Group-chats")
                                //           ? ChatData![index].groupName!
                                //           : ChatData![index].childName ?? '',
                                //   messageText: ChatData![index].message ?? '',
                                //   imageUrl:
                                //       (ChatData![index].type == "Group-chats")
                                //           ? ChatData![index].groupImage!
                                //           : ChatData![index].profile ?? '',
                                //   time: ChatData![index].createdDate!,
                                //   type: ChatData![index].type!,
                                //   isMessageRead: (index == 0 || index == 3)
                                //       ? true
                                //       : false,
                                // )
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            (ChatData![index].type ==
                                                    "Group-chats")
                                                ? Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          maxRadius: 20,
                                                          backgroundImage: (ChatData![
                                                                          index]
                                                                      .groupImage! !=
                                                                  "null")
                                                              ? NetworkImage(Strings
                                                                      .imageUrl +
                                                                  ChatData![
                                                                          index]
                                                                      .groupImage!)
                                                              : AssetImage(
                                                                      "assets/imgs/profile-user.png")
                                                                  as ImageProvider,
                                                        ),
                                                      ),
                                                      Positioned(
                                                          right: 27,
                                                          bottom: 23,
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "assets/imgs/group.png"),
                                                            radius: 8,
                                                          ))
                                                    ],
                                                  )
                                                : CircleAvatar(
                                                    maxRadius: 20,
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage: (ChatData![index]
                                                                    .profile !=
                                                                "null" &&
                                                            ChatData![index]
                                                                    .profile !=
                                                                null)
                                                        ? NetworkImage(
                                                            Strings.imageUrl +
                                                                ChatData![index]
                                                                    .profile!)
                                                        : AssetImage(
                                                                "assets/imgs/profile-user.png")
                                                            as ImageProvider,
                                                  ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  (ChatData![index].type !=
                                                          "Group-chats")
                                                      ? await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                          return Individuals_Chat(
                                                              otherChildId:
                                                                  ChatData![
                                                                          index]
                                                                      .id!,
                                                              name: ChatData![
                                                                      index]
                                                                  .childName!,
                                                              profile:
                                                                  ChatData![
                                                                          index]
                                                                      .profile);
                                                        }))
                                                      : await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                          return Groups_Chat(
                                                              groupId:
                                                                  ChatData![
                                                                          index]
                                                                      .id,
                                                              name: ChatData![
                                                                      index]
                                                                  .groupName,
                                                              profile: ChatData![
                                                                      index]
                                                                  .groupImage!);
                                                        }));
                                                  setState(() {
                                                    // widget.chatList;
                                                    //initializeSocket();
                                                    // initialCommentCheck = true;
                                                    // getComments();
                                                    _socket?.disconnect();
                                                    _socket?.connect();
                                                    _socket?.onConnect((_) {
                                                      print('connect');
                                                    });
                                                    print(
                                                        "connection established");
                                                    _socket?.on("connect", (_) {
                                                      print('Connected');
                                                      print("Calling function");
                                                      getChatsList();
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        (ChatData![index]
                                                                    .type ==
                                                                "Group-chats")
                                                            ? ChatData![index]
                                                                .groupName!
                                                            : ChatData![index]
                                                                    .childName ??
                                                                '',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        ChatData![index]
                                                                .message ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontWeight: true
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        TimeAgo
                                            .calculateTimeDifferenceOfSeconds(
                                                ChatData![index].createdDate!),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: true
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
                    : SizedBox()));
  }

  getChatsList() async {
    print("Getting comments");
    _socket?.on("getchat_list", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("getting inside");
        msgField.unfocus();
        if (_data[0]['child_id'] == Strings.SelectedChild) {
          ChatData = [];
          for (var item in _data) {
            ChatData!.add(ChatListData.fromJson(item));
            print("set state");
            for (int index = 0; index < ChatData!.length; index++) {
              dateFormate.add(DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(ChatData![index].createdDate!)));
            }
          }
        }
        //initialCommentCheck = false;
        _isLoading = false;
        print("Comments fetched changing to false");

        // itemScrollController.jumpTo(index:0);

        msgField.unfocus();

        //  });
      });
    });
  }
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
  });
}
