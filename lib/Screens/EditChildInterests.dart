import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Models/EditChildReq.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Models/GetInterestsRes.dart';
import 'package:playgroup/Models/editChildInterests.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class EditChildInterests extends StatefulWidget {
  int? chooseChildId;
  List? InterestsList;
  EditChildInterests({
    Key? key,
    this.chooseChildId,
    this.InterestsList,
  }) : super(key: key);

  @override
  State<EditChildInterests> createState() => _EditChildInterestsState();
}

class _EditChildInterestsState extends State<EditChildInterests> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> images = [
    "music.jpg",
    "dance.jpg",
    "science.jpg",
    "cricket.jpg",
    "hockey.jpg",
    "cooking.jpg",
    "reading.jpg",
    "art.jpg",
    "outdoor.jpg",
    "trekking.jpg",
    "singing.jpg",
    "pottery.jpg"
  ];
  List<String> activities = [
    "Music",
    "Dance",
    "Science",
    "Cricket",
    "Hockey",
    "Cooking",
    "Reading",
    "Art",
    "Outdoor games",
    "Trekking",
    "Singing",
    "Pottery"
  ];
  List<bool> _tick = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<int> _selectedvalues = [];
  bool _limitImage = true;

  BuildContext? ctx;

  bool _isLoading = true;

  List<Data>? _InterestData;

  List<childData>? _ChildData;

  fetchInterest() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetInterests(widget.chooseChildId!).then((response) {
      print(response.status);
      if (response.status == true) {
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));

        setState(() {
          _InterestData = response.data;
          updateSelectedChilds();
          _GetChildData();
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

  _GetChildData() {
    //int? PId = Strings.Parent_Id;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetChild().then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          _ChildData = response.data;
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  updateSelectedChilds() {
    for (var i = 0; i < widget.InterestsList!.length; i++) {
      for (var j = 0; j < _InterestData!.length; j++) {
        print("avail data ${widget.InterestsList!}");
        print(" found ${_InterestData![j].interestsId}");

        if (widget.InterestsList![i] == _InterestData![j].interestsId) {
          setState(() {
            print("hiii");
            _tick[j] = true;
          });
        }
      }
    }
    // updateFriendsID();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchInterest());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return EditInt(newContext);
          }),
        ));
  }

  EditInt(BuildContext context) {
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
                  "Edit Child Interests",
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: (_InterestData!.length == 0)
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(left: 85, right: 85),
                          child: Text(
                            "Interests are not available for this child age category",
                            textAlign: TextAlign.center,
                          ),
                        ))
                      : GridView.builder(
                          padding: EdgeInsets.fromLTRB(14, 100, 14, 0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 120),
                          itemCount: _InterestData!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _tick[index] = !_tick[index];
                                  });
                                },
                                child: Column(children: [
                                  Stack(children: [
                                    Opacity(
                                      opacity: _tick[index] ? 0.2 : 1.0,
                                      child: CircleAvatar(
                                        backgroundImage: _InterestData![index]
                                                    .interestImage! !=
                                                "null"
                                            ? NetworkImage(Strings.imageUrl +
                                                "interests/" +
                                                (_InterestData![index]
                                                    .interestImage!))
                                            : AssetImage(
                                                    "assets/imgs/appicon.png")
                                                as ImageProvider,
                                        radius: 33,
                                      ),
                                    ),
                                    Container(
                                      child: Visibility(
                                        visible: _tick[index],
                                        child: Positioned(
                                          right: 3,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/imgs/tick.png"),
                                            radius: 8,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(_InterestData![index].interestName!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ]),
                              ),
                            );
                          }),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            for (int i = 0; i < 12; i++) {
                              if (_tick[i] == true) {
                                _selectedvalues
                                    .add(_InterestData![i].interestsId!);
                                print(_selectedvalues);
                                // _selectedvalues[i] =
                                //     _InterestData![i].interestsId!;
                                // updateFriendsID();
                              } else {
                                // _selectedvalues[i] = "null";
                                continue;
                              }
                            }
                            _EditChild();
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Strings.appThemecolor)),
                        )),
                  ),
                )
              ],
            ),
          );
  }

  // updateFriendsID() {
  //   for (var i = 0; i < _tick.length; i++) {
  //     if (_tick[i] == true) {
  //       _selectedvalues.add(widget.InterestsList![i].childId!);
  //     }
  //   }

  //   print("frnds:$_selectedvalues");
  // }

  _EditChild() {
    print("hiiiiiiii:$_selectedvalues");
    editChildInt ChildEdit = editChildInt();
    ChildEdit.childId = _ChildData![Strings.editIndex].childId;
    ChildEdit.childInterest = _selectedvalues;
    print(jsonEncode(ChildEdit));
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.EditChildInterest(ChildEdit).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        _selectedvalues = [];
        AppUtils.dismissprogress();
        Navigator.pop(context);
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
