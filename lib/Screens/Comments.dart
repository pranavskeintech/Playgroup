import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;
//import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:playgroup/Models/CommentsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

AnimationController? _animationController;
int? MarkAvailabilityId;
String? Profile;
String? CategoryName;
String? ActivityName;
String? ChildName;

var initialCommentCheck = true;
List<String> docImg = [];

IO.Socket? _socket;

class Comments extends StatefulWidget {
  static const String routeName = "/comments";
  int? markAvailId;
  String? profile;
  String? categoryName;
  String? activityName;
  String? childName;

  Comments(
      {Key? key,
      @required this.markAvailId,
      @required this.profile,
      @required this.categoryName,
      @required this.activityName,
      @required this.childName})
      : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    MarkAvailabilityId = widget.markAvailId;
    Profile = widget.profile;
    ActivityName = widget.activityName;
    CategoryName = widget.categoryName;
    ChildName = widget.childName;
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text("Comments"),
            backgroundColor: Strings.appThemecolor,
          ),
          // backgroundColor: Colors.grey[300],
          body: WillPopScope(
              child: CommentsContent(),
              onWillPop: () {
                Navigator.pop(context);
                _socket?.disconnect();
                _socket?.dispose();
                throw 'Screen Change';
              }),
        ));
  }
}

class CommentsContent extends StatefulWidget {
  static const String routeName = "/comments";

  @override
  _CommentsContentState createState() => _CommentsContentState();
}

