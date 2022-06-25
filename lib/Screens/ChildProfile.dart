import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playgroup/Models/AcceptFriendRequestReq.dart';
import 'package:playgroup/Models/AcceptedFriendsRes.dart';
import 'package:playgroup/Models/FriendsAndGroups.dart';
import 'package:playgroup/Models/GetAllActivities.dart';
import 'package:playgroup/Models/GetAllGroupDetails.dart';
import 'package:playgroup/Models/GetChildProfile.dart';
import 'package:playgroup/Models/OtherChildRes.dart';
import 'package:playgroup/Models/PendingFriendReqRes.dart';
import 'package:playgroup/Models/UserDetailsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddGroup.dart';
import 'package:playgroup/Screens/EditChildDetails.dart';
import 'package:playgroup/Screens/EditChildInterests.dart';
import 'package:playgroup/Screens/EditLanguagesKnown.dart';
import 'package:playgroup/Screens/GroupInfo.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Screens/Own_Availability.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:provider/provider.dart';

class ChildProfile extends StatefulWidget {
  int? chooseChildId;
  String? chooseChildName;
  ChildProfile({
    Key? key,
    this.chooseChildId,
    this.chooseChildName,
  }) : super(key: key);

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile>
    with TickerProviderStateMixin {
  TabController? _tabController;
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

  List<String> Games = [
    "Playing-Cricket",
    "Drawing Lessions",
    "Art Natural Painting",
    "Maths Coaching",
    "Playing-Cricket",
    "Science Experiments"
  ];

  List<String> Places = [
    "Gandhipuram, Coimbatore",
    "Laximi Mills",
    "PN Palayam",
    "Gandhipuram, Coimbatore",
    "Railway Station",
    "Gandhipuram, Coimbatore",
  ];

  List<String> options = [
    'English',
    'Tamil',
    'Kannada',
  ];

  List<int> tag1 = [];

  // Initial Selected Value
  String dropdownvalue = 'ALL';

  // List of items in our dropdown menu
  var items = [
    'ALL',
    'GROUPS',
    'FRIENDS',
  ];
  // Initial Selected Value
  String dropdownvalue2 = 'FILTER';

  // List of items in our dropdown menu
  var items2 = [
    'FILTER',
    'MY ACTIVITIES',
    'JOINED ACTIVITIES',
  ];

  bool value = false;
  final List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  var _AddGroup = false;

  BuildContext? ctx;

  List<FriendReqData>? _FriendReqData;

  List<FriendsData>? FriendsDatum;

  bool _isLoading = true;

  List<Data>? childInfo;

  List<bool>? _isChecked;

  List<int>? FriendsId = [];

  List<GroupDetails>? GroupDetail;

  List<Datas>? FriendsGroupsData;

  List<FriendsData> _foundedUsers = [];

  List<GroupDetails> _foundedGroups = [];

  List<Datas> _foundedAllData = [];

  int? index1;
  List<ActData>? AllActivity;

  List<ActData>? JoinedAct = [];

  List<ActData>? MyAct = [];

  List<ActData>? _foundedActivity = [];

  List<ActData>? _foundedMyActivity = [];

  List<ActData>? _foundedJoinedActivity = [];

  fetchData() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetPendingFriendReq(widget.chooseChildId!).then((response) {
      print(response.status);
      if (response.status == true) {
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));

        setState(() {
          _FriendReqData = response.data;
          getProfile();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        functions.createSnackBar(context, response.status.toString());
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getProfile() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.getchildProfile(widget.chooseChildId!).then((response) {
      print(response.status);
      if (response.status == true) {
        childInfo = response.data!;
        _GetFriends();
      } else {
        //functions.createSnackBar(context, response.message.toString());
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  GetFriendsAndGroups() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetGroupFriends(widget.chooseChildId!).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          FriendsGroupsData = response.datas;

          setState(() {
            _foundedAllData = FriendsGroupsData!;
          });
          GroupData();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _GetFriends() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAcceptedFriendReq(widget.chooseChildId!).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          FriendsDatum = response.data!;
          setState(() {
            _foundedUsers = FriendsDatum!;
            _isChecked = List<bool>.filled(_foundedUsers.length, false);
          });
          // FriendsDat = response.data!.cast<GroupDetai>();
          GetFriendsAndGroups();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  GroupData() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAllGroupDetails(widget.chooseChildId!).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          if (response.message != "No Groups found") {
            GroupDetail = response.groupDetails;
            setState(() {
              _foundedGroups = GroupDetail!;
            });
            GetAllActivity();
            // GroupDetail1 = response.groupDetails!.cast<GroupDetai>();
            // _isLoading = false;
            // newList = new List.from(FriendsDat!)..addAll(GroupDetail1!);
            // print("1:${newList![0].childName}");
          } else {
            GroupDetail = [];
            GetAllActivity();
            // _isLoading = false;
          }
        });
      } else {
        _isLoading = false;
        functions.createSnackBar(context, response.status.toString());
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  GetAllActivity() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAllActivity(widget.chooseChildId!).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          AllActivity = response.data;
          setState(() {
            _foundedActivity = AllActivity!;
          });

          for (var i = 0; i < AllActivity!.length; i++) {
            if (AllActivity![i].type == "my_availability") {
              MyAct!.add(AllActivity![i]);
              setState(() {
                _foundedMyActivity = MyAct;
              });
            } else {
              JoinedAct!.add(AllActivity![i]);
              setState(() {
                _foundedJoinedActivity = JoinedAct;
              });
            }
          }

          _isLoading = false;
        });
      } else {
        // AllActivity = [];
        // MyAct = [];
        // JoinedAct = [];
        //functions.createSnackBar(context, response.status.toString());

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
    _tabController = TabController(length: 4, vsync: this);
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchData());
  }

  onSearch(String search) {
    print("Searching for $search");
    setState(() {
      if (dropdownvalue == "GROUPS") {
        _foundedGroups = GroupDetail!
            .where((user) =>
                user.groupName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      } else if (dropdownvalue == "FRIENDS") {
        _foundedUsers = FriendsDatum!
            .where((user) =>
                user.childName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      } else if (dropdownvalue == "ALL") {
        for (var i = 0; i < _foundedAllData.length; i++) {
          _foundedAllData = FriendsGroupsData!
              .where((user) =>
                  user.name!.toLowerCase().contains(search.toLowerCase()))
              .toList();
        }
        print(_foundedUsers.length);
      }
    });
  }

  onSearch3(String search) {
    print("Searching for $search");
    setState(() {
      if (dropdownvalue2 == "FILTER") {
        _foundedActivity = AllActivity!
            .where((user) =>
                user.categoryName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      } else if (dropdownvalue2 == "MY ACTIVITIES") {
        _foundedMyActivity = MyAct!
            .where((user) =>
                user.categoryName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      } else if (dropdownvalue2 == "JOINED ACTIVITIES") {
        _foundedJoinedActivity = JoinedAct!
            .where((user) =>
                user.categoryName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return ChildProfile(newContext);
          }),
        ));
  }

  ChildProfile(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text(widget.chooseChildName!),
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
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Container(
            // padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 60,
                child: TabBar(
                  tabs: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text('Profile Info',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF9e9e9e))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text('Friends',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF9e9e9e))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text('Friend Request',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF9e9e9e))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text('Activities',
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
                  child:
                      TabBarView(controller: _tabController, children: <Widget>[
                ProfileInfo(),
                Friends(),
                FriendRequest(),
                Activities(),
              ])),
            ]));
  }

  Widget ProfileInfo() {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditChildDetails()));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Edit"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit_outlined,
                                size: 15,
                              )
                            ],
                          ),
                        )),
                  ),
                  CircleAvatar(
                      radius: 45,
                      backgroundImage: childInfo![0].profile! != "null"
                          ? NetworkImage(
                              Strings.imageUrl + (childInfo![0].profile!))
                          : AssetImage("assets/imgs/appicon.png")
                              as ImageProvider),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    childInfo![0].childName!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        childInfo![0].location!,
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "School",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          childInfo![0].school ?? "Add School Name",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1.5,
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DOB",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          childInfo![0].dob!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Interests",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditChildInterests(
                                chooseChildId: widget.chooseChildId)));
                      },
                      child: Row(
                        children: [
                          (childInfo![0].interests!.length == 0)
                              ? Text("Add")
                              : Text("Edit"),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            (childInfo![0].interests!.length == 0)
                                ? Icons.add_circle_outline_rounded
                                : Icons.edit_outlined,
                            size: 15,
                          )
                        ],
                      )),
                ],
              ),
            ),
            (childInfo![0].interests!.length == 0)
                ? Text("Add Interests")
                : Container(
                    height: 80,
                    child: ListView.builder(
                        itemCount: childInfo![0].interests!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return Container(
                            child: Column(
                              children: [
                                if (index < 5)
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(2),
                                        width: 45,
                                        height: 45,
                                        child: CircleAvatar(
                                            backgroundImage: childInfo![0]
                                                        .interests![index]
                                                        .interestImage! !=
                                                    "null"
                                                ? NetworkImage(
                                                    Strings.imageUrl +
                                                        "sports/" +
                                                        (childInfo![0]
                                                            .interests![index]
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
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                else
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      child: Text(
                                        "3+",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ), //Text
                                    ),
                                  ),
                              ],
                            ),
                          );
                        })),
                  ),
            SizedBox(
              height: 0,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Languages Known",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditLangKnwn()));
                        setState(() {
                          getProfile();
                        });
                      },
                      child: Row(
                        children: [
                          (childInfo![0].languages!.length == 0)
                              ? Text("Add")
                              : Text("Edit"),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            (childInfo![0].languages!.length == 0)
                                ? Icons.add_circle_outline_rounded
                                : Icons.edit_outlined,
                            size: 15,
                          )
                        ],
                      )),
                ],
              ),
            ),
            (childInfo![0].languages!.length == 0)
                ? Text("Add Languages")
                : ChipsChoice<int>.multiple(
                    spacing: 20,
                    wrapped: true,
                    verticalDirection: VerticalDirection.up,
                    choiceStyle: C2ChoiceStyle(color: Colors.black),
                    value: tag1,
                    onChanged: (val) {},
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: childInfo![0].languages!,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget Friends() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
/////////////////        SeachBar     ///////////////////////////////////////
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 5, 10),
            child: Row(
              children: [
                Container(
                  width: width * 0.6,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (searchString) {
                            onSearch(searchString);
                          },
                          enabled: true,
                          style: TextStyle(height: 1.5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          child: DropdownButton(
                            underline: SizedBox(),
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: width * 0.07,
                  width: width * 0.24,
                  child: _AddGroup
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _AddGroup = false;
                            });
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 11),
                          ))
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _AddGroup = true;
                              dropdownvalue = "FRIENDS";
                            });
                          },
                          child: Text(
                            "Add Group+",
                            style: TextStyle(fontSize: 11),
                          )),
                )
              ],
            ),
          ),
