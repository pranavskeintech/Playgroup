import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as Io;

import 'package:audioplayers/audioplayers.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playgroup/Models/AvailPauseReq.dart';
import 'package:playgroup/Models/AvailabityRes.dart';
import 'package:playgroup/Models/GetAvailabilityChat.dart';
import 'package:playgroup/Models/JoinfriendsReq.dart';
import 'package:playgroup/Models/OwnAvailabilityDetailsRes.dart';
import 'package:playgroup/Models/uploadAvailChatAudio.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/EditAvailability_Time.dart';
import 'package:playgroup/Screens/G-Map.dart';
import 'package:playgroup/Screens/HomeScreen.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Screens/SuggestTimeSlot.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import '../Network/ApiService.dart';
import '../Utilities/Strings.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:dart_emoji/dart_emoji.dart';

class Own_Availability extends StatefulWidget {
  int? markavailId;
  bool? fromAct;
  Own_Availability({Key? key, this.markavailId, this.fromAct})
      : super(key: key);

  @override
  State<Own_Availability> createState() => _Own_AvailabilityState();
}

class _Own_AvailabilityState extends State<Own_Availability>
    with TickerProviderStateMixin {
  //final _AddressController = TextEditingController();

  String? _currentAddress;
  String _address = 'Gandhipuram, Coimbatore';

  TabController? _tabController;
  bool activityConfirmed = false;
  bool? joined;
  List<Data> availabilityData = [];

  List<String> childImgs = [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
  ];

  int tag = 1;
  List<int> tag1 = [];

  bool _isLoading = true;

  BuildContext? ctx;
  var initialCommentCheck = true;
  AnimationController? _animationController;
  IO.Socket? _socket;

  FocusNode msgField = new FocusNode();

  List<AvailChatData>? ChatData = [];

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

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getAvailabilityDetails());
    print("Data---> ${widget.markavailId}");

    Strings.selectedAvailability = widget.markavailId;
    super.initState();
  }

  void initialize() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animationController?.repeat(reverse: true);
    _socket = IO.io(Strings.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'token': Strings.authToken,
        'markavail_id': widget.markavailId,
        'child_id': Strings.SelectedChild,
        'mark_type': "markavail-chat",
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
      getMarkChat();
    });
  }

  _JoinFriendsMarkAvailability() {
    //AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);

    JoinfriendsReq joinfriendsReq = JoinfriendsReq();
    joinfriendsReq.childId = Strings.SelectedChild;
    joinfriendsReq.markavailId = widget.markavailId;
    (joined == true)
        ? joinfriendsReq.status = "pending"
        : joinfriendsReq.status = "joined";
    print("reqSts:${joinfriendsReq.status}");
    api.JoinFriendsMarkAvailability(joinfriendsReq).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          getAvailabilityDetails();
          // AppUtils.dismissprogress();
          _isLoading = false;
        });
      } else {
        //functions.createSnackBar(context, response.status.toString());
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getAvailabilityDetails() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .getAvailabilityDetails(widget.markavailId!, Strings.SelectedChild)
        .then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          availabilityData = response.data!;
          (availabilityData[0].requestStatus == "joined")
              ? joined = true
              : joined = false;
          initialize();
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  // _getAddress() async {
  //   if (Strings.Latt != 0) {
  //     try {
  //       List<Placemark> p =
  //           await placemarkFromCoordinates(Strings.Latt, Strings.Long);

  //       Placemark place = p[0];
  //       setState(() {
  //         _currentAddress = "${place.name},${place.locality}";
  //         _address = _currentAddress!;
  //       });
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ApiService.create(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Strings.appThemecolor,
          title: Text("Availability"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: Builder(builder: (BuildContext newContext) {
          return Tabbarwidgets(newContext);
        }),
      ),
    );
  }

  Widget Tabbarwidgets(BuildContext context) {
    ctx = context;
    return Container(
        // padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 1.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              // padding: const EdgeInsets.all(8.0),
              child: TabBar(
                tabs: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text('Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF272626))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text('Chat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF9e9e9e))),
                  )
                ],
                //unselectedLabelColor: const Color(0xffacb3bf),
                indicatorColor: Color.fromRGBO(62, 244, 216, 0.8),
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2.0,
                //indicatorPadding: EdgeInsets.all(10),
                isScrollable: false,
                controller: _tabController,
              ),
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: <Widget>[
            availabilityDetails(),
            availabilityChat()
          ])),
        ]));
  }

  Widget availabilityDetails() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : availDetails();
  }

  availDetails() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      backgroundImage: (availabilityData[0].profile! != "null")
                          ? NetworkImage(
                              Strings.imageUrl + availabilityData[0].profile!)
                          : AssetImage("assets/imgs/profile-user.png")
                              as ImageProvider,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(availabilityData[0].childName ?? "")
                  ],
                ),
              ),
              Container(
                  child: Strings.activityConfirmed
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                availabilityData[0].status != "pause"
                                    ? Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            EditAvailabilityTime(
                                          markavailId:
                                              availabilityData[0].markavailId,
                                          FromTime:
                                              availabilityData[0].fromTime,
                                          TOTime: availabilityData[0].toTime,
                                        ),
                                      ))
                                    : AppUtils.showWarning(
                                        context,
                                        "Edit Not available for paused availability",
                                        "");
                              },
                              icon: ImageIcon(
                                  AssetImage('assets/imgs/edit.png'),
                                  size: 15,
                                  color: availabilityData[0].status != "pause"
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400),
                            ),
                            IconButton(
                              onPressed: () {
                                availabilityData[0].status != "pause"
                                    ? null
                                    : AppUtils.showWarning(
                                        context,
                                        "Share Not available for paused availability",
                                        "");
                              },
                              icon: ImageIcon(
                                  AssetImage('assets/imgs/share .png'),
                                  size: 16,
                                  color: availabilityData[0].status != "pause"
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400),
                            )
                          ],
                        )
                      : Container())
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                //borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      2.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: SizedBox(
                //height: 120,
                child: ListTile(
                  title: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      child: (availabilityData[0].activitiesName != null)
                          ? Text(
                              availabilityData[0].activitiesName! +
                                  " - " +
                                  availabilityData[0].categoryName!,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              "Open to Anything",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            )),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      availabilityData[0].description!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          height: 1.4,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 150, 149, 149)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 16,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        availabilityData[0].location ?? "",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 150, 149, 149)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    child: Row(
                      children: [
                        Text(
                          availabilityData[0].dateon ?? "",
                          style: TextStyle(
                              color: Color.fromARGB(255, 150, 149, 149),
                              fontSize: 11),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 1,
                          height: 10,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          availabilityData[0].fromTime! +
                              " - " +
                              availabilityData[0].toTime!,
                          style: TextStyle(
                              color: Color.fromARGB(255, 150, 149, 149),
                              fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Strings.activityConfirmed
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SuggestTime(
                                        ChildId: Strings.SelectedChild,
                                        OtherChildId:
                                            availabilityData[0].childId,
                                        markavailId:
                                            availabilityData[0].markavailId,
                                        FromTime: availabilityData[0].fromTime,
                                        TOTime: availabilityData[0].toTime,
                                      )));
                            },
                            child: Text(
                              "Suggest time Slot",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.orange,
                                  decoration: TextDecoration.underline),
                            ),
                          ))
                ]),
                // InkWell(
                //   onTap: () async {
                //     await Navigator.of(context).push(
                //         MaterialPageRoute(builder: (context) => MapsPage()));
                //     // setState(() {
                //     //   _getAddress();
                //     // });
                //   },
                //   child: Row(
                //     children: const [
                //       Text(
                //         "Map",
                //         style: TextStyle(
                //             color: Colors.blue,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       Icon(
                //         Icons.map,
                //         color: Colors.blue,
                //         size: 14,
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Divider(
                  height: 1.5,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Other Participants",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                availabilityData[0].friendsdata!.length > 0
                    ? Card(
                        elevation: 0,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        availabilityData[0].friendsdata!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
                                      if (index < 5) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    OtherChildProfile(
                                                        otherChildID:
                                                            availabilityData[0]
                                                                .friendsdata![
                                                                    index]
                                                                .childFriendId!,
                                                        chooseChildId: Strings
                                                            .SelectedChild,
                                                        fromSearch: false)));
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              width: 35,
                                              height: 35,
                                              child: CircleAvatar(
                                                  radius: (14),
                                                  backgroundColor: Colors.white,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: (availabilityData[0]
                                                                .friendsdata![
                                                                    index]
                                                                .profile ==
                                                            "null")
                                                        ? Image.asset(
                                                            "assets/imgs/profile-user.png")
                                                        : Image.network(Strings
                                                                .imageUrl +
                                                            availabilityData[0]
                                                                .friendsdata![
                                                                    index]
                                                                .profile!),
                                                  ))),
                                        );
                                      } else if (index == 6) {
                                        return Container(
                                          padding: EdgeInsets.all(3),
                                          height: 40,
                                          width: 40,
                                          child: InkWell(
                                            onTap: () {
                                              showParticipant(context);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.3),
                                              child: Text(
                                                "+${availabilityData[0].friendsdata!.length - 5}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ), //Text
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    })),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            "No friends joined yet!",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1.5,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Optional Benefits",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                (availabilityData[0].benefits!.length == 0)
                    ? SizedBox(
                        height: 50,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                "No Details AVailable yet!",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: ChipsChoice<int>.multiple(
                          wrapped: true,
                          verticalDirection: VerticalDirection.up,
                          choiceStyle: C2ChoiceStyle(
                              color: Colors.grey.shade600,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          value: tag1,
                          onChanged: (val) {},
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: availabilityData[0].benefits!,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Spacer(),
          widget.fromAct!
              ? SizedBox()
              : Strings.activityConfirmed
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
                          // ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        height: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            availabilityData[0].status !=
                                                    "pause"
                                                ? Text(
                                                    "Are you sure to pause the availability ?",
                                                    textAlign: TextAlign.center,
                                                  )
                                                : Text(
                                                    "Are you sure to resume the availability ?",
                                                    textAlign: TextAlign.center,
                                                  ),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      print('yes selected');
                                                      pauseAvailability();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Yes"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Strings
                                                                .appThemecolor),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Expanded(
                                                    child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("No",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  availabilityData[0].status != "pause"
                                      ? "Pause"
                                      : "Resume",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ImageIcon(
                                  AssetImage('assets/imgs/pause_1.png'),
                                  color: Colors.grey,
                                  size: 16,
                                )
                              ],
                            ),
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(BorderSide(
                                    width: 2,
                                    color:
                                        Colors.grey.shade600.withOpacity(0.2))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                availabilityData[0].status != "pause"
                                    ? showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 110,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Are you sure to delete the availability ?",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            print(
                                                                'yes selected');
                                                            deleteAvailability();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text("Yes"),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Strings
                                                                      .appThemecolor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 15),
                                                      Expanded(
                                                          child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.white,
                                                        ),
                                                      ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    : AppUtils.showWarning(
                                        context,
                                        "Delete Not available for paused availability",
                                        "");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Delete",
                                      style: TextStyle(
                                        color: availabilityData[0].status !=
                                                "pause"
                                            ? Colors.grey.shade600
                                            : Colors.grey.shade400,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ImageIcon(
                                    AssetImage('assets/imgs/delete_2.png'),
                                    color: availabilityData[0].status != "pause"
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade400,
                                    size: 16,
                                  )
                                ],
                              ),
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(BorderSide(
                                    width: 2,
                                    color: availabilityData[0].status != "pause"
                                        ? Colors.grey.shade600.withOpacity(0.2)
                                        : Colors.grey.shade400.withOpacity(0.2),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                            ))
                      ],
                    )
                  : (availabilityData[0].status == "pause")
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    2.0, // Move to right 10  horizontally
                                    9.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Paused",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : (availabilityData[0].requestStatus == "joined")
                          ? Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 8.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          offset: Offset(
                                            2.0, // Move to right 10  horizontally
                                            9.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          joined = true;
                                          _JoinFriendsMarkAvailability();
                                          // Strings.availConfirm = !Strings.availConfirm;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Remove",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 17,
                                          )
                                        ],
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 8.0, // soften the shadow
                                          spreadRadius: 2.0, //extend the shadow
                                          offset: Offset(
                                            2.0, // Move to right 10  horizontally
                                            10.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          joined == false;
                                          _JoinFriendsMarkAvailability();
                                          // Strings.availConfirm = !Strings.availConfirm;
                                        });
                                      },
                                      child: Text(
                                        "Join",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Strings.appThemecolor),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget availabilityChat() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
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
                                                  backgroundImage: (ChatData![
                                                                  index]
                                                              .profile! !=
                                                          "null")
                                                      ? NetworkImage(
                                                          Strings.imageUrl +
                                                              ChatData![index]
                                                                  .profile!)
                                                      : AssetImage(
                                                              "assets/imgs/profile-user.png")
                                                          as ImageProvider,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    ChatData![index].childName!)
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(ChatData![index]
                                                    .childName!),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 16,
                                                  backgroundImage: (ChatData![
                                                                  index]
                                                              .profile! !=
                                                          "null")
                                                      ? NetworkImage(
                                                          Strings.imageUrl +
                                                              ChatData![index]
                                                                  .profile!)
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
                                                          if (isPlaying ==
                                                              true) {
                                                            stopAudio();
                                                            _timer = new Timer(
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
                                                            color: (ChatData![
                                                                            index]
                                                                        .childId !=
                                                                    Strings
                                                                        .SelectedChild
                                                                ? Colors.black54
                                                                : Color
                                                                    .fromARGB(
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
                                                                    playAudio(ChatData![
                                                                            index]
                                                                        .files!);
                                                                  });
                                                                });
                                                              } else {
                                                                isPlaying =
                                                                    true;
                                                                playingIndex =
                                                                    index;
                                                                playAudio(
                                                                    ChatData![
                                                                            index]
                                                                        .files!);
                                                              }
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.play_arrow,
                                                            size: 28.0,
                                                            color: (ChatData![
                                                                            index]
                                                                        .childId !=
                                                                    Strings
                                                                        .SelectedChild
                                                                ? Colors.black54
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        4,
                                                                        112,
                                                                        162)),
                                                          ),
                                                        ),
                                              Container(
                                                width: 130,
                                                child: Slider(
                                                  activeColor: (ChatData![index]
                                                              .childId !=
                                                          Strings.SelectedChild
                                                      ? Colors.grey
                                                      : Color.fromARGB(
                                                          255, 4, 112, 162)),
                                                  inactiveColor: Colors.black54,
                                                  value: playingIndex == index
                                                      ? audioCurrentlenth
                                                          .toDouble()
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                  child: Text(
                                    DateFormat.jm().format(
                                      DateTime.parse(
                                          ChatData![index].createdDate!),
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
                                  hintText: startRecording == true
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
                            postMessage();
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
          );
  }

  showParticipant(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: (Icon(
                    Icons.close_rounded,
                    size: 20,
                  )),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  itemCount: availabilityData[0].friendsdata!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OtherChildProfile(
                                        otherChildID: availabilityData[0]
                                            .friendsdata![index]
                                            .childFriendId!,
                                        chooseChildId: Strings.SelectedChild,
                                        fromSearch: false)));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: availabilityData[0]
                                        .friendsdata![index]
                                        .profile !=
                                    "null"
                                ? NetworkImage(Strings.imageUrl +
                                    (availabilityData[0]
                                            .friendsdata![index]
                                            .profile ??
                                        ""))
                                : AssetImage("assets/imgs/profile-user.png")
                                    as ImageProvider,
                            radius: 17,
                          ),
                          title: Text(
                            availabilityData[0]
                                    .friendsdata![index]
                                    .friendName ??
                                "",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13.5),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ]),
          ));
        });
  }

  deleteAvailability() {
    print("mark:${widget.markavailId!}");
    AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.deleteAvailability(widget.markavailId!).then((response) {
      AppUtils.dismissprogress();

      if (response.status!) {
        AppUtils.showToast(response.message, ctx);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
      } else {
        AppUtils.showError(context, response.message, "onTap");
      }
    }).catchError((onError) {
      AppUtils.showToast(onError.toString(), ctx);
      print(onError.toString());
    });
  }

  pauseAvailability() {
    AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    AvailPauseReq availPauseReq = AvailPauseReq();
    availPauseReq.markavailId = widget.markavailId;
    if (availabilityData[0].status != "pause") {
      availPauseReq.status = "pause";
    } else {
      availPauseReq.status = "resume";
    }
    var dat = jsonEncode(availPauseReq);
    print(dat);

    api.pauseAvailability(availPauseReq).then((response) {
      AppUtils.dismissprogress();
      // AppUtils.showToast(context,response.message);
      getAvailabilityDetails();
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getMarkChat() async {
    print("Getting comments");
    _socket?.on("get-mark-avail-chats", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("Dta chacek--> $initialCommentCheck");
        print("getting inside");
        msgField.unfocus();
        ChatData = [];
        for (var item in _data) {
          ChatData!.add(AvailChatData.fromJson(item));
          print("set state");

          for (int index = 0; index < ChatData!.length; index++) {
            dateFormate.add(DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(ChatData![index].createdDate!)));
          }
          print(dateFormate);
        }
        msgField.unfocus();
      });
    });
  }

  postMessage() async {
    print("1:${parser.unemojify(_msgcontroller.text)}");
    // print(json.encode(tagedUsersId.toString()));
    if (_msgcontroller.text.trim() == "") {
      AppUtils.showError(context, "Kindly add some text!", '');
    } else {
      _socket?.emitWithAck(
          'add-mark-avail-chat',
          json.encode({
            "markavail_id": widget.markavailId,
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
      Strings.MarkChat + url,
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

    uploadAvailChatAudio req = uploadAvailChatAudio();

    req.files = "data:audio/wav;base64," + base64Encode;
    req.childId = Strings.SelectedChild;
    req.markavailId = widget.markavailId;
    req.type = "mark-avail-chat";
    var dat = jsonEncode(req);
    final api = Provider.of<ApiService>(ctx!, listen: false);

    print("Printing data -- > $dat");
    api.uploadAvailChatVoice(req).then((response) {
      AppUtils.dismissprogress();
      if (response.status!) {
        AppUtils.showToast("Audio sent successfully", context);
        _socket?.disconnect();
        _socket?.connect();
        _socket?.on("connect", (_) {
          print('Connected');
          initialCommentCheck = true;
          getMarkChat();
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
