import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:playgroup/Models/GetAllActivities.dart';
import 'package:playgroup/Models/GetMarkAvailabilityListRes.dart';
import 'package:playgroup/Models/GetOtherMarkAvailabilityRes.dart';
import 'package:playgroup/Models/JoinfriendsReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AvailabilityList.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/InitialHome.dart';
import 'package:playgroup/Screens/Mark_availability.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Screens/Own_Availability.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:provider/provider.dart';
import '../Utilities/AppUtlis.dart';
import '../Utilities/Strings.dart';
import 'package:social_share/social_share.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _story = true;
  List<String> ChildName = [
    "Kingston Jackey",
    "Ronny Thomas",
    "Alex Timo",
    "Christina Timo",
    "George Timo",
    "Mariya Timo",
    "Angel Timo"
  ];

  List<String> games = [
    "Art Work - Natural Painting",
    "Cricket play",
    "Cooking",
    "Reading",
    "Trekking",
    "Singing",
    "Art",
    "Hockey"
  ];
  List<String> images = [
    "cricket.jpg",
    "cooking.jpg",
    "reading.jpg",
    "trekking.jpg",
    "singing.jpg",
    "art.jpg",
    "hockey.jpg"
  ];
  List<String> activities = [
    "Cricket",
    "Cooking",
    "Reading",
    "Trekking",
    "Singing",
    "Art",
    "Hockey"
  ];
  List<String> location = [
    "Gandhipuram",
    "PN Palayam",
    "Kuniyamuthoor",
    "Ukkadam",
    "Town Hall",
    "Race Course",
    "Avinasi Road"
  ];
  List<String> childImgs = [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];

  bool _isLoading = true;

  List<ActData>? GetMarkAvailabilityData;

  BuildContext? ctx;

  List<Data>? OtherMarkAvailabilityData;

  bool _ShowNoFriends = false;

  bool _ShowNoAvailability = false;
  _GetMarkAvailability() {
    //AppUtils.showprogress();
    int CID = Strings.SelectedChild;
    print("cID:$CID");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetMarkAvailability(CID).then((response) {
      print("sts1:${response.status}");
      print("res1:${response.data}");
      if (response.status == true) {
        setState(() {
          // AppUtils.dismissprogress();
          GetMarkAvailabilityData = response.data;
          if (GetMarkAvailabilityData != null) {
            _ShowNoFriends = false;
            _GetOtherMarkAvailability();
          }
        });
      } else {
        setState(() {
          _ShowNoAvailability = true;
          _GetOtherMarkAvailability();
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _GetOtherMarkAvailability() {
    //AppUtils.showprogress();
    int childId = Strings.SelectedChild;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetOtherMarkAvailability(childId).then((response) {
      print("sts2:${response.status}");
      print("res2:${response.data}");
      try {
        if (response.status == true) {
          setState(() {
            // AppUtils.dismissprogress()
            if (response.data!.length != 0) {
              OtherMarkAvailabilityData = response.data;
            } else {
              OtherMarkAvailabilityData = [];
            }
            _ShowNoFriends = false;
            _isLoading = false;
          });
        } else {
          setState(() {
            print("3");
            _isLoading = false;
            _ShowNoFriends = true;
            //functions.createSnackBar(context, response.status.toString());
          });
        }
      } catch (e) {
        print("err" + e.toString());
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _GetMarkAvailability());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return HomePage(newContext);
          }),
        ));
  }

  HomePage(BuildContext context) {
    print("friend:$_ShowNoFriends");
    ctx = context;
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)));
    } else {
      return _ShowNoFriends
          ? Container(
              margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Your Play dates",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      (GetMarkAvailabilityData != null &&
                              GetMarkAvailabilityData!.length > 3)
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => availabilityList(
                                      FID: Strings.SelectedChild,
                                      fromOwnAvail: true,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 15,
                                    color: Colors.grey,
                                  )
                                ],
                              ))
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _ShowNoAvailability
                      ? Container(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DashBoard(screenindex: 4),
                                  ),
                                );
                              },
                              child: Text("Tap to add availability")))
                      : SizedBox(
                          height: 80,
                          child: ListView.builder(
                              itemCount: GetMarkAvailabilityData!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Strings.activityConfirmed = true;
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              Own_Availability(
                                            markavailId:
                                                GetMarkAvailabilityData![index]
                                                    .markavailId,
                                            fromAct: false,
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1.3,
                                              color: Color.fromARGB(
                                                  255, 251, 132, 138)),
                                        ),
                                        padding: EdgeInsets.all(2),
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              (GetMarkAvailabilityData![index]
                                                              .categoryImg !=
                                                          "null" &&
                                                      GetMarkAvailabilityData![
                                                                  index]
                                                              .categoryImg !=
                                                          null)
                                                  ? NetworkImage(Strings
                                                          .imageUrl +
                                                      "sports/" +
                                                      (GetMarkAvailabilityData![
                                                              index]
                                                          .categoryImg!))
                                                  : AssetImage(
                                                          "assets/imgs/profile-user.png")
                                                      as ImageProvider,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 50,
                                      child: Center(
                                        child: Text(
                                          GetMarkAvailabilityData![index]
                                                  .categoryName ??
                                              "Open to Anything",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })),
                        ),
                  Divider(
                    height: 4,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Invite Friends",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Invite your Friends to the Playgroup App.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              SocialShare.shareOptions(
                                      "Hey I found an new app Named Playgroup, Install With my link https://play.google.com/store/apps/details?id=com.netflix.mediaclient")
                                  .then((data) {
                                print(data);
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/imgs/add-user.png",
                                    width: 15,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Invite Friends")
                                ])),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "No Availabilities",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 8,
                          shadowColor: Colors.grey.withOpacity(0.1),
                          child: Container(
                            //height: 200,
                            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "There are no friend's availabilities please add friends and view their availabilities",
                                    style: TextStyle(
                                        color: Strings.textFeildHeading,
                                        fontSize: 15),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      "Add your friends and share with your availabilities",
                                      style: TextStyle(
                                          color: Strings.textFeildHeading)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DashBoard(screenindex: 2),
                                          ),
                                        );
                                      },
                                      child: Text("Search and add Friends"))
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Your Play dates",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      (GetMarkAvailabilityData != null &&
                              GetMarkAvailabilityData!.length > 3)
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => availabilityList(
                                      FID: Strings.SelectedChild,
                                      fromOwnAvail: true,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 15,
                                    color: Colors.grey,
                                  )
                                ],
                              ))
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _ShowNoAvailability
                      ? Container(
                          child: TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         Mark_Availabilty()));

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DashBoard(screenindex: 4),
                                  ),
                                );
                              },
                              child: Text("Tap to add availability")))
                      : SizedBox(
                          height: 80,
                          child: ListView.builder(
                              itemCount: GetMarkAvailabilityData!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Strings.activityConfirmed = true;
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              Own_Availability(
                                            markavailId:
                                                GetMarkAvailabilityData![index]
                                                    .markavailId,
                                            fromAct: false,
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1.3,
                                              color: Color.fromARGB(
                                                  255, 251, 132, 138)),
                                        ),
                                        padding: EdgeInsets.all(2),
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              (GetMarkAvailabilityData![index]
                                                              .categoryImg !=
                                                          "null" &&
                                                      GetMarkAvailabilityData![
                                                                  index]
                                                              .categoryImg !=
                                                          null)
                                                  ? NetworkImage(Strings
                                                          .imageUrl +
                                                      "sports/" +
                                                      (GetMarkAvailabilityData![
                                                                  index]
                                                              .categoryImg ??
                                                          ""))
                                                  : AssetImage(
                                                          "assets/imgs/profile-user.png")
                                                      as ImageProvider,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 50,
                                      child: Center(
                                        child: Text(
                                          GetMarkAvailabilityData![index]
                                                  .categoryName ??
                                              "Open to Anything",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              })),
                        ),
                  Divider(
                    height: 4,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Expanded(
                    child: Container(
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: OtherMarkAvailabilityData!.length,
                          itemBuilder: (context, mainIndex) {
                            return AnimationConfiguration.staggeredList(
                                position: mainIndex,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap: (() async {
                                        Strings.activityConfirmed = false;
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Own_Availability(
                                                          markavailId:
                                                              OtherMarkAvailabilityData![
                                                                      mainIndex]
                                                                  .markavailId,
                                                          fromAct: false,
                                                        )));
                                        setState(() {
                                          _isLoading = true;
                                          _GetMarkAvailability();
                                        });
                                      }),
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 10, 20),
                                        height: 220,
                                        color: Colors.white,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                blurRadius:
                                                    8.0, // soften the shadow
                                                spreadRadius:
                                                    5.0, //extend the shadow
                                                offset: Offset(
                                                  2.0, // Move to right 10  horizontally
                                                  2.0, // Move to bottom 10 Vertically
                                                ),
                                              )
                                            ],
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(13, 2, 12, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                isThreeLine: false,
                                                //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage:
                                                      (OtherMarkAvailabilityData![
                                                                      mainIndex]
                                                                  .profile! !=
                                                              "null")
                                                          ? NetworkImage(Strings
                                                                  .imageUrl +
                                                              OtherMarkAvailabilityData![
                                                                      mainIndex]
                                                                  .profile!)
                                                          : AssetImage(
                                                                  "assets/imgs/profile-user.png")
                                                              as ImageProvider,
                                                ),
                                                title: Text(
                                                  OtherMarkAvailabilityData![
                                                          mainIndex]
                                                      .childName!,
                                                  style: TextStyle(
                                                      fontSize: 13.5,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                subtitle: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 5),
                                                        Text(
                                                          OtherMarkAvailabilityData![
                                                                  mainIndex]
                                                              .dateon!,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(height: 5),
                                                        // Container(
                                                        //   width: 1,
                                                        //   height: 10,
                                                        //   color: Colors.red,
                                                        // ),
                                                        // SizedBox(
                                                        //   width: 5,
                                                        // ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              OtherMarkAvailabilityData![
                                                                          mainIndex]
                                                                      .fromTime! +
                                                                  " - ",
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              OtherMarkAvailabilityData![
                                                                      mainIndex]
                                                                  .toTime!,
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_pin,
                                                          color: Colors.red,
                                                          size: 12.5,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Container(
                                                          width: 90,
                                                          child: Text(
                                                            OtherMarkAvailabilityData![
                                                                    mainIndex]
                                                                .location!,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              (OtherMarkAvailabilityData![
                                                              mainIndex]
                                                          .categoryName !=
                                                      null)
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          OtherMarkAvailabilityData![
                                                                      mainIndex]
                                                                  .categoryName! +
                                                              " - ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        Text(
                                                          OtherMarkAvailabilityData![
                                                                  mainIndex]
                                                              .activitiesName!,
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "Open to anything",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Divider(
                                                height: 2,
                                                color: Colors.grey.shade300,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Other Participants",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: (OtherMarkAvailabilityData![
                                                                  mainIndex]
                                                              .friendsdata!
                                                              .isEmpty)
                                                          ? Container(
                                                              width: 130,
                                                              height: 20,
                                                              child: Text(
                                                                "Be first to join",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            )
                                                          : ListView.builder(
                                                              itemCount: OtherMarkAvailabilityData![
                                                                      mainIndex]
                                                                  .friendsdata!
                                                                  .length,
                                                              scrollDirection:
                                                                  Axis
                                                                      .horizontal,
                                                              itemBuilder:
                                                                  ((context,
                                                                      index) {
                                                                if (index < 4) {
                                                                  return Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                    width: 32,
                                                                    height: 32,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (BuildContext context) => OtherChildProfile(
                                                                                otherChildID: OtherMarkAvailabilityData![mainIndex].friendsdata![index].childFriendId,
                                                                                chooseChildId: Strings.SelectedChild,
                                                                                fromSearch: false)));
                                                                      },
                                                                      child: CircleAvatar(
                                                                          backgroundColor: Colors
                                                                              .white,
                                                                          backgroundImage: OtherMarkAvailabilityData![mainIndex].friendsdata![index].profile != "null"
                                                                              ? NetworkImage(Strings.imageUrl + (OtherMarkAvailabilityData![mainIndex].friendsdata![index].profile ?? ""))
                                                                              : AssetImage("assets/imgs/profile-user.png") as ImageProvider),
                                                                    ),
                                                                  );
                                                                } else if (index ==
                                                                    5) {
                                                                  return Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                    height: 32,
                                                                    width: 32,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        AppUtils.showParticipant(
                                                                            context,
                                                                            OtherMarkAvailabilityData![mainIndex].friendsdata!);
                                                                      },
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor: Colors
                                                                            .grey
                                                                            .withOpacity(0.3),
                                                                        child:
                                                                            Text(
                                                                          "+${OtherMarkAvailabilityData![mainIndex].friendsdata!.length - 4}",
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
                                                    SizedBox(
                                                      height: 32,
                                                      width: 70,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: (OtherMarkAvailabilityData![
                                                                        mainIndex]
                                                                    .status ==
                                                                "pause")
                                                            ? TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                  "PAUSED",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey

                                                                      // fontWeight:
                                                                      //     FontWeight.w400
                                                                      ),
                                                                ),
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .white,
                                                                  side:
                                                                      BorderSide(
                                                                    width: 1.6,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                  ),
                                                                ),
                                                              )
                                                            : (OtherMarkAvailabilityData![
                                                                            mainIndex]
                                                                        .requestStatus ==
                                                                    "joined")
                                                                ? TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      "JOINED",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.grey

                                                                          // fontWeight:
                                                                          //     FontWeight.w400
                                                                          ),
                                                                    ),
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .white,
                                                                      side:
                                                                          BorderSide(
                                                                        width:
                                                                            1.6,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      _JoinFriendsMarkAvailability(
                                                                          OtherMarkAvailabilityData![mainIndex]
                                                                              .markavailId);
                                                                    },
                                                                    child: Text(
                                                                      "JOIN",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Color.fromRGBO(
                                                                            94,
                                                                            37,
                                                                            108,
                                                                            1),
                                                                        // fontWeight:
                                                                        //     FontWeight.w400
                                                                      ),
                                                                    ),
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .white,
                                                                      side:
                                                                          BorderSide(
                                                                        width:
                                                                            1.6,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300,
                                                                      ),
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
    }
  }

  _JoinFriendsMarkAvailability(MID) {
    AppUtils.showprogress();
    //AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);

    JoinfriendsReq joinfriendsReq = JoinfriendsReq();
    joinfriendsReq.childId = Strings.SelectedChild;
    joinfriendsReq.markavailId = MID;
    joinfriendsReq.status = "joined";
    api.JoinFriendsMarkAvailability(joinfriendsReq).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          // AppUtils.dismissprogress();
          _isLoading = false;
          _GetMarkAvailability();
          AppUtils.showToast(response.message, context);
          AppUtils.dismissprogress();
        });
      } else {
        functions.createSnackBar(context, response.status.toString());
        AppUtils.showToast("Unable to join please try again!", context);

        AppUtils.dismissprogress();
      }
    }).catchError((onError) {
      print(onError.toString());
      AppUtils.dismissprogress();
    });
  }
}
