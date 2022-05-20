import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Models/UserDetailsRes.dart';
import 'package:playgroup/Screens/Availability-Choose_category.dart';
import 'package:playgroup/Screens/ChatsPage.dart';
import 'package:playgroup/Screens/HomeScreen.dart';
import 'package:playgroup/Screens/InitialHome.dart';
import 'package:playgroup/Screens/Mark_availability.dart';
import 'package:playgroup/Screens/Notification.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:playgroup/Screens/Search.dart';
import 'package:playgroup/Utilities/ExitPopup.dart';
import 'package:playgroup/Utilities/NavigationDrawer.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:playgroup/Utilities/Functions.dart';

import '../Network/ApiService.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _bottomNavIndex = 0;

  List<IconData> iconList = [];

  final screens = [
    HomeScreen(),
    InitialScreen(),
    //  Center(child:Text("Past Activities")),
    //  Center(child:Text("Search")),
    //  Center(child:Text("Notification")),

    SearchScreen(),
    NotificationScreen(),
    //Mark_Availabilty(),
  ];

  var ctx;

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    iconList.add(Icons.home);
    iconList.add(Icons.schedule);
    iconList.add(Icons.search);
    iconList.add(Icons.notifications);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
          key: _scaffoldKey,
          drawer: NavigationDrawer(),
          appBar: AppBar(
            centerTitle: false,
            elevation: 1,
            toolbarHeight: 62,
            // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
            backgroundColor: Colors.white,
            title: Transform(
              transform: Matrix4.translationValues(-15.0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/imgs/appicon.png",
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Play Group",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  // builder: (BuildContext context) => ProfileScreen()));
                  showDialog<void>(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Image(
                              image: AssetImage(
                                  "assets/imgs/child5.jpg")), //Hard code for profile image
                        );
                      });
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(
                      "assets/imgs/child5.jpg"), //Hard code for profile image
                ),
              ),
              SizedBox(
                width: 3,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Chat_List()));
                  },
                  icon: Image.asset(
                    "assets/imgs/chat.png",
                    width: 25,
                    height: 25,
                  ))
            ],
            leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: ImageIcon(
                  AssetImage("assets/imgs/menu_ver2.png"),
                  color: Colors.black,
                )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Mark_Availabilty()));
              // Navigator.of(context).push(MaterialPageRoute(
              //         builder: (BuildContext context) => Choose_Category()));
            },
            backgroundColor: Strings.appThemecolor,
            child: Icon(Icons.add),

            //params
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              height: 60,
              icons: iconList,
              activeIndex: _bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.defaultEdge,
              leftCornerRadius: 0,
              rightCornerRadius: 0,
              backgroundColor: Strings.appThemecolor,
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _bottomNavIndex = index;
                });
                print(index);
              }
              //other params
              ),
          body: screens[_bottomNavIndex]),
    );
  }
  //  getParentsDetails() {
  //   var PId = Strings.Parent_Id!.toInt();
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   api.getParentsDetails(PId).then((response) {
  //     print(response.status);
  //     if (response.status == true) {
  //       //_btnController.stop();
  //       // Navigator.of(context).push(
  //       //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
  //       _UserData = response.data;
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } else {
  //       functions.createSnackBar(context, response.status.toString());
  //       // _btnController.stop();
  //     }
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }
}
