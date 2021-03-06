import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playgroup/Models/AcceptedFriendsRes.dart';
import 'package:playgroup/Models/MarkAvailabilityReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class Availability_choose_friends extends StatefulWidget {
  const Availability_choose_friends({Key? key}) : super(key: key);

  @override
  State<Availability_choose_friends> createState() =>
      _Availability_choose_friendsState();
}

class _Availability_choose_friendsState
    extends State<Availability_choose_friends> {
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

  var FriendsId = [];

  bool noMatchFound = false;
  _GetFriends() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAcceptedFriendReq(Strings.SelectedChild).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          FriendsDatum = response.data!;

          setState(() {
            _foundedUsers = FriendsDatum!;
            _isChecked = List<bool>.filled(_foundedUsers.length, false);
          });
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetFriends());
  }

  onSearch(String search) {
    print("Searching for $search");
    setState(() {
      _foundedUsers = FriendsDatum!
          .where((user) =>
              user.childName!.toLowerCase().contains(search.toLowerCase()))
          .toList();
      if (_foundedUsers.length == 0) {
        noMatchFound = true;
      } else {
        noMatchFound = false;
      }
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: FriendsDatum!.length > 0
                      ? Text(
                          "Choose Friends to join you?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      : Text(
                          "You dont have friends, Kindly add friends from homescreen!",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                ),
                SizedBox(height: 20),
                FriendsDatum!.length > 0
                    ? Container(
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
                                  borderSide:
                                      BorderSide(color: Strings.textFeildBg),
                                  borderRadius: BorderRadius.circular(6)),
                              filled: true,
                              fillColor: Strings.textFeildBg,
                              prefixIcon: Icon(Icons.search)),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                FriendsDatum!.length > 0
                    ? Row(
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
                                updateFriendsID();
                              } else {
                                for (var index = 0;
                                    _isChecked!.length > index;
                                    index++) {
                                  _isChecked![index] = false;
                                }
                                FriendsId = [];
                              }
                            },
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                noMatchFound
                    ? Expanded(
                        child: Column(
                          children: [
                            Center(
                              child: Text("No Match Found"),
                            ),
                          ],
                        ),
                      )
                    : FriendsDatum!.length > 0
                        ? Expanded(
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
                                          backgroundColor: Colors.white,
                                          backgroundImage: _foundedUsers[index]
                                                      .profile !=
                                                  "null"
                                              ? NetworkImage(Strings.imageUrl +
                                                  (_foundedUsers[index]
                                                          .profile ??
                                                      ""))
                                              : AssetImage(
                                                      "assets/imgs/profile-user.png")
                                                  as ImageProvider,
                                        ),
                                      ),
                                      title: Transform.translate(
                                        offset: Offset(-16, 0),
                                        child: Text(
                                            _foundedUsers[index].childName!),
                                      ),
                                      trailing: Container(
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
                                            checkColor: Colors.green,
                                            activeColor: Colors.transparent,
                                            value: _isChecked?[index],
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  if (val!) {
                                                    _isChecked?[index] = val;
                                                    FriendsId.add(
                                                        _foundedUsers[index]
                                                            .childId!);
                                                  } else {
                                                    _isChecked?[index] = val;
                                                    FriendsId.remove(
                                                        _foundedUsers[index]
                                                            .childId!);
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
                          ))
                        : Spacer(),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (FriendsId.length == 0) {
                          //   AppUtils.showWarning(context,
                          //       "Choose Friends to join the availability", "");
                          // } else {
                          _MarkAvailability();
                          //}
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

  _MarkAvailability() {
    //AppUtils.showprogress();

    MarkAvailabilityReq markavail = MarkAvailabilityReq();

    markavail.childId = Strings.SelectedChild;
    markavail.date = Strings.markAvailabiltydate;
    markavail.from = Strings.markAvailabiltystartTime;
    markavail.to = Strings.markAvailabiltyendTime;
    markavail.description = Strings.markAvailabiltydesc;
    markavail.location = Strings.markAvailabiltylocations;
    (Strings.markAvailabiltyTopic != null)
        ? markavail.activitiesId = Strings.markAvailabiltyTopic
        : markavail.activitiesId = 0;
    (Strings.markAvailabiltycategory != null)
        ? markavail.sportId = Strings.markAvailabiltycategory
        : markavail.sportId = 0;
    markavail.friendId = FriendsId;

    var dat = jsonEncode(markavail);
    print(dat);
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.createAvailability(markavail).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        AppUtils.showToast(response.message, context);
        Strings.markAvailabiltydate = "";
        Strings.markAvailabiltystartTime = "";
        Strings.markAvailabiltyendTime = "";
        Strings.markAvailabiltydesc = "";
        Strings.markAvailabiltylocations = "";
        Strings.markAvailabiltyTopic = null;
        Strings.markAvailabiltycategory = null;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
      } else {
        functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }

  updateFriendsID() {
    for (var i = 0; i < _isChecked!.length; i++) {
      if (_isChecked![i] == true) {
        FriendsId.add(_foundedUsers[i].childId!);
      }
    }

    print("frnds:$FriendsId");
  }
}
