import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Models/FriendRequestReq.dart';
import 'package:playgroup/Models/GetAllActivities.dart';
import 'package:playgroup/Models/OtherChildRes.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Screens/AvailabilityList.dart';
import 'package:playgroup/Screens/friendsList.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

import '../Network/ApiService.dart';
import '../Utilities/AppUtlis.dart';

class OtherChildProfile extends StatefulWidget {
  int? otherChildID;
  int? chooseChildId;
  OtherChildProfile({
    Key? key,
    this.otherChildID,
    this.chooseChildId,
  }) : super(key: key);

  @override
  State<OtherChildProfile> createState() => _OtherChildProfileState();
}

class _OtherChildProfileState extends State<OtherChildProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext? ctx;
  List<childData>? childInfo;

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
  bool _limitImage = true;

  bool _isLoading = true;

  List<ActData>? AllActivity = [];

  CheckFriends() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .getOtherchildDetails(widget.chooseChildId!, widget.otherChildID!)
        .then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          childInfo = response.data!;
          print(jsonEncode(childInfo));
        });
        GetAllActivity();
      } else {
        //functions.createSnackBar(context, response.message.toString());
        // AppUtils.dismissprogress();
        _isLoading = false;
        AppUtils.showError(context, "Unable to fetch details for child", "");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  GetAllActivity() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAllActivity(widget.otherChildID!).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          AllActivity = response.data;

          // for (var i = 0; i < AllActivity!.length; i++) {
          //   if (AllActivity![i].type == "my_availability") {
          //     MyAct!.add(AllActivity![i]);
          //     setState(() {
          //       _foundedMyActivity = MyAct;
          //     });
          //   } else {
          //     JoinedAct!.add(AllActivity![i]);
          //     setState(() {
          //       _foundedJoinedActivity = JoinedAct;
          //     });
          //   }
          // }

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => CheckFriends());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return OtherChildProfile(newContext);
          }),
        ));
  }

  OtherChildProfile(BuildContext context) {
    ctx = context;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
              backgroundColor: Strings.appThemecolor,
              title: Transform(
                transform: Matrix4.translationValues(-10.0, 0, 0),
                child: Text(
                  childInfo![0].childName!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
              leading: Transform(
                transform: Matrix4.translationValues(8.0, 0, 0),
                child: IconButton(
                    onPressed: () {
                      // _scaffoldKey.currentState?.openDrawer();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      // AssetImage("assets/imgs/menu_ver2.png"),
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.white,
                    )),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: childInfo![0].profile! != "null"
                              ? NetworkImage(
                                  Strings.imageUrl + (childInfo![0].profile!))
                              : AssetImage("assets/imgs/appicon.png")
                                  as ImageProvider),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        childInfo![0].childName!,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            childInfo![0].location!,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (childInfo![0].status! != "Accepted")
                          ? ElevatedButton(
                              onPressed: () {
                                Addfriend();
                              },
                              child: Container(
                                width: 140,
                                child: Center(
                                  child: Text(
                                    "Add Friend",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ))
                          : SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Remove Friend",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.grey
                                                    .withOpacity(0.2))))),
                              ),
                            )
                    ]),
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    height: 250,
                    //width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "School",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            childInfo![0].school ?? "School name not yet added",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
                    child: Divider(
                      height: 2,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 25, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Interests",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: TextButton(
                                  onPressed: () {
                                    (childInfo![0].interests!.length != 0)
                                        ? _showInterests(ctx!)
                                        : null;
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
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        childInfo![0].interests!.length > 0
                            ? SizedBox(
                                height: 80,
                                child: ListView.builder(
                                    itemCount: childInfo![0].interests!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
                                      if (index > 4) {
                                        _limitImage = false;
                                      }
                                      return _limitImage
                                          ? Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      4, 0, 4, 0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    // border: Border.all(
                                                    //     width: 1.3,
                                                    //     color: Color.fromARGB(255, 251, 132, 138)),
                                                  ),
                                                  padding: EdgeInsets.all(2),
                                                  width: 41.5,
                                                  height: 41.5,
                                                  child: CircleAvatar(
                                                      backgroundImage: childInfo![
                                                                      0]
                                                                  .interests![
                                                                      index]
                                                                  .interestImage! !=
                                                              "null"
                                                          ? NetworkImage(Strings
                                                                  .imageUrl +
                                                              "sports/" +
                                                              (childInfo![0]
                                                                  .interests![
                                                                      index]
                                                                  .interestImage!))
                                                          : AssetImage(
                                                                  "assets/imgs/appicon.png")
                                                              as ImageProvider),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    childInfo![0]
                                                        .interests![index]
                                                        .interestName!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 11.0))
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    // border: Border.all(
                                                    //     width: 1.3,
                                                    //     color: Color.fromARGB(255, 251, 132, 138)),
                                                  ),
                                                  padding: EdgeInsets.all(2),
                                                  width: 44,
                                                  height: 44,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.3),
                                                    child: Text(
                                                      "+${childInfo![0].interests!.length - 3}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ), //Text
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text('',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 11.0))
                                              ],
                                            );
                                    })))
                            : SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Interests not yet added"),
                                ),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 5),
                    child: Divider(
                      height: 2,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Friends",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: TextButton(
                                  onPressed: () {
                                    (childInfo![0].frndsdata!.length != 0)
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => friendsList(
                                                FID: childInfo![0].childId,
                                              ),
                                            ),
                                          )
                                        : null;
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        childInfo![0].frndsdata!.length > 0
                            ? SizedBox(
                                child: GridView.builder(
                                  itemCount:
                                      (childInfo![0].frndsdata!.length < 4)
                                          ? childInfo![0].frndsdata!.length
                                          : 4,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 50.0,
                                          childAspectRatio: 2.6),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: 0, bottom: 14),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          padding:
                                              EdgeInsets.fromLTRB(12, 5, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                //margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  // border: Border.all(
                                                  //     width: 1.3,
                                                  //     color: Color.fromARGB(255, 251, 132, 138)),
                                                ),
                                                //padding: EdgeInsets.all(2),
                                                width: 30,
                                                height: 30,
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                    "assets/imgs/child2.jpg",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                childInfo![0]
                                                        .frndsdata![index]
                                                        .childName ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 11.5,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )
                            : SizedBox(
                                child: Text("Fiends not yet added"),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
                    child: Divider(
                      height: 2,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Availability",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                onPressed: () {
                                  (AllActivity!.length != 0)
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                availabilityList(
                                              FID: childInfo![0].childId,
                                            ),
                                          ),
                                        )
                                      : null;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AllActivity!.length > 0
                            ? SizedBox(
                                height: 180,
                                child: ListView.builder(
                                    itemCount: AllActivity!.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      return index > 1
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 14),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 18,
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Colors.grey
                                                        .withOpacity(0.2)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              AllActivity![
                                                                          index]
                                                                      .categoryName! +
                                                                  " - ",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Container(
                                                              width: 70,
                                                              child: Text(
                                                                AllActivity![
                                                                        index]
                                                                    .activitiesName!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              AllActivity![
                                                                      index]
                                                                  .dateon!,
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                                  AllActivity![
                                                                              index]
                                                                          .fromTime!
                                                                          .replaceAll(
                                                                              ' PM',
                                                                              '')
                                                                          .replaceAll(
                                                                              ' AM',
                                                                              '') +
                                                                      " - ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  AllActivity![
                                                                          index]
                                                                      .toTime!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 14,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          "Gandhipuram, Coimbatore",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                    })),
                              )
                            : SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Not yet Joined in Activities"),
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ));
  }

  _showInterests(ctx) {
    showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(vertical: 150.0, horizontal: 45.0),
            content: Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  itemCount: childInfo![0].interests!.length,
                  itemBuilder: (context, index) {
                    return index > 2
                        ? SizedBox()
                        : Column(
                            children: [
                              ListTile(
                                onTap: () {},
                                leading: CircleAvatar(
                                  backgroundImage: childInfo![0]
                                              .interests![index]
                                              .interestImage! !=
                                          "null"
                                      ? NetworkImage(Strings.imageUrl +
                                          "sports/" +
                                          (childInfo![0]
                                                  .interests![index]
                                                  .interestImage ??
                                              ""))
                                      : AssetImage("assets/imgs/appicon.png")
                                          as ImageProvider,
                                  radius: 17,
                                ),
                                title: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  child: Text(
                                    childInfo![0]
                                            .interests![index]
                                            .interestName ??
                                        "",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
              Positioned(
                right: 0.0,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.blue,
                  ),
                ),
              ),
            ]),
          );
        });
  }

  Addfriend() {
    final api = Provider.of<ApiService>(ctx!, listen: false);

    FriendRequestReq friendRequestReq = FriendRequestReq();

    friendRequestReq.childId = Strings.SelectedChild;
    friendRequestReq.childFriendId = widget.otherChildID;
    api.sendFriendRequest(friendRequestReq).then((response) {
      print(response.status);
      if (response.status == true) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => OTPScreen(),
        //   ),
        // );
      } else {
        //functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, "User not registered", "");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
