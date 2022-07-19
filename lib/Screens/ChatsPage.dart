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

  List<ChatListData>? ChatData;

  List<String> dateFormate = [];

  DateFormat df = new DateFormat('dd-MMM-yy : kk:mm');

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  List<ChatListData>? _foundedChatList = [];

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

  onSearch(String search) {
    print("Searching for $search");
    setState(() {
      _foundedChatList = ChatData!
          .where((user) =>
              user.childName!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
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
              // centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 1,
              //       title: isSearch?Align(
              //         alignment: Alignment.center,
              //         child: Text(
              //           'Mesaages',
              //           // textScaleFactor: 1.12,
              //           style: TextStyle(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 18,
              //               color: Colors.black),
              //         ),
              //       ):appBarTitle,
              //       leading:
              //           // IconButton(
              //           //   onPressed: () {
              //           //     print("open");
              //           //     // _key.currentState?.openDrawer();
              //           //   },
              //           //   icon: ImageIcon(
              //           //     AssetImage("assets/imgs/back.png"),
              //           //     color: Colors.black.withOpacity(.5),
              //           //   ),
              //           // ),
              //           IconButton(
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //         icon: Icon(
              //           Icons.arrow_back_sharp,
              //           color: Colors.black54,
              //         ),
              //       ),
              //       actions: [
              //         IconButton(
              //           color: Theme.of(context).iconTheme.color!.withOpacity(.5),
              //           tooltip: 'Search',
              //           enableFeedback: true,
              //           icon: Icon(
              //             Icons.search,
              //             color: Colors.black.withOpacity(.5),
              //           ),
              //           onPressed: () {
              //   setState(() {
              //              if ( this.actionIcon.icon == Icons.search){
              //               this.actionIcon = new Icon(Icons.close);
              //               this.appBarTitle = new TextField(
              //                 style: new TextStyle(
              //                   color: Colors.white,

              //                 ),
              //                 decoration: new InputDecoration(
              //                   prefixIcon: new Icon(Icons.search,color: Colors.white),
              //                   hintText: "Search...",
              //                   hintStyle: new TextStyle(color: Colors.white)
              //                 ),
              //               );}
              //               else {
              //                 appBarTitle = new Text("AppBar Title");
              //               }

              //             });},
              //         ),
              //       ],

              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black54,
                ),
              ),
              title: _isSearching
                  ? _buildSearchField()
                  : Align(
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
              actions: _buildActions(),
            ),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: (_foundedChatList!.length > 0)
                    ? Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: _foundedChatList!.length,
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
                                            (_foundedChatList![index].type ==
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
                                                          backgroundImage: (_foundedChatList![
                                                                          index]
                                                                      .groupImage! !=
                                                                  "null")
                                                              ? NetworkImage(Strings
                                                                      .imageUrl +
                                                                  _foundedChatList![
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
                                                    backgroundImage: (_foundedChatList![
                                                                        index]
                                                                    .profile !=
                                                                "null" &&
                                                            _foundedChatList![
                                                                        index]
                                                                    .profile !=
                                                                null)
                                                        ? NetworkImage(Strings
                                                                .imageUrl +
                                                            _foundedChatList![
                                                                    index]
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
                                                  (_foundedChatList![index]
                                                              .type !=
                                                          "Group-chats")
                                                      ? await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                          return Individuals_Chat(
                                                              otherChildId:
                                                                  _foundedChatList![
                                                                          index]
                                                                      .id!,
                                                              name: _foundedChatList![
                                                                      index]
                                                                  .childName!,
                                                              profile:
                                                                  _foundedChatList![
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
                                                                  _foundedChatList![
                                                                          index]
                                                                      .id,
                                                              name:
                                                                  _foundedChatList![
                                                                          index]
                                                                      .groupName,
                                                              profile:
                                                                  _foundedChatList![
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
                                                        (_foundedChatList![
                                                                        index]
                                                                    .type ==
                                                                "Group-chats")
                                                            ? _foundedChatList![
                                                                    index]
                                                                .groupName!
                                                            : _foundedChatList![
                                                                        index]
                                                                    .childName ??
                                                                '',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      (_foundedChatList![index]
                                                                  .type ==
                                                              "Group-chats")
                                                          ? Row(
                                                              children: [
                                                                Text(
                                                                  (Strings.SelectedChild ==
                                                                          _foundedChatList![index]
                                                                              .childId!)
                                                                      ? "You:  "
                                                                      : _foundedChatList![index]
                                                                              .senderName! +
                                                                          ":  ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      fontWeight: false
                                                                          ? FontWeight
                                                                              .bold
                                                                          : FontWeight
                                                                              .normal),
                                                                ),
                                                                Text(
                                                                    ((_foundedChatList![index].message)!.contains(
                                                                            ".wav"))
                                                                        ? "Voice Message"
                                                                        : _foundedChatList![index]
                                                                            .message!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        fontWeight: false
                                                                            ? FontWeight.bold
                                                                            : FontWeight.normal))
                                                              ],
                                                            )
                                                          : (_foundedChatList![
                                                                              index]
                                                                          .message ??
                                                                      "")
                                                                  .contains(
                                                                      ".wav")
                                                              ? Text(
                                                                  "Voice Message",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      fontWeight: false
                                                                          ? FontWeight
                                                                              .bold
                                                                          : FontWeight
                                                                              .normal))
                                                              : Text(
                                                                  _foundedChatList![
                                                                              index]
                                                                          .message ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      fontWeight: false
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
                                        dateFormate[index],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                            fontWeight: false
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

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      onChanged: (searchString) {
        onSearch(searchString);
      },
      decoration: InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black54),
      ),
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      // onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.black54,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.black54,
        ),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  getChatsList() async {
    print("Getting comments");
    _socket?.on("getchat_list", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("getting inside");
        msgField.unfocus();
        if (_data.toString() != '[]') {
          if (_data[0]['child_id'] == Strings.SelectedChild) {
            ChatData = [];
            for (var item in _data) {
              ChatData!.add(ChatListData.fromJson(item));
              print("set state");
              dateFormate.clear();
              for (int index = 0; index < ChatData!.length; index++) {
                dateFormate.add(df.format((DateFormat("yyyy-MM-dd hh:mm")
                    .parse(ChatData![index].createdDate!))));
                // date!.add(DateFormat("yyyy-MM-dd", "en_US")
                //     .parse(ChatData![index].createdDate!));
                print(
                    "hii:${(DateFormat("yyyy-MM-dd hh:mm").parse(ChatData![index].createdDate!))}");
              }
              print("array:${dateFormate}");
            }
          }
          setState(() {
            _foundedChatList = ChatData;
          });
        } else {
          Strings.comments = [];
          _isLoading = false;
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