/////////////////        All List    ///////////////////////////////////////

          (dropdownvalue == "ALL" && !_AddGroup)
              ? (_foundedAllData.length) > 0
                  ? Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: _foundedAllData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: ListTile(
                                onTap: () async {
                                  (_foundedAllData[index].type == "GROUP")
                                      ? await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Groupinfo(
                                                      groupId:
                                                          _foundedAllData[index]
                                                              .id,
                                                      choosedChildId: widget
                                                          .chooseChildId)))
                                      : Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  OtherChildProfile(
                                                      otherChildID:
                                                          _foundedAllData[index]
                                                              .id,
                                                      chooseChildId:
                                                          widget.chooseChildId)));
                                  setState(() {
                                    GroupData();
                                  });
                                },
                                leading: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: (_foundedAllData[index].type ==
                                          "GROUP")
                                      ? Stack(children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: CircleAvatar(
                                              backgroundImage: _foundedAllData[
                                                              index]
                                                          .image !=
                                                      "null"
                                                  ? NetworkImage(Strings
                                                          .imageUrl +
                                                      (_foundedAllData[index]
                                                              .image ??
                                                          ""))
                                                  : AssetImage(
                                                          "assets/imgs/appicon.png")
                                                      as ImageProvider,
                                              radius: 23,
                                            ),
                                          ),
                                          Positioned(
                                              right: 30,
                                              bottom: 25,
                                              child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/imgs/add_friends.png"),
                                                radius: 10,
                                              ))
                                        ])
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: CircleAvatar(
                                            backgroundImage: _foundedAllData[
                                                            index]
                                                        .image !=
                                                    "null"
                                                ? NetworkImage(
                                                    Strings.imageUrl +
                                                        (_foundedAllData[index]
                                                                .image ??
                                                            ""))
                                                : AssetImage(
                                                        "assets/imgs/appicon.png")
                                                    as ImageProvider,
                                            radius: 23,
                                          ),
                                        ),
                                ),
                                title: Transform.translate(
                                    offset: Offset(-16, 0),
                                    child: Text(_foundedAllData[index].name!)),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Divider(
                              thickness: 1,
                            ),
                          );
                        },
                      ),
                    )
                  : Spacer()
              : SizedBox(),
