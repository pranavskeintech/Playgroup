import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:playgroup/Models/PastActivityById.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:provider/provider.dart';
import '../Utilities/Strings.dart';
import 'package:image_picker/image_picker.dart';

import 'EditAvailability_Time.dart';
import 'G-Map.dart';

class Past_Activity_Details extends StatefulWidget {
  int? markavailId;
  int? childId;
  Past_Activity_Details({Key? key, this.markavailId, this.childId})
      : super(key: key);

  @override
  State<Past_Activity_Details> createState() => _Past_Activity_DetailsState();
}

class _Past_Activity_DetailsState extends State<Past_Activity_Details>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool activityConfirmed = false;
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

  List<String> names = [
    "Kingston Jackey",
    "Marry Princy",
    "Tinna",
    "Martina",
    "Helen Kings",
    "Kingsly"
  ];

  int tag = 1;
  List<int> tag1 = [];

  late File imageFile;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  String img64 = "";

  List<Data>? PastActData;

  bool _isLoading = true;

  BuildContext? ctx;
  String _getRandomImage(int width, int height) {
    var rng = new Random();
    return 'https://picsum.photos/$width/$height?random=${rng.nextInt(999999)}';
  }

  _GetPastAct() {
    //AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.PastActivityById(widget.markavailId!, widget.childId!).then((response) {
      if (response.status == true) {
        setState(() {
          // AppUtils.dismissprogress();
          PastActData = response.data;
          _isLoading = false;
          print(jsonEncode(PastActData));
          // if (PastActData != null) {
          //   _ShowNoData = false;
          // }
        });
      } else {}
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetPastAct());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return PastActivity(newContext);
          }),
        ));
  }

  PastActivity(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Activity"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Tabbarwidgets(),
    );
  }

  Widget Tabbarwidgets() {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)));
    }
    return Container(
        // padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 1.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 60,
            child: TabBar(
              tabs: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text('Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text('Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text('Gallery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                )
              ],
              unselectedLabelColor: const Color(0xffacb3bf),
              indicatorColor: Color.fromRGBO(62, 244, 216, 0.8),
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.all(10),
              isScrollable: true,
              controller: _tabController,
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: <Widget>[
            availabilityDetails(),
            AvailabilityChat(),
            Gallery(),
          ])),
        ]));
  }

  Widget availabilityDetails() {
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
                      radius: 18,
                      backgroundImage: (PastActData![0].profile! != "null")
                          ? NetworkImage(
                              Strings.imageUrl + PastActData![0].profile!)
                          : AssetImage("assets/imgs/appicon.png")
                              as ImageProvider,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(PastActData![0].childName!),
                  ],
                ),
              ),
              Container(
                  child: !Strings.activityConfirmed
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditAvailabilityTime(),
                                  ));
                                },
                                icon: Icon(
                                  Icons.edit_note_rounded,
                                  size: 20,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.share,
                                  size: 20,
                                ))
                          ],
                        )
                      : InkWell(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.edit_note_outlined,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.share,
                                size: 15,
                              )
                            ],
                          ),
                        ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 140,
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
              // height: 120,
              child: ListTile(
                title: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          PastActData![0].categoryName! + " - ",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          PastActData![0].activitiesName!,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    PastActData![0].description!,
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
                        PastActData![0].location!,
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
                          PastActData![0].dateon!,
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
                        Row(
                          children: [
                            Text(
                              PastActData![0].fromTime! + " - ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 150, 149, 149),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              PastActData![0].toTime!,
                              style: TextStyle(
                                color: Color.fromARGB(255, 150, 149, 149),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Strings.activityConfirmed
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: InkWell(
                            child: Text(
                              "Suggest time Slot",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.orange,
                                  decoration: TextDecoration.underline),
                            ),
                          ))
                      : Container()
                ]),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MapsPage()));
                    // setState(() {
                    //   _getAddress();
                    // });
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Direction",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.directions,
                        color: Colors.blue,
                        size: 17,
                      )
                    ],
                  ),
                )
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
                  height: 2,
                  thickness: 1.5,
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
                Card(
                  elevation: 0,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: (PastActData![0].friendsdata!.isEmpty)
                              ? Container(
                                  width: 130,
                                  height: 20,
                                  child: Text(
                                    "No one Participated",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      PastActData![0].friendsdata!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    if (index < 4) {
                                      return Container(
                                        padding: EdgeInsets.all(2),
                                        width: 32,
                                        height: 32,
                                        child: InkWell(
                                          onTap: () {
                                            // AppUtils.showParticipant(
                                            //     context,
                                            //     PastActData![0].friendsdata!);
                                          },
                                          child: CircleAvatar(
                                              backgroundImage: PastActData![0]
                                                          .friendsdata![index]
                                                          .profile !=
                                                      "null"
                                                  ? NetworkImage(
                                                      Strings.imageUrl +
                                                          (PastActData![0]
                                                                  .friendsdata![
                                                                      index]
                                                                  .profile ??
                                                              ""))
                                                  : AssetImage(
                                                          "assets/imgs/appicon.png")
                                                      as ImageProvider),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: EdgeInsets.all(2),
                                        height: 32,
                                        width: 32,
                                        child: InkWell(
                                          onTap: () {
                                            // AppUtils.showParticipant(
                                            //     context,
                                            //     PastActData![0].friendsdata!);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.3),
                                            child: Text(
                                              "+${PastActData![0].friendsdata!.length - 5}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ), //Text
                                          ),
                                        ),
                                      );
                                    }
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
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
                ChipsChoice<int>.multiple(
                  wrapped: true,
                  verticalDirection: VerticalDirection.up,
                  choiceStyle: C2ChoiceStyle(color: Colors.black),
                  value: tag1,
                  onChanged: (val) {},
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: PastActData![0].benefits!,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget AvailabilityChat() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 60),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: messages[index].messageType == "receiver"
                          ? Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage:
                                      AssetImage("assets/imgs/child5.jpg"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Kingston Jackey")
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Jhon"),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage:
                                      AssetImage("assets/imgs/child5.jpg"),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
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
                        padding: EdgeInsets.fromLTRB(12, 7, 15, 7),
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
                  ],
                ),
              );
            },
          ),
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
        ],
      ),
    );
  }

  Widget Gallery() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Activity Photos",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigoAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                  color: Colors.grey.withOpacity(0.3))))),
                  onPressed: () {
                    _showPicker(context);
                  },
                  child: Text(
                    "Add Photos",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              //itemCount: images.length,
              itemCount: 30,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Image.network(
                        //images[index],
                        _getRandomImage(512, 512),
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.softLight,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.transparent.withOpacity(0),
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Kingston Jackey",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "12/03/2021",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (image != null) {
        final bytes = File(image!.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        print("img64" + img64);
        setState(() {});
        print('image selected.');
      } else {
        setState(() {});
        print('No image selected.');
      }
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (image != null) {
        final bytes = File(image!.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        setState(() {});
        print('image selected.');
      } else {
        setState(() {});
        print('No image selected.');
      }
    });
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
