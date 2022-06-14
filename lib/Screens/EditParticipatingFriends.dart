import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playgroup/Models/AcceptedFriendsRes.dart';
import 'package:playgroup/Models/EditAvailabilityCommonReq.dart';
import 'package:playgroup/Models/MarkAvailabilityReq.dart';
import 'package:playgroup/Models/OwnAvailabilityDetailsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class EditParticipatingFriends extends StatefulWidget {
  const EditParticipatingFriends({Key? key}) : super(key: key);

  @override
  State<EditParticipatingFriends> createState() =>
      EditParticipatingFriendsState();
}

class EditParticipatingFriendsState extends State<EditParticipatingFriends> {
  List<bool> values = [];

  final List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<bool>? _isChecked;

  TextEditingController searchController = TextEditingController();

  bool _switchValue = false;

  BuildContext? ctx;

  List<FriendsData>? FriendsDatum;

  List<FriendsData> _foundedUsers = [];

  bool _isLoading = true;

  List<Data> availabilityData = [];

  List<int>? FriendsId = [];

  _GetFriends() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAcceptedFriendReq(Strings.SelectedChild).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          FriendsDatum = response.data!;

          setState(() {
            _foundedUsers = FriendsDatum!;
            print("1:${_foundedUsers[0].childId!}");
            print("2:${_foundedUsers[1].childId!}");
          });
          _isLoading = false;
          getAvailabilityDetails();
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  getAvailabilityDetails() {
    print("check");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .getAvailabilityDetails(
            Strings.selectedAvailability!, Strings.SelectedChild)
        .then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          availabilityData = response.data!;
          _isLoading = false;
          updateSelectedChilds();
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  updateSelectedChilds() {
    print("color");
    for (var i = 0; i < availabilityData[0].friendsdata!.length; i++) {
      for (var j = 0; j < _foundedUsers.length; j++) {
        print(
            "avail data ${availabilityData[0].friendsdata![i].childFriendId}");
        print(" found ${_foundedUsers[j].childId}");

        if (availabilityData[0].friendsdata![i].childFriendId ==
            _foundedUsers[j].childId) {
          setState(() {
            _isChecked![j] = true;
          });
        }
      }
    }
    updateFriendsID();
  }

  @override
  void initState() {
    // TODO: implement initState
    _isChecked = List<bool>.filled(_texts.length, false);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetFriends());
  }

  updateFriendsID() {
    for (var i = 0; i < _isChecked!.length; i++) {
      if (_isChecked![i] == true) {
        FriendsId!.add(_foundedUsers[i].childId!);
      }
    }

    print(FriendsId);
  }

  onSearch(String search) {
    print("Searching for $search");
    setState(() {
      _foundedUsers = FriendsDatum!
          .where((user) =>
              user.childName!.toLowerCase().contains(search.toLowerCase()))
          .toList();
      print(_foundedUsers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Strings.appThemecolor,
            title: Text("Your Availability"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp),
            ),
          ),
          // resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return MarkAvail(newContext);
          }),
        ));
  }

  MarkAvail(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Strings.textFeildBg,
                      border: Border.all(color: Strings.textFeildBg),
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  child: TextField(
                    onChanged: (searchString) {
                      onSearch(searchString);
                    },
                    enabled: true,
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    textAlign: TextAlign.justify,
                    style: TextStyle(height: 1),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Search",
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Strings.textFeildBg),
                            borderRadius: BorderRadius.circular(6)),
                        filled: true,
                        fillColor: Strings.textFeildBg,
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Select all friends",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Switch(
                      activeColor: Colors.blue,
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });

                        if (_switchValue == true) {
                          for (var index = 0;
                              _isChecked!.length > index;
                              index++) {
                            _isChecked![index] = true;
                          }
                        } else {
                          for (var index = 0;
                              _isChecked!.length > index;
                              index++) {
                            _isChecked![index] = false;
                          }
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: _foundedUsers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Transform.translate(
                              offset: Offset(-16, 0),
                              child: CircleAvatar(
                                backgroundImage: _foundedUsers[index].profile !=
                                        "null"
                                    ? NetworkImage(Strings.imageUrl +
                                        (_foundedUsers[index].profile ?? ""))
                                    : AssetImage("assets/imgs/appicon.png")
                                        as ImageProvider,
                              ),
                            ),
                            title: Transform.translate(
                              offset: Offset(-16, 0),
                              child: Text(_foundedUsers[index].childName!),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              width: 20,
                              height: 20,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                  checkColor: Colors.green,
                                  activeColor: Colors.transparent,
                                  value: _isChecked?[index],
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        if (val!) {
                                          _isChecked?[index] = val;
                                          FriendsId!.add(
                                              _foundedUsers[index].childId!);
                                          print("friends:${FriendsId}");
                                        } else {
                                          _isChecked?[index] = val;
                                          FriendsId!.remove(
                                              _foundedUsers[index].childId!);
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.4),
                          height: 1,
                        ),
                      ],
                    );
                  },
                )),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _EditParticipatingFriends();
                        },
                        child: Text(
                          "Done",
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Strings.appThemecolor)),
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
  }

  // _MarkAvailability() {
  //   AppUtils.showprogress();

  //   MarkAvailabilityReq markavail = MarkAvailabilityReq();

  //   markavail.childId = Strings.SelectedChild;
  //   markavail.date = Strings.markAvailabiltydate;
  //   markavail.from = Strings.markAvailabiltystartTime;
  //   markavail.to = Strings.markAvailabiltyendTime;
  //   markavail.description = Strings.markAvailabiltydesc;
  //   markavail.location = Strings.markAvailabiltylocations;
  //   markavail.activitiesId = Strings.markAvailabiltyTopic;
  //   markavail.sportId = Strings.markAvailabiltycategory;
  //   markavail.friendId = FriendsId;

  //   var dat = jsonEncode(markavail);
  //   print(dat);
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   api.createAvailability(markavail).then((response) {
  //     print('response ${response.status}');
  //     if (response.status == true) {
  //       AppUtils.dismissprogress();
  //       Navigator.of(context).push(
  //           MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
  //     } else {
  //       functions.createSnackBar(context, response.message.toString());
  //       AppUtils.dismissprogress();
  //       print("error");
  //     }
  //   });
  // }

  _EditParticipatingFriends() {
    EditAvailabilityCommonReq editAvailability = EditAvailabilityCommonReq();
    editAvailability.from = "";
    editAvailability.to = "";
    editAvailability.childId = availabilityData[0].childId!;
    editAvailability.markId = availabilityData[0].markavailId!;
    print("3:${availabilityData[0].childId!}");
    print("4:${availabilityData[0].markavailId!}");
    print("5:${FriendsId}");
    editAvailability.friendId = FriendsId;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.EditAvailability(editAvailability).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
        print("result2:$response");
      } else {
        functions.createSnackBar(ctx, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }
}
