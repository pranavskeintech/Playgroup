import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Models/GetProfileRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChildProfile.dart';
import 'package:playgroup/Screens/EditCoParent.dart';
import 'package:playgroup/Screens/Forgotpassword.dart';
import 'package:playgroup/Screens/PhoneNumber.dart';
import 'package:playgroup/Screens/SignupEmailScreen.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/NavigationDrawer.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext? ctx;
  List<ChildData>? _ChildData;

  Profile? _ProfileData;

  bool _isLoading = true;

  _GetProfile() {
    print("object");
    //AppUtils.showprogress();
    _isLoading = true;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetProfile().then((response) {
      print(response.status);
      print("object");
      if (response.status == true) {
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
        setState(() {
          // AppUtils.dismissprogress();
          _isLoading = false;
          _ProfileData = response.profile;
          print("object:${_ProfileData!.coParent}");
        });
        print("data: ${_ChildData!.length.toString()}");
      } else {
        functions.createSnackBar(context, response.status.toString());
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return ProfilePage(newContext);
          }),
        ));
  }

  ProfilePage(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            key: _scaffoldKey,
            drawer: NavigationDrawer(),
            appBar: AppBar(
              //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
              backgroundColor: Strings.appThemecolor,
              title: Text(
                "Profile",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: ImageIcon(
                    AssetImage("assets/imgs/menu_ver2.png"),
                    color: Colors.white,
                  )),
            ),
            body: Container(
              // color: Colors.white,
              padding: EdgeInsets.fromLTRB(28, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Profile",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignupEmailScreen(
                                      fromProfile: true,
                                      name: _ProfileData!.parentName!,
                                      email: _ProfileData!.emailId!,
                                    )));
                          },
                          child: Row(
                            children: [
                              Text("Edit"),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/imgs/compose.png",
                                fit: BoxFit.fill,
                                color: Colors.blue,
                                width: 15,
                                height: 15,
                              ),
                            ],
                          ))
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _ProfileData!.parentName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                        height: 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email ID",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _ProfileData!.emailId!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Number",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _ProfileData!.phone!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                        height: 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              child: Text(
                                "Change Password",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                Strings.fromProfile = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Forgotpassword()));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  (_ProfileData!.coParent!.length == 0)
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Co-Parent",
                                style: TextStyle(color: Colors.grey),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AddCoParent()));
                                  },
                                  child: Text("Add Co-Parent"))
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _ProfileData!
                                                  .role == "PARENT"?
                                  "Co-Parent":"Owner",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EditCoParent(
                                                    name: _ProfileData!
                                                        .coParent?[0]
                                                        .parentName,
                                                    email: _ProfileData!
                                                        .coParent?[0].emailId,
                                                    PhoneNumber: _ProfileData!
                                                        .coParent?[0].phone,
                                                    password: _ProfileData!
                                                        .coParent?[0].password,
                                                    selectedAcces: _ProfileData!
                                                        .coParent?[0].access,
                                                  )));
                                    },
                                    child: _ProfileData!.role == "PARENT"
                                        ? Row(
                                            children: [
                                              Text("Edit"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                "assets/imgs/compose.png",
                                                fit: BoxFit.fill,
                                                color: Colors.blue,
                                                width: 15,
                                                height: 15,
                                              ),
                                            ],
                                          )
                                        : SizedBox())
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _ProfileData!.coParent?[0]
                                                      .parentName ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // IconButton(onPressed: deleteCoParent(), icon: (Icon(Icons.delete_outline,size: 20)))
                                            // GestureDetector(child: Icon(Icons.delete_outline,size: 20,),onDoubleTap: deleteCoParent(),)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Text(
                                              _ProfileData!
                                                      .coParent?[0].emailId ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text("Access: "),
                                              Text(
                                                  _ProfileData!.coParent?[0]
                                                          .access ??
                                                      "",
                                                  style: TextStyle(
                                                      color: _ProfileData!
                                                                  .coParent?[0]
                                                                  .access !=
                                                              "VIEW"
                                                          ? Colors.green
                                                          : Colors.orange)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Children",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _ProfileData!.children!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 7),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: ListTile(
                              onTap: (() {
                                var chooseChildId =
                                    _ProfileData!.children![index].childId;
                                var chooseChildName =
                                    _ProfileData!.children![index].childName;
                                Strings.ChoosedChild =
                                    _ProfileData!.children![index].childId!;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChildProfile(
                                            chooseChildId: chooseChildId,chooseChildName:chooseChildName)));
                              }),
                              leading: CircleAvatar(
                                  backgroundImage: _ProfileData!
                                              .children![index].profile !=
                                          "null"
                                      ? NetworkImage(Strings.imageUrl +
                                          (_ProfileData!
                                                  .children![index].profile ??
                                              ""))
                                      : AssetImage("assets/imgs/appicon.png")
                                          as ImageProvider),
                              title: Text(
                                  _ProfileData!.children![index].childName!),
                              subtitle: Text(
                                TimeAgo.calculateTimeDifferenceOfSeconds(
                                    _ProfileData!.children![index].dob),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  deleteChild(
                                      _ProfileData!.children![index].childId,
                                      index);
                                },
                                child: Container(
                                  height: 200,
                                  width: 75,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Remove",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Icon(
                                        Icons.clear,
                                        size: 15,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Strings.profilepage = true;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChildDetails(
                                        fromProfile: true,
                                      )));
                            },
                            child: Text(
                              "Add Child",
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
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          );
  }

  deleteChild(childId, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Child"),
            content: Text("Are you sure you want to delete this child?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Strings.appThemecolor,
                ),
                child: Text("Delete"),
                onPressed: () {
                  AppUtils.showprogress();
                  setState(() {
                    final api = Provider.of<ApiService>(ctx!, listen: false);
                    api.DeleteChild(childId).then((response) {
                      print(response.status);
                      print("object");
                      if (response.status == true) {
                        //_btnController.stop();
                        AppUtils.dismissprogress();

                        setState(() {
                          _ProfileData!.children!.removeAt(index);
                          Navigator.pop(context);
                        });
                      } else {
                        functions.createSnackBar(
                            context, response.status.toString());
                        AppUtils.dismissprogress();
                      }
                    }).catchError((onError) {
                      print(onError.toString());
                      AppUtils.dismissprogress();
                    });
                  });
                },
              )
            ],
          );
        });
  }

  deleteCoParent() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Child"),
            content: Text("Are you sure you want to delete this child?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Strings.appThemecolor,
                ),
                child: Text("Delete"),
                onPressed: () {
                  AppUtils.showprogress();
                  final api = Provider.of<ApiService>(ctx!, listen: false);
                  api.deleteCoParent().then((response) {
                    print(response.status);
                    print("object");
                    if (response.status == true) {
                      //_btnController.stop();
                      AppUtils.dismissprogress();
                      AppUtils.showToast(
                          "Co Parent deleted successfully", context);
                      _GetProfile();
                    } else {
                      functions.createSnackBar(
                          context, response.status.toString());
                      AppUtils.dismissprogress();
                    }
                  }).catchError((onError) {
                    print(onError.toString());
                    AppUtils.dismissprogress();
                  });
                },
              )
            ],
          );
        });
  }
}