/////////////////        Groups List    ///////////////////////////////////////

          (dropdownvalue == "GROUPS" && !_AddGroup)
              ? _foundedGroups.length > 0
                  ? Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: _foundedGroups.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: ListTile(
                              onTap: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Groupinfo(
                                                groupId: _foundedGroups[index]
                                                    .groupId,
                                                choosedChildId:
                                                    widget.chooseChildId)));
                                setState(() {
                                  GroupData();
                                });
                              },
                              leading: Transform.translate(
                                offset: Offset(-16, 0),
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          _foundedAllData[index].image != "null"
                                              ? NetworkImage(Strings.imageUrl +
                                                  (_foundedAllData[index]
                                                          .image ??
                                                      ""))
                                              : AssetImage(
                                                      "assets/imgs/appicon.png")
                                                  as ImageProvider,
                                      radius: 23,
                                    ),
                                  ),
                                  Positioned(
                                      right: 30,
                                      bottom: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/imgs/add_friends.png",
                                        ),
                                        radius: 10,
                                      ))
                                ]),
                              ),
                              title: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child:
                                      Text(_foundedGroups[index].groupName!)),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Divider(
                              thickness: 1,
                            ),
                          );
                        },
                      ),
                    )
                  : Spacer()
              : SizedBox(),

/////////////////        FriendList    ///////////////////////////////////////

          (dropdownvalue == "FRIENDS" || _AddGroup)
              ? _foundedUsers.length > 0
                  ? Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: _foundedUsers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: ListTile(
                              onTap: () {
                                _AddGroup
                                    ? null
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OtherChildProfile(
                                                    otherChildID:
                                                        _foundedUsers[index]
                                                            .childFriendId,
                                                    chooseChildId:
                                                        widget.chooseChildId)));
                              },
                              leading: Transform.translate(
                                offset: Offset(-16, 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    backgroundImage: _foundedUsers[index]
                                                .profile !=
                                            "null"
                                        ? NetworkImage(Strings.imageUrl +
                                            (_foundedUsers[index].profile ??
                                                ""))
                                        : AssetImage("assets/imgs/appicon.png")
                                            as ImageProvider,
                                    radius: 23,
                                  ),
                                ),
                              ),
                              trailing: _AddGroup
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),
                                      width: 20,
                                      height: 20,
                                      child: Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white),
                                        child: Checkbox(
                                            // side: BorderSide(color: Colors.black),
                                            checkColor: Colors.green,
                                            activeColor: Colors.transparent,
                                            //hoverColor: Colors.black,
                                            value: _isChecked?[index],
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  if (val!) {
                                                    _isChecked?[index] = val;
                                                    FriendsId!.add(
                                                        _foundedUsers[index]
                                                            .childId!);
                                                    print(FriendsId);
                                                  } else {
                                                    _isChecked?[index] = val;
                                                    FriendsId!.remove(
                                                        _foundedUsers[index]
                                                            .childId!);
                                                    print(FriendsId);
                                                  }
                                                },
                                              );
                                            }),
                                      ),
                                    )
                                  : SizedBox(),
                              title: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: Text(_foundedUsers[index].childName!)),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Divider(
                              thickness: 1,
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "There are no Groups/Friends for your child, please add accordingly"),
                      ],
                    ))
              : SizedBox(),
          _AddGroup
              ? SizedBox(
                  height: 0,
                )
              : SizedBox(),

          _showBottomSheet(),
        ],
      ),
    );
  }

  Widget _showBottomSheet() {
    if (_AddGroup) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 5.0,
                  offset: new Offset(0.0, 2.0),
                ),
              ],
            ),
            height: 70,
            width: double.infinity,
            // color: Colors.white,
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () async {
                  if (FriendsId!.length != 0) {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AddGroup(
                            friendsId: FriendsId,
                            ChoosedChildId: widget.chooseChildId,
                            FromGroupInfo: false,
                            Groupimg: "null")));
                    _AddGroup = false;
                    FriendsId = [];
                    setState(() {
                      _GetFriends();
                    });
                  } else {
                    AppUtils.showToast(
                        "Please add atleast one of your friend to the group",
                        ctx);
                  }
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NEXT",
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green,
                        size: 15,
                      )
                    ],
                  ),
                )),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }

  Widget FriendRequest() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Container(
              height: 35,
              child: TextField(
                style: TextStyle(
                  height: 2.5,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _FriendReqData!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => OtherChildProfile(
                            otherChildID: _FriendReqData![index].childFriendId,
                            chooseChildId: widget.chooseChildId)));
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                  ),
                  title: Text(
                    _FriendReqData![index].childName!,
                  ),
                  trailing: Container(
                    width: width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: width * 0.06,
                          width: width * 0.20,
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => AddCoParent()));
                                int FID = _FriendReqData![index].friendsId!;
                                int CID = _FriendReqData![index].childId!;
                                int CFID =
                                    _FriendReqData![index].childFriendId!;
                                _AcceptFriendReq(CID, CFID, FID);
                              },
                              child: Text("Accept",
                                  style: TextStyle(fontSize: 11))),
                        ),
                        Container(
                          height: width * 0.06,
                          width: width * 0.20,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              onPressed: () {
                                int FID = _FriendReqData![index].friendsId!;
                                int CID = _FriendReqData![index].childId!;
                                int CFID =
                                    _FriendReqData![index].childFriendId!;
                                _CancelFriendReq(CID, CFID);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => AddCoParent()));
                              },
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                              )),
                        ),
                        Icon(
                          Icons.more_vert,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    thickness: 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
        fetchData();
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
        fetchData();
      } else {
        // functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, response.message, "");
        print("error");
      }
    });
  }

  Widget Activities() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            width: width * 0.9,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (searchString) {
                      onSearch3(searchString);
                    },
                    enabled: true,
                    style: TextStyle(height: 1),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    child: DropdownButton(
                      underline: SizedBox(),
                      // Initial Value
                      value: dropdownvalue2,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),

                      // Array list of items
                      items: items2.map((String items2) {
                        return DropdownMenuItem(
                          value: items2,
                          child: Text(
                            items2,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue2 = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          (dropdownvalue2 == "FILTER")
              ? _foundedActivity!.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: _foundedActivity!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Own_Availability(
                                            markavailId:
                                                _foundedActivity![index]
                                                    .markavailId,
                                            fromAct: true,
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        //                   <--- left side
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset:
                                              Offset(1, 1), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            _foundedActivity![index]
                                                    .categoryName! +
                                                " - ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            width: 70,
                                            child: Text(
                                              _foundedActivity![index]
                                                  .activitiesName!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        width: width * 0.36,
                                        child: Row(
                                          children: [
                                            Text(
                                              _foundedActivity![index].dateon!,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 1,
                                              height: 10,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  _foundedActivity![index]
                                                          .fromTime!
                                                          .replaceAll(' PM', '')
                                                          .replaceAll(
                                                              ' AM', '') +
                                                      " - ",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  _foundedActivity![index]
                                                      .toTime!,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      isThreeLine: false,
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            _foundedActivity![index].location!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    )
                  : Spacer()
              : SizedBox(),

/////////////////  My Act //////////////
          (dropdownvalue2 == "MY ACTIVITIES")
              ? _foundedMyActivity!.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: _foundedMyActivity!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Own_Availability(
                                            markavailId:
                                                _foundedMyActivity![index]
                                                    .markavailId,
                                            fromAct: true,
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        //                   <--- left side
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset:
                                              Offset(1, 1), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            _foundedMyActivity![index]
                                                    .categoryName! +
                                                " - ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            width: 70,
                                            child: Text(
                                              _foundedMyActivity![index]
                                                  .activitiesName!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        width: width * 0.36,
                                        child: Row(
                                          children: [
                                            Text(
                                              _foundedMyActivity![index]
                                                  .dateon!,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 1,
                                              height: 10,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  _foundedMyActivity![index]
                                                          .fromTime!
                                                          .replaceAll(' PM', '')
                                                          .replaceAll(
                                                              ' AM', '') +
                                                      " - ",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  _foundedMyActivity![index]
                                                      .toTime!,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      isThreeLine: false,
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            _foundedMyActivity![index]
                                                .location!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    )
                  : Spacer()
              : SizedBox(),
/////////////////  Joined Act //////////////
          (dropdownvalue2 == "JOINED ACTIVITIES")
              ? _foundedJoinedActivity!.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: _foundedJoinedActivity!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Own_Availability(
                                            markavailId:
                                                _foundedJoinedActivity![index]
                                                    .markavailId,
                                            fromAct: true,
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        //                   <--- left side
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset:
                                              Offset(1, 1), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            _foundedJoinedActivity![index]
                                                    .categoryName! +
                                                " - ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            width: 70,
                                            child: Text(
                                              _foundedJoinedActivity![index]
                                                  .activitiesName!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        width: width * 0.36,
                                        child: Row(
                                          children: [
                                            Text(
                                              _foundedJoinedActivity![index]
                                                  .dateon!,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 1,
                                              height: 10,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  _foundedJoinedActivity![index]
                                                          .fromTime!
                                                          .replaceAll(' PM', '')
                                                          .replaceAll(
                                                              ' AM', '') +
                                                      " - ",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  _foundedJoinedActivity![index]
                                                      .toTime!,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      isThreeLine: false,
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            _foundedJoinedActivity![index]
                                                .location!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    )
                  : Spacer()
              : SizedBox()
        ],
      ),
    );
  }

  handleClick(String value) {
    switch (value) {
      case 'ALL':
        setState(() {});
        break;
      case 'GROUPS':
        setState(() {});
        break;
      case 'FRIENDS':
        setState(() {});
        break;
    }
  }
}
