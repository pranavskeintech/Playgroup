import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Models/AcceptFriendRequestReq.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

import '../Models/FriendRequestReq.dart';
import '../Models/OtherChildRes.dart';
import '../Network/ApiService.dart';
import '../Utilities/AppUtlis.dart';

class ShowOtherChildProfile extends StatefulWidget {
  int? otherChildID;
  String? childName;
  String? ChildLocation;
  ShowOtherChildProfile(
      {Key? key, this.otherChildID, this.childName, this.ChildLocation})
      : super(key: key);

  @override
  State<ShowOtherChildProfile> createState() => _ShowOtherChildProfileState();
}

class _ShowOtherChildProfileState extends State<ShowOtherChildProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext? ctx;
  List<childData> childInfo = [];
  var isloading = true;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => getProfile());
  }

  Addfriend() {
    AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);

    FriendRequestReq friendRequestReq = FriendRequestReq();

    friendRequestReq.childId = Strings.SelectedChild;
    friendRequestReq.childFriendId = widget.otherChildID;

    var data = jsonEncode(friendRequestReq);
    print(data);
    api.sendFriendRequest(friendRequestReq).then((response) {
      print(response.status);
      if (response.status == true) {
        AppUtils.dismissprogress();
        AppUtils.showToastTheme(response.message, "");
        getProfile();
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

  getProfile() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .getOtherchildDetails(Strings.SelectedChild, widget.otherChildID!)
        .then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          isloading = false;
          childInfo = response.data!;
        });
      } else {
        //functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, "Unable to fetch details for child", "");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  deleteRequest() {
    AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .deleteFriendRequest(
      Strings.SelectedChild,
      widget.otherChildID!,
    )
        .then((response) {
      print(response.status);
      if (response.status == true) {
        AppUtils.dismissprogress();
        AppUtils.showToast("Request Cancelled", ctx);
        getProfile();
      } else {
        //functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, "Unable to fetch details for child", "");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  bool _limitImage = true;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ApiService.create(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
          backgroundColor: Strings.appThemecolor,
          title: Transform(
            transform: Matrix4.translationValues(-10.0, 0, 0),
            child: Text(
              widget.childName ?? "",
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
        body: Builder(builder: (BuildContext newContext) {
          return otherChild(newContext);
        }),
      ),
    );
  }

  otherChild(BuildContext context) {
    {
      ctx = context;

      return isloading
          ? const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: childInfo[0].profile != "null"
                            ? NetworkImage(
                                Strings.imageUrl + (childInfo[0].profile ?? ""))
                            : AssetImage("assets/imgs/appicon.png")
                                as ImageProvider,
                        radius: 50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        childInfo[0].childName ?? "",
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
                            childInfo[0].location?? "",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Strings.FriendNotification
                      (childInfo[0].status == "Pending")
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 120,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          int FID = childInfo[0].friendsId!;
                                          int CID = Strings.SelectedChild;
                                          int CFID = childInfo[0].childId!;
                                          _AcceptFriendReq(CID, CFID, FID);
                                        },
                                        child: Container(
                                          width: 140,
                                          child: Center(
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 120,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          int FID = childInfo[0].friendsId!;
                                          int CID = Strings.SelectedChild;
                                          int CFID = childInfo[0].childId!;
                                          _CancelFriendReq(CID, CFID);
                                        },
                                        child: Container(
                                          width: 140,
                                          child: Center(
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : childInfo[0].status == "unfriend"
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
                              : childInfo[0].status == "Accepted"
                                  ? Text("You are already been friends")
                                  : ElevatedButton(
                                      onPressed: () {
                                        deleteRequest();
                                      },
                                      child: Container(
                                        width: 140,
                                        child: Center(
                                          child: Text(
                                            "Cancel Request",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ))
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
                  )
                ],
              ),
            );
    }
  }

  _AcceptFriendReq(CID, CFID, FID) {
    print("CID:$CID");
    print("CFID:$CFID");
    print("FID:$FID");
    AcceptFriendReq friendReq = AcceptFriendReq();
    friendReq.childId = CID;
    friendReq.childFriendId = CFID;
    friendReq.friendsId = FID;
    ;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.AcceptFriendRequest(friendReq).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");

      if (response.status == true) {
        AppUtils.dismissprogress();
        AppUtils.showToast(response.message, "");
        getProfile();
      } else {
        // functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, response.message, "");
        print("error");
      }
    });
  }

  _CancelFriendReq(CID, CFID) {
    print("CID:$CID");
    print("CFID:$CFID");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.CancelFriendReq(CID, CFID).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");
      if (response.status == true) {
        AppUtils.dismissprogress();
        AppUtils.showToast(response.message, "");
        getProfile();
      } else {
        // functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, response.message, "");
        print("error");
      }
    });
  }
}
