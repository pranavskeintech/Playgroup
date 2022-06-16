import 'package:flutter/material.dart';
import 'package:playgroup/Models/GetGroupDetailsByIdRes.dart';
import 'package:playgroup/Models/RemoveParticipantsReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddGroup.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Screens/groupParticipants.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class Groupinfo extends StatefulWidget {
  final int? groupId;
  final int? choosedChildId;
  Groupinfo({Key? key, this.groupId, this.choosedChildId}) : super(key: key);

  @override
  State<Groupinfo> createState() => _GroupinfoState();
}

class _GroupinfoState extends State<Groupinfo> {
  bool value = false;

  bool _showDelete = false;

  bool _isPressed = false;

  BuildContext? ctx;

  GetGroupDetailsByIdRes? _GroupData;

  List<bool>? _isChecked;

  final List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<int>? FriendsId = [];

  bool _isLoading = true;

  List<int>? GroupMembersId = [];

  List<GroupMembers>? GroupMembData = [];

  int? index1;

  GroupMembers? ListViewData;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchData());
  }

  fetchData() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetGroupDetailsbyId(widget.groupId!).then((response) {
      if (response.status == true) {
        setState(() {
          _GroupData = response;

          _isChecked =
              List<bool>.filled(_GroupData!.groupMembers!.length, false);
          _isLoading = false;
        });
      } else {
        _isLoading = false;
        functions.createSnackBar(context, response.status.toString());
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return GroupInfo(newContext);
          }),
        ));
  }

  GroupInfo(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            appBar: AppBar(
              //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
              backgroundColor: Strings.appThemecolor,
              title: Text(
                "Group Info",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: ImageIcon(
                    AssetImage("assets/imgs/back arrow.png"),
                    color: Colors.white,
                  )),
            ),
            bottomSheet: _showBottomSheet(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        _GroupData!.groupDetails![0].groupName!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      (widget.choosedChildId ==
                              _GroupData!.groupDetails![0].createdBy!)
                          ? IconButton(
                              icon: Image.asset(
                                "assets/imgs/compose.png",
                                fit: BoxFit.fill,
                                color: Colors.blue,
                                width: 15,
                                height: 15,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => AddGroup(
                                        FromGroupInfo: true,
                                        groupId: _GroupData!
                                            .groupDetails![0].groupId!,
                                        GroupName: _GroupData!
                                            .groupDetails![0].groupName!,
                                        Groupimg: _GroupData!
                                            .groupDetails![0].groupImage!)));
                              },
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("(${_GroupData!.groupMembers!.length}) "
                          "Friends"),
                      (widget.choosedChildId ==
                              _GroupData!.groupDetails![0].createdBy!)
                          ? TextButton(
                              onPressed: () async {
                                for (var i = 0;
                                    i < _GroupData!.groupMembers!.length;
                                    i++) {
                                  GroupMembersId!.add(
                                      _GroupData!.groupMembers![i].childId!);
                                }

                                print("frnds:$GroupMembersId");
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            groupParticipants(
                                                groupMembersId: GroupMembersId,
                                                groupId: _GroupData!
                                                    .groupDetails![0]
                                                    .groupId)));
                                setState(() {
                                  fetchData();
                                });
                              },
                              child: Row(
                                children: const [
                                  Text("Add Friends"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.person_add_alt_1,
                                    size: 15,
                                  )
                                ],
                              ))
                          : SizedBox(
                              height: 65,
                            ),
                    ],
                  ),
                ),
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
                    physics: BouncingScrollPhysics(),
                    itemCount: _GroupData!.groupMembers!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ListTile(
                          onLongPress: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) => ChildProfile()));

                            setState(() {
                              _showDelete = true;
                              (widget.choosedChildId ==
                                      _GroupData!.groupDetails![0].createdBy!)
                                  ? _isPressed = true
                                  : _isPressed = false;
                            });
                          },
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OtherChildProfile()));
                          },
                          leading: CircleAvatar(
                            backgroundImage: _GroupData!
                                        .groupMembers![index].profile !=
                                    "null"
                                ? NetworkImage(Strings.imageUrl +
                                    (_GroupData!.groupMembers![index].profile ??
                                        ""))
                                : AssetImage("assets/imgs/appicon.png")
                                    as ImageProvider,
                          ),
                          trailing: _isPressed
                              ? Container(
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
                                        // side: BorderSide(color: Colors.black),
                                        checkColor: Colors.green,
                                        activeColor: Colors.transparent,
                                        //hoverColor: Colors.black,
                                        value: _isChecked?[index],
                                        onChanged: (val) {
                                          setState(() {
                                            if (val!) {
                                              _isChecked?[index] = val;
                                              FriendsId!.add(_GroupData!
                                                  .groupMembers![index]
                                                  .childId!);
                                            } else {
                                              _isChecked?[index] = val;
                                              FriendsId!.remove(_GroupData!
                                                  .groupMembers![index]
                                                  .childId!);
                                            }
                                          });
                                        }),
                                  ),
                                )
                              : (_GroupData!.groupMembers![index].childId! ==
                                      _GroupData!.groupDetails![0].createdBy!)
                                  ? ImageIcon(
                                      AssetImage("assets/imgs/Admin.png"),
                                      //color: Colors.green,
                                      size: 90,
                                    )
                                  : null,
                          title: (widget.choosedChildId ==
                                  _GroupData!.groupMembers![index].childId!)
                              ? Text(
                                  "You",
                                  //style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  _GroupData!.groupMembers![index].childName!,
                                  // style: TextStyle(fontWeight: FontWeight.w500),
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
                _showDelete
                    ? SizedBox(
                        height: 70,
                      )
                    : SizedBox(),
              ],
            ),
          );
  }

  Widget? _showBottomSheet() {
    if (_showDelete) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => AddGroup()));
                        setState(() {
                          _showDelete = false;
                          _isPressed = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            _isLoading = true;
                            removeParticipants();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                AssetImage("assets/imgs/delete_1.png"),
                                //color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Delete",
                                // style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _showDelete = false;
                            _isPressed = false;
                          });
                        },
                        icon: Icon(Icons.clear, color: Colors.blue)),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return null;
    }
  }

  removeParticipants() {
    RemoveParticipantsGroupReq GroupInfo = RemoveParticipantsGroupReq();
    print("id:$FriendsId");
    GroupInfo.groupParticipants = FriendsId;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .removeParticipantsGroup(
            GroupInfo, _GroupData!.groupDetails![0].groupId!)
        .then((response) {
      if (response.status == true) {
        setState(() {
          fetchData();

          _isPressed = false;
          _isLoading = false;
          functions.createSnackBarGreen(context, response.message.toString());
        });
      } else {
        _isLoading = false;
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
