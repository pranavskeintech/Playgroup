import 'dart:developer';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:dart_emoji/dart_emoji.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Models/IndividualChatRes.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Individuals_Chat extends StatefulWidget {
  int? otherChildId;
  String? name;
  String? profile;
  Individuals_Chat({Key? key, this.otherChildId, this.name, this.profile})
      : super(key: key);

  @override
  State<Individuals_Chat> createState() => _Individuals_ChatState();
}

class _Individuals_ChatState extends State<Individuals_Chat>
    with SingleTickerProviderStateMixin {
  // List<ChatMessage> messages = [
  //   ChatMessage(
  //       messageContent: "Hello, Will",
  //       messageType: "receiver",
  //       createdAt: "22-05-2022"),
  //   ChatMessage(
  //       messageContent: "How have you been?",
  //       messageType: "receiver",
  //       createdAt: "22-05-2022"),
  //   ChatMessage(
  //       messageContent: "Hey Kriss, I am doing fine dude. wbu?",
  //       messageType: "sender",
  //       createdAt: "22-05-2022"),
  //   ChatMessage(
  //       messageContent: "ehhhh, doing OK.",
  //       messageType: "receiver",
  //       createdAt: "24-05-2022"),
  //   ChatMessage(
  //       messageContent: "Is there any thing wrong?",
  //       messageType: "sender",
  //       createdAt: "25-05-2022"),
  // ];

  var initialCommentCheck = true;
  AnimationController? _animationController;
  IO.Socket? _socket;

  FocusNode msgField = new FocusNode();

  List<IndiData>? ChatData = [];

  TextEditingController _msgcontroller = TextEditingController();

  var parser = EmojiParser();

  List<String> dateFormate = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("initial value check-->> $initialCommentCheck");
    initialCommentCheck = true;
    print("id1:${Strings.SelectedChild}");
    print("id2:${widget.otherChildId}");

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
        'other_child_id': widget.otherChildId,
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
      getComments();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();

    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();

    print("dispose variable assigned--> $initialCommentCheck");
    // Strings.comments = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  maxRadius: 20,
                                          backgroundColor: Colors.white,
                  backgroundImage: (widget.profile! != "null")
                      ? NetworkImage(Strings.imageUrl + widget.profile!)
                      : AssetImage("assets/imgs/profile-user.png")
                          as ImageProvider,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(
                      //   height: 6,
                      // ),
                      // Text(
                      //   "Online",
                      //   style: TextStyle(
                      //       color: Colors.grey.shade600, fontSize: 13),
                      // ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  child: Icon(
                    Icons.more_vert,
                  ),
                  onSelected: (Data) {
                    handleClick(Data);
                  },
                  itemBuilder: (BuildContext context) {
                    return {
                      'View Profile',
                      'Mute Notifications',
                      'Delete Conversation'
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: ChatData!.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                Widget separator = SizedBox();
                if (index != 0 &&
                    dateFormate[index] != dateFormate[index - 1]) {
                  separator = Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //color: Strings.chipsbg
                      ),
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        dateFormate[index],
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ));
                } else if (index == 0) {
                  separator = Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //color: Strings.chipsbg
                      ),
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        dateFormate[index],
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ));
                }
                return Column(
                  children: [
                    separator,
                    Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment:
                            (ChatData![index].childId != Strings.SelectedChild
                                ? Alignment.topLeft
                                : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (ChatData![index].childId !=
                                    Strings.SelectedChild
                                ? Colors.grey.shade300
                                : Colors.blue.shade400),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                          child: Text(
                            ChatData![index].message!,
                            style: TextStyle(
                              fontSize: 15,
                              color: (ChatData![index].childId !=
                                      Strings.SelectedChild
                                  ? Colors.black54
                                  : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment:
                          (ChatData![index].childId != Strings.SelectedChild
                              ? Alignment.topLeft
                              : Alignment.topRight),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          DateFormat.jm().format(
                            DateTime.parse(ChatData![index].createdDate!),
                          ),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 50,
                width: double.infinity,
                // color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.mic_none_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: TextField(
                          controller: _msgcontroller,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                bottom: 15.0,
                              ),
                              hintText: "Type Message...",
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        postComments();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.grey,
                        size: 25,
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  handleClick(String value) {
    switch (value) {
      case 'View Profile':
        setState(() {});
        break;
      case 'Mute Notifications':
        setState(() {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "Mute Notification",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    "assets/imgs/mute notification.png",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              content: Text(
                "Mute Push Notification",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 25,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("No"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Strings.appThemecolor),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.white)))),
                      ),
                      SizedBox(
                        width: 100,
                        height: 25,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        side: BorderSide(color: Colors.grey))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.black)))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
        break;
      case 'Delete Conversation':
        setState(() {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "Delete All Conversation",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    "assets/imgs/delete message2.png",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              content: Text(
                "Are you sure do you want to delete the conversations of this group",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(38, 0, 38, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 25,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("No"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Strings.appThemecolor),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.white)))),
                      ),
                      SizedBox(
                        width: 100,
                        height: 25,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        side: BorderSide(color: Colors.grey))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.black)))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
        break;
    }
  }

  getComments() async {
    print("Getting comments");
    _socket?.on("get-individual-chats", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("Dta chacek--> $initialCommentCheck");
        print("getting inside");
        msgField.unfocus();
        ChatData = [];
        for (var item in _data) {
          ChatData!.add(IndiData.fromJson(item));
          print("set state");
          for (int index = 0; index < ChatData!.length; index++) {
            dateFormate.add(DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(ChatData![index].createdDate!)));
          }
        }
        initialCommentCheck = false;
        print("Comments fetched changing to false");

        // itemScrollController.jumpTo(index:0);

        msgField.unfocus();

        //  });
      });
    });
  }

  postComments() async {
    print("1:${parser.unemojify(_msgcontroller.text)}");
    // print(json.encode(tagedUsersId.toString()));
    if (_msgcontroller.text.trim() == "") {
      AppUtils.showError(context, "Kindly add some text!", '');
    } else {
      _socket?.emitWithAck(
          'add-individual-chat',
          json.encode({
            "child_id": Strings.SelectedChild,
            "other_child_id": widget.otherChildId,
            "message": parser.unemojify(_msgcontroller.text),
            "files": ""
          }), ack: (data) {
        print('ack $data');
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });

      _msgcontroller.text = '';

      msgField.unfocus();
    }
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  String createdAt;
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.createdAt});
}
