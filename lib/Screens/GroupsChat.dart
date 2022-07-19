import 'dart:developer';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:audioplayers/audioplayers.dart';
import 'package:dart_emoji/dart_emoji.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Models/GetGroupsChat.dart';
import 'package:playgroup/Models/IndividualChatRes.dart';
import 'package:playgroup/Models/uploadAudio.dart';
import 'package:playgroup/Models/uploadGroupChatAudio.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/GroupInfo.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:permission_handler/permission_handler.dart';
import 'package:ext_storage/ext_storage.dart';

class Groups_Chat extends StatefulWidget {
  int? groupId;
  String? name;
  String? profile;
  Groups_Chat({Key? key, this.groupId, this.name, this.profile})
      : super(key: key);

  @override
  State<Groups_Chat> createState() => _Groups_ChatState();
}

class _Groups_ChatState extends State<Groups_Chat>
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

  List<Data>? ChatData = [];

  TextEditingController _msgcontroller = TextEditingController();

  var parser = EmojiParser();

  List<String> dateFormate = [];

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  var startRecording = false;
  var isPlaying = false;
  var playingIndex = null;
  int audioLength = 0;
  int audioCurrentlenth = 0;
  Timer? _timer;
  List<int> recordedData = [];
  final _audioRecorder = Record();

  String file64 = '';
  String? fileExt;

  Stopwatch watch = Stopwatch();
  bool startStop = true;
  String elapsedTime = '';

  String? audio;

  BuildContext? ctx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("initial value check-->> $initialCommentCheck");
    initialCommentCheck = true;
    print("id1:${Strings.SelectedChild}");
    print("id2:${widget.groupId}");

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
        'group_id': widget.groupId,
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
      getGroupChat();
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
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return GroupChat(newContext);
          }),
        ));
  }

  GroupChat(BuildContext context) {
    ctx = context;
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
                  backgroundColor: Colors.white,
                  maxRadius: 20,
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
                      //   height: 6,s
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
                      'Group Info',
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
              // shrinkWrap: true,
              // reverse: true,
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
                      child: Column(
                        children: [
                          (index != 0 &&
                                  ChatData![index].childId !=
                                      ChatData![index - 1].childId)
                              ? Align(
                                  alignment: (ChatData![index].childId !=
                                          Strings.SelectedChild
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: ChatData![index].childId !=
                                          Strings.SelectedChild
                                      ? Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 16,
                                              backgroundImage: (ChatData![index]
                                                          .profile! !=
                                                      "null")
                                                  ? NetworkImage(Strings
                                                          .imageUrl +
                                                      ChatData![index].profile!)
                                                  : AssetImage(
                                                          "assets/imgs/profile-user.png")
                                                      as ImageProvider,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(ChatData![index].childName!)
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(ChatData![index].childName!),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 16,
                                              backgroundImage: (ChatData![index]
                                                          .profile! !=
                                                      "null")
                                                  ? NetworkImage(Strings
                                                          .imageUrl +
                                                      ChatData![index].profile!)
                                                  : AssetImage(
                                                          "assets/imgs/profile-user.png")
                                                      as ImageProvider,
                                            ),
                                          ],
                                        ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: (ChatData![index].childId !=
                                    Strings.SelectedChild
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
                              child: (ChatData![index].message != null)
                                  ? Text(
                                      ChatData![index].message!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: (ChatData![index].childId !=
                                                Strings.SelectedChild
                                            ? Colors.black54
                                            : Colors.white),
                                      ),
                                    )
                                  : Container(
                                      width: 170,
                                      height: 30,
                                      child: Row(
                                        children: [
                                          isPlaying == false
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (isPlaying == true) {
                                                        stopAudio();
                                                        _timer = new Timer(
                                                            const Duration(
                                                                milliseconds:
                                                                    500), () {
                                                          setState(() {
                                                            isPlaying = true;
                                                            playingIndex =
                                                                index;
                                                            playAudio(
                                                                ChatData![index]
                                                                    .files!);
                                                          });
                                                        });
                                                      } else {
                                                        isPlaying = true;
                                                        playingIndex = index;
                                                        playAudio(
                                                            ChatData![index]
                                                                .files!);
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.play_arrow,
                                                    size: 28.0,
                                                    color: (ChatData![index]
                                                                .childId !=
                                                            Strings
                                                                .SelectedChild
                                                        ? Colors.black54
                                                        : Color.fromARGB(
                                                            255, 4, 112, 162)),
                                                  ),
                                                )
                                              : playingIndex == index
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isPlaying = false;
                                                        });

                                                        stopAudio();
                                                      },
                                                      child: Icon(
                                                        Icons.stop,
                                                        size: 28.0,
                                                        color: (ChatData![index]
                                                                    .childId !=
                                                                Strings
                                                                    .SelectedChild
                                                            ? Colors.black54
                                                            : Color.fromARGB(
                                                                255,
                                                                4,
                                                                112,
                                                                162)),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (isPlaying ==
                                                              true) {
                                                            stopAudio();
                                                            _timer = Timer(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                                () {
                                                              setState(() {
                                                                isPlaying =
                                                                    true;
                                                                playingIndex =
                                                                    index;
                                                                playAudio(
                                                                    ChatData![
                                                                            index]
                                                                        .files!);
                                                              });
                                                            });
                                                          } else {
                                                            isPlaying = true;
                                                            playingIndex =
                                                                index;
                                                            playAudio(
                                                                ChatData![index]
                                                                    .files!);
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        size: 28.0,
                                                        color: (ChatData![index]
                                                                    .childId !=
                                                                Strings
                                                                    .SelectedChild
                                                            ? Colors.black54
                                                            : Color.fromARGB(
                                                                255,
                                                                4,
                                                                112,
                                                                162)),
                                                      ),
                                                    ),
                                          Container(
                                            width: 130,
                                            child: Slider(
                                              activeColor:
                                                  (ChatData![index].childId !=
                                                          Strings.SelectedChild
                                                      ? Colors.grey
                                                      : Color.fromARGB(
                                                          255, 4, 112, 162)),
                                              inactiveColor: Colors.black54,
                                              value: playingIndex == index
                                                  ? audioCurrentlenth.toDouble()
                                                  : 0,
                                              min: 0,
                                              max: playingIndex == index
                                                  ? audioLength.toDouble()
                                                  : 0,
                                              onChanged: (double value) {
                                                setState(() {
                                                  playingIndex == index
                                                      ? audioCurrentlenth =
                                                          value.toInt()
                                                      : 0;
                                                  // _currentSliderValue = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          // (index != 0 &&
                          //         ChatData![index].childId !=
                          //             ChatData![index - 1].childId)
                          //     ?
                          Align(
                            alignment: (ChatData![index].childId !=
                                    Strings.SelectedChild
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
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
                          // : SizedBox()
                        ],
                      ),
                    ),
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
                      onLongPress: () {
                        startRecording = true;
                        startOrStop();
                        recordComments();
                      },
                      onLongPressEnd: (details) {
                        // AppUtils.showToast(details.toString());
                        setState(() {
                          startRecording = false;
                          startOrStop();
                          stopRecord();
                          sendAudio();
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Icon(
                          Icons.mic_none_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: FadeTransition(
                        opacity: _animationController!,
                        child: startRecording == true
                            ? Icon(Icons.mic, color: Colors.red)
                            : SizedBox(
                                width: 0,
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
                              hintText:startRecording == true
                                ? elapsedTime
                                : "Type Message...",
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
      case 'Group Info':
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Groupinfo(
                  groupId: widget.groupId,
                  choosedChildId: Strings.SelectedChild,
                  fromChat: true)));
        });
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

  getGroupChat() async {
    print("Getting comments");
    _socket?.on("get-group-chats", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("Dta chacek--> $initialCommentCheck");
        print("getting inside");
        msgField.unfocus();
        if (_data[0]['group_id'] == widget.groupId) {
          ChatData = [];
          for (var item in _data) {
            ChatData!.add(Data.fromJson(item));
            print("set state");

            for (int index = 0; index < ChatData!.length; index++) {
              dateFormate.add(DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(ChatData![index].createdDate!)));
            }
            print(dateFormate);
          }
        }
        initialCommentCheck = false;
        print("Comments fetched changing to false");

        // itemScrollController.jumpTo(index:0);

        AppUtils.dismissprogress();
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
          'add-group-chat',
          json.encode({
            "group_id": widget.groupId,
            "child_id": Strings.SelectedChild,
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

  recordComments() async {
    var dir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    var status1 = await Permission.microphone.status;
    var status2 = await Permission.storage.status;
    if (!status1.isGranted) {
      getPermission();
    } else if (!status2.isGranted) {
      getPermission();
    } else {
      await _audioRecorder.start(
        path: dir! + "/MTARecordedAudio.wav",
        encoder: AudioEncoder.AAC,
      );
    }
    ;
  }

  Future<void> stopRecord() async {
    _audioRecorder.stop();
  }

  playAudio(url) async {
    // var dir = await ExtStorage.getExternalStoragePublicDirectory(
    //     ExtStorage.DIRECTORY_DOWNLOADS);
    // String url = dir + "/MTARecordedAudio.wav";
    // dynamic audioUrl = Strings.IndChat + url;
    print(Strings.IndChat + url);

    // await audioPlayer.setSourceUrl(
    //   Strings.IndChat + url,
    // );
    await audioPlayer.play(
      Strings.GroupChat + url,
      volume: 5,
    );
    //await audioPlayer.play(, volume: 5, mode: playAudio(url));
    audioPlayer.onDurationChanged.listen((Duration d) {
      int seconds = d.inSeconds;
      print('Max duration: $d');
      setState(() {
        audioLength = seconds;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      int seconds = p.inSeconds;
      print('curr duration: $p');
      setState(() {
        audioCurrentlenth = seconds;
      });
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        audioLength = 0;
        audioCurrentlenth = 0;
        playingIndex = null;
        isPlaying = false;
      });
    });
    audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
    });
  }

  stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      audioLength = 0;
      audioCurrentlenth = 0;
      playingIndex = null;
      isPlaying = false;
    });
  }

  sendAudio() async {
    AppUtils.showprogress();
    var dir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    print("direct $dir");
    final bytesData =
        await Io.File(dir! + "/MTARecordedAudio.wav").readAsBytes();
    print("1");
    String base64Encodes(List<int> bytes) => base64.encode(bytes);
    print("2");
    String base64Encode = base64Encodes(bytesData);
    print("3");
    audio = "data:audio/wav;base64," + base64Encode;
    print("4");

    uploadGroupChatAudio req = uploadGroupChatAudio();

    req.files = "data:audio/wav;base64," + base64Encode;
    req.childId = Strings.SelectedChild;
    req.groupId = widget.groupId;
    req.type = "group-chat";
    var dat = jsonEncode(req);
    final api = Provider.of<ApiService>(ctx!, listen: false);

    print("Printing data -- > $dat");
    api.uploadGroupChatVoice(req).then((response) {
      AppUtils.dismissprogress();
      if (response.status!) {
        AppUtils.showToast("Audio sent successfully", context);
        _socket?.disconnect();
        _socket?.connect();
        _socket?.on("connect", (_) {
          print('Connected');
          initialCommentCheck = true;
          getGroupChat();
          _msgcontroller.text = '';
          // typing = false;
          msgField.unfocus();
        });
      } else {
        AppUtils.showToast(response.message!, context);
      }
    }).catchError((onError) {
      AppUtils.dismissprogress();
      print(onError.toString());
    });
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  reset() {
    watch.reset();
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
      reset();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  updateTime(Timer _timer) {
    if (watch.isRunning) {
      setState(() {
        print("startstop Inside=$startStop");
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
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

void getPermission() async {
  var status1 = await Permission.microphone.status;
  var status2 = await Permission.storage.status;
  if (status1.isDenied) {
    await Permission.microphone.request();
    if (status2.isDenied) {
      await Permission.storage.request();
    }
  } else if (status1.isPermanentlyDenied) {
    // AppUtils.showToast(
    //     "Please enable Microphone from App permission Settings",context);
  } else {
    await Permission.microphone.request();
    await Permission.storage.request();
  }
}
