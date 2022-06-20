import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playgroup/Models/AcceptedFriendsRes.dart';
import 'package:playgroup/Models/addGroupParticipants.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class groupParticipants extends StatefulWidget {
  List<int>? groupMembersId;
  int? groupId;
  groupParticipants({Key? key, this.groupMembersId, this.groupId})
      : super(key: key);

  @override
  State<groupParticipants> createState() => _groupParticipantsState();
}

class _groupParticipantsState extends State<groupParticipants> {
  final List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<bool>? _isChecked;

  List<int>? FriendsId = [];

  bool _isLoading = true;

  BuildContext? ctx;

  List<FriendsData>? FriendsDatum;

  int? index1;

  bool _AddGroup = false;

  bool _show = false;

  List<FriendsData> _foundedUsers = [];

  TextEditingController searchController = TextEditingController();

  bool _switchValue = false;

  FriendsData? HeaderData;

  FriendsData? ListViewData;

  List<int>? first;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => getFriends());
  }

  getFriends() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAcceptedFriendReq(Strings.ChoosedChild).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          FriendsDatum = response.data!;

          _isChecked = List<bool>.filled(FriendsDatum!.length, false);
          var frnds = [];
          for (var i = 0; i < FriendsDatum!.length; i++) {
            frnds.add(FriendsDatum![i].childId!);
          }
          print("1:${frnds}");
          print("2:${widget.groupMembersId}");
          for (var i = 0; i < FriendsDatum!.length; i++) {
            if (widget.groupMembersId!.contains(FriendsDatum![i].childId)) {
              index1 = i;
              ListViewData = FriendsDatum!.removeAt(index1!);
            }
            print("3:${index1}");
          }
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  // onSearch(String search) {
  //   print("Searching for $search");
  //   setState(() {
  //     _foundedUsers = FriendsDatum!
  //         .where((user) =>
  //             user.childName!.toLowerCase().contains(search.toLowerCase()))
  //         .toList();
  //     print(_foundedUsers.length);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Strings.appThemecolor,
            title: Text("Add Friends"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp),
            ),
          ),
          // resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return groupParticipants(newContext);
          }),
        ));
  }

  groupParticipants(BuildContext context) {
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
                            //onSearch(searchString);
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
                FriendsDatum!.length > 0
                    ? Expanded(
                        child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: FriendsDatum!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  leading: Transform.translate(
                                    offset: Offset(-16, 0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          FriendsDatum![index].profile != "null"
                                              ? NetworkImage(Strings.imageUrl +
                                                  (FriendsDatum![index]
                                                          .profile ??
                                                      ""))
                                              : AssetImage(
                                                      "assets/imgs/appicon.png")
                                                  as ImageProvider,
                                    ),
                                  ),
                                  title: Transform.translate(
                                    offset: Offset(-16, 0),
                                    child:
                                        Text(FriendsDatum![index].childName!),
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
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
                                                    FriendsDatum![index]
                                                        .childId!);
                                              } else {
                                                _isChecked?[index] = val;
                                                FriendsId!.remove(
                                                    FriendsDatum![index]
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
                    : SizedBox(
                        height: 5,
                      ),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (FriendsId!.length == 0) {
                            AppUtils.showWarning(
                                context, "Choose Friends to join group", "");
                          } else {
                            addGroupParticipant();
                          }
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

  addGroupParticipant() {
    AppUtils.showprogress();
    print("frnds:$FriendsId");
    addGroupParticipants groupParticipants = addGroupParticipants();
    groupParticipants.groupMembers = FriendsId;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .addParticipantsGroup(groupParticipants, widget.groupId!)
        .then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        functions.createSnackBarGreen(context, response.message.toString());
        Navigator.pop(context);
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
        FriendsId!.add(FriendsDatum![i].childId!);
      }
    }
  }
}