class _CommentsContentState extends State<CommentsContent>
    with SingleTickerProviderStateMixin {
  var _currDoc;
  TextEditingController _msgcontroller = TextEditingController();
  //ScrollController _scrollController = new ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  FocusNode msgField = new FocusNode();
  String? filepath;
  int? projectId;

  var _key;

  String? projectname;
  @override
  void initState() {
    super.initState();

    // getUserCats();
    // getuserCatgories();
    // getProjectDetails();

    print("initial value check-->> $initialCommentCheck");
    initialCommentCheck = true;

    print("init state variable assigned--> $initialCommentCheck");
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animationController?.repeat(reverse: true);

    print("Mark avail id--> $MarkAvailabilityId");
    // getUserCats();
    _socket = IO.io(Strings.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'token': Strings.authToken,
        'markavail_id': MarkAvailabilityId,
        'child_id': Strings.SelectedChild,
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadiusDirectional.circular(10)),
              height: 80,
              // width: MediaQuery.of(context).size.width * 0.9,
              child: ListTile(
                isThreeLine: true,
                leading:
                    //  CircleAvatar(
                    //   backgroundImage: AssetImage("assets/imgs/child.jpg"),
                    // ),
                    CircleAvatar(
                  backgroundImage: (Profile != "null")
                      ? NetworkImage(Strings.imageUrl + Profile!)
                      : AssetImage("assets/imgs/appicon.png") as ImageProvider,
                ),
                title: Text(ChildName ?? ""),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          CategoryName!,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 1,
                          height: 1,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              ActivityName!,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          Strings.comments.length > 0
              ? Expanded(
                  child: ScrollablePositionedList.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: Strings.comments.length,
                      padding: EdgeInsets.all(20),
                      itemBuilder: (BuildContext ctx, int index) {
                        return Strings.comments[index].childId ==
                                Strings.SelectedChild
                            ? Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),

                                  // A pane can dismiss the Slidable.
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),

                                  // All actions are defined in the children parameter.
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: (dt) {
                                        print("delete");
                                        deleteComments(
                                            Strings.comments[index].commetId);
                                      },
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.black,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _showMyDialog(
                                                    context,
                                                    Strings.imageUrl +
                                                        Strings.comments[index]
                                                            .profile!);
                                              },
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundImage: Strings
                                                            .comments[index]
                                                            .profile !=
                                                        null
                                                    ? NetworkImage(
                                                        Strings.imageUrl +
                                                            (Strings
                                                                .comments[index]
                                                                .profile!))
                                                    : AssetImage(
                                                            "assets/icons/account.png")
                                                        as ImageProvider,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        Strings.comments[index]
                                                                .childName! +
                                                            " . ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Container(
                                                      width: 18.0,
                                                      height: 18.0,
                                                      child: IconButton(
                                                        padding:
                                                            new EdgeInsets.all(
                                                                0.0),
                                                        color: Colors.grey,
                                                        icon: new Icon(
                                                            Icons.update,
                                                            size: 18.0),
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                        calculateTimeDifferenceBetween(
                                                            serverDate: Strings
                                                                .comments[index]
                                                                .createdAt),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            Strings
                                                                .comments[index]
                                                                .comment
                                                                .toString(),
                                                          ),
                                                        ],
                                                      )),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.75,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(5)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        MySeparator(
                                          color: Colors.grey[500]!,
                                        )
                                      ],
                                    )),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _showMyDialog(
                                                context,
                                                Strings.imageUrl +
                                                    Strings.comments[index]
                                                        .profile!);
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundImage: Strings
                                                        .comments[index]
                                                        .profile !=
                                                    null
                                                ? NetworkImage(
                                                    Strings.imageUrl +
                                                        (Strings.comments[index]
                                                            .profile!))
                                                : AssetImage(
                                                        "assets/icons/account.png")
                                                    as ImageProvider,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    Strings.comments[index]
                                                            .childName! +
                                                        " . ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Container(
                                                  width: 18.0,
                                                  height: 18.0,
                                                  child: IconButton(
                                                    padding:
                                                        new EdgeInsets.all(0.0),
                                                    color: Colors.grey,
                                                    icon: new Icon(Icons.update,
                                                        size: 18.0),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                ),
                                                Text(
                                                    calculateTimeDifferenceBetween(
                                                        serverDate: Strings
                                                            .comments[index]
                                                            .createdAt),
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        Strings.comments[index]
                                                            .comment
                                                            .toString(),
                                                      ),
                                                    ],
                                                  )),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(5)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MySeparator(
                                      color: Colors.grey[500]!,
                                    )
                                  ],
                                ));
                      }),
                )
              : Center(
                  child: Text("No comments found!"),
                ),
          Strings.comments.length == 0 ? Spacer() : SizedBox(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 50,
                width: double.infinity,
                // color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: TextField(
                          controller: _msgcontroller,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                bottom: 15.0,
                              ),
                              hintText: "Type your Comment...",
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
                        color: Colors.white,
                        size: 15,
                      ),
                      backgroundColor: Strings.appThemecolor,
                      elevation: 50,
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

  getComments() async {
    print("Getting comments");
    _socket?.on("get-comments", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("Dta chacek--> $initialCommentCheck");
        print("getting inside");
        msgField.unfocus();
        Strings.comments = [];
        for (var item in _data) {
          Strings.comments.add(CommentRes.fromJson(item));
          print("set state");
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
    // print(json.encode(tagedUsersId.toString()));
    if (_msgcontroller.text.trim() == "") {
      AppUtils.showError(context, "Kindly add some text!", '');
    } else {
      _socket?.emitWithAck(
          'create-comment',
          json.encode({
            "comment": _msgcontroller.text,
            "markavail_id": MarkAvailabilityId,
            "child_id": Strings.SelectedChild
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

  deleteComments(commentId) async {
    print("deleting");
    print(commentId);
    _socket?.emitWithAck(
        'delete-comment', commentId, ack: (data) {
      print('ack $data');
      if (data != null) {
        print('from server $data');
      } else {
        print("Null");
      }
    });
  }

  static String calculateTimeDifferenceBetween({@required String? serverDate}) {
    DateTime startDate = DateTime.parse(serverDate!);
    //print(DateFormat.MMMEd().format(startDate));
    DateTime endDate = DateTime.now();

    // var dateUtc = DateTime.now().toUtc();
    // var strToDateTime = DateTime.parse(dateUtc.toString());
    // final convertLocal = strToDateTime.toLocal();
    // var newFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
    // String updatedDt = newFormat.format(convertLocal);
    // print(dateUtc);
    // print(convertLocal);
    // print(updatedDt);

    int seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60)
      return '${seconds.abs()} second ago';
    else if (seconds >= 60 && seconds < 3600)
      return '${startDate.difference(endDate).inMinutes.abs()} minute ago';
    else if (seconds >= 3600 && seconds < 86400)
      return '${startDate.difference(endDate).inHours.abs()} hour ago';
    else
      return '${startDate.difference(endDate).inDays.abs()} day ago';
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
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

Future<void> _showMyDialog(context, imgurl) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    new Icon(Icons.close, size: 22.0, color: Colors.black),
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  image: new DecorationImage(
                    image: new NetworkImage(imgurl),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                ),
              )),
        ),
      );
    },
  );
}
