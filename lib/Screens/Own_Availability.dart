import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:geocoding/geocoding.dart';
import 'package:playgroup/Models/AvailPauseReq.dart';
import 'package:playgroup/Models/AvailabityRes.dart';
import 'package:playgroup/Models/JoinfriendsReq.dart';
import 'package:playgroup/Models/OwnAvailabilityDetailsRes.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/EditAvailability_Time.dart';
import 'package:playgroup/Screens/G-Map.dart';
import 'package:playgroup/Screens/HomeScreen.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Screens/SuggestTimeSlot.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:provider/provider.dart';
import '../Network/ApiService.dart';
import '../Utilities/Strings.dart';

class Own_Availability extends StatefulWidget {
  int? markavailId;
  Own_Availability({Key? key, this.markavailId}) : super(key: key);

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
            Container(color: Colors.blue)
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
                      radius: 18,
                      backgroundImage: (availabilityData[0].profile! != null ||
                              availabilityData[0].profile! != "null")
                          ? NetworkImage(
                              Strings.imageUrl + availabilityData[0].profile!)
                          : AssetImage("assets/images/user.png")
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditAvailabilityTime(
                                    markavailId:
                                        availabilityData[0].markavailId,
                                    FromTime: availabilityData[0].fromTime,
                                    TOTime: availabilityData[0].toTime,
                                  ),
                                ));
                              },
                              icon: ImageIcon(
                                AssetImage('assets/imgs/edit.png'),
                                size: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage('assets/imgs/share .png'),
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
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
                      child: Text(
                        availabilityData[0].activitiesName! +
                            " - " +
                            availabilityData[0].categoryName!,
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
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => SuggestTime(
                                            ChildId: Strings.SelectedChild,
                                            OtherChildId:
                                                availabilityData[0].childId,
                                            markavailId:
                                                availabilityData[0].markavailId,
                                            FromTime:
                                                availabilityData[0].fromTime,
                                            TOTime: availabilityData[0].toTime,
                                          )));
                              setState(() {
                                getAvailabilityDetails();
                              });
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
                                            showParticipant(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            width: 35,
                                            height: 35,
                                            child: CircleAvatar(
                                              backgroundImage: availabilityData[
                                                              0]
                                                          .friendsdata![index]
                                                          .profile !=
                                                      null
                                                  ? NetworkImage(Strings
                                                          .imageUrl +
                                                      availabilityData[0]
                                                          .friendsdata![index]
                                                          .profile!)
                                                  : AssetImage(
                                                          "assets/images/user.png")
                                                      as ImageProvider,
                                            ),
                                          ),
                                        );
                                      } else {
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChipsChoice<int>.multiple(
                    wrapped: true,
                    verticalDirection: VerticalDirection.up,
                    choiceStyle: C2ChoiceStyle(color: Colors.black),
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
          Strings.activityConfirmed
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
                                        Text(
                                          "Are you sure to pause the availability ?",
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
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Yes"),
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Strings.appThemecolor),
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
                                              style: ElevatedButton.styleFrom(
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
                              style: TextStyle(color: Colors.grey),
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
                                width: 2, color: Colors.grey.withOpacity(0.2))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                      ),
                    ),
                    SizedBox(
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
                                                    print('yes selected');
                                                    deleteAvailability();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Yes"),
                                                  style:
                                                      ElevatedButton.styleFrom(
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
                                                style: ElevatedButton.styleFrom(
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
                            children: const [
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ImageIcon(
                                AssetImage('assets/imgs/delete_2.png'),
                                color: Colors.grey,
                                size: 16,
                              )
                            ],
                          ),
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.2))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                        ))
                  ],
                )
              : (availabilityData[0].requestStatus == "joined")
                  ? Column(
                      children: [
                        Align(
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
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  joined = true;
                                  _JoinFriendsMarkAvailability();
                                  // Strings.availConfirm = !Strings.availConfirm;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            width: MediaQuery.of(context).size.width * 0.8,
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
                                    OtherChildProfile()));
                          },
                          leading: CircleAvatar(
                            backgroundImage: availabilityData[0]
                                        .friendsdata![index]
                                        .profile !=
                                    "null"
                                ? NetworkImage(Strings.imageUrl +
                                    (availabilityData[0]
                                            .friendsdata![index]
                                            .profile ??
                                        ""))
                                : AssetImage("assets/imgs/appicon.png")
                                    as ImageProvider,
                            radius: 17,
                          ),
                          title: Text(
                            availabilityData[0].friendsdata![index].friendName ?? "",
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
    AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.deleteAvailability(widget.markavailId!).then((response) {
      AppUtils.dismissprogress();
      AppUtils.showToast(response.message, ctx);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
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
}
