import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';

class Individuals_Chat extends StatefulWidget {
  const Individuals_Chat({Key? key}) : super(key: key);

  @override
  State<Individuals_Chat> createState() => _Individuals_ChatState();
}

class _Individuals_ChatState extends State<Individuals_Chat> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
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
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 20,
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
                        "Kriss Benwat",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
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
                    return {'Mute Notifications', 'Delete Conversation'}
                        .map((String choice) {
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
      body: Stack(
        children: <Widget>[
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
                      onPressed: () {},
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
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade300
                          : Colors.blue.shade400),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(
                        fontSize: 15,
                        color: (messages[index].messageType == "receiver"
                            ? Colors.black54
                            : Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  handleClick(String value) {
    switch (value) {
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
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
