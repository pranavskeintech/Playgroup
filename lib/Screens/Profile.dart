import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Models/GetProfileRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChildProfile.dart';
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
    //AppUtils.showprogress();
    _isLoading = true;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetProfile().then((response) {
      print(response.status);
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
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Text("Edit"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit_outlined,
                                size: 15,
                              )
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
                          children: const [
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
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // (_ProfileData!.coParent!.length == 0)
                  //     ? Container(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Co-Parent",
                  //               style: TextStyle(color: Colors.grey),
                  //             ),
                  //             ElevatedButton(
                  //                 onPressed: () {
                  //                   Navigator.of(context).push(
                  //                       MaterialPageRoute(
                  //                           builder: (BuildContext context) =>
                  //                               AddCoParent()));
                  //                 },
                  //                 child: Text("Add Co-Parent"))
                  //           ],
                  //         ),
                  //       )
                  //     :
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Co-Parent",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Text("Edit"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 15,
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade200,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.1),
                        //     blurRadius: 8.0, // soften the shadow
                        //     spreadRadius: 5.0, //extend the shadow
                        //     offset: Offset(
                        //       2.0, // Move to right 10  horizontally
                        //       2.0, // Move to bottom 10 Vertically
                        //     ),
                        //   )
                        // ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Merin Doe",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("merindoe34@gmail.com"),
                                Text("Access-Complete"),
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Children",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _ProfileData!.children!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChildProfile()));
                          }),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/imgs/child1.jpg"),
                          ),
                          title:
                              Text(_ProfileData!.children![index].childName!),
                          subtitle: Text(
                            TimeAgo.calculateTimeDifferenceBetween(
                                _ProfileData!.children![index].dob),
                          ),
                          trailing: Text(
                            "Remove",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Strings.profilepage = true;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChildDetails()));
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
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(
                                          width: 2,
                                          color:
                                              Colors.grey.withOpacity(0.2))))),
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          );
  }
}
