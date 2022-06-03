import 'package:flutter/material.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChooseChild.dart';
import 'package:playgroup/Screens/LocationSelection.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Screens/OnBoardingScreen.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:playgroup/Screens/Settings.dart';
import 'package:playgroup/Utilities/Strings.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    print("_NavigationDrawer");
    return Drawer(
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Strings.appThemecolor,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ))),
                        Positioned(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ListTile(
                                title: Text(
                                  Strings.parentName,
                                  style: TextStyle(
                                      color: Colors.white.withAlpha(250),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  Strings.parentemail,
                                  style: TextStyle(
                                      color: Colors.white.withAlpha(200)),
                                ),
                                onTap: () => {},
                              ),
                            ],
                          ),
                        )),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                tileColor: Colors.grey.withOpacity(0.1),
                leading: Image.asset(
                  "assets/imgs/home.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Strings.appThemecolor),
                  ),
                ),
                onTap: () => {Navigator.pop(context)},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/profile.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text('Profile'),
                ),
                onTap: () => {
                  print("object"),
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()))
                  // Navigator.of(context).pop()
                },
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/add-user.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text('Add Co Parent'),
                ),
                trailing: Icon(
                  Icons.add_circle_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                onTap: () => {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => AddCoParent()))
                  Navigator.of(context).pop()
                },
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/add_child.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text(
                    'Add Child',
                  ),
                ),
                onTap: () {
                  Strings.DashboardPage = true;
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => ChildDetails()));
                  Navigator.of(context).pop();
                },
                trailing: Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/settings.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text('Settings'),
                ),
                onTap: () => {
                  print("object"),
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => SettingsPage())),
                  Navigator.of(context).pop()
                },
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/blogs.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text('Blogs'),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/delete_account.png",
                  width: 17,
                  height: 17,
                ),
                title: Transform.translate(
                  offset: Offset(-20, -3),
                  child: Text('Delete Account'),
                ),
                onTap: () => {
                  //Navigator.of(context).pop()
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationSelection())),
                },
              ),
              ListTile(
                  leading: Image.asset(
                    "assets/imgs/add_friends.png",
                    width: 17,
                    height: 17,
                  ),
                  title: Transform.translate(
                    offset: Offset(-20, -3),
                    child: Text('Invite Friends'),
                  ),
                  onTap: () => {
                        //Navigator.of(context).pop()},

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnBoardingScreen())),
                      }),
            ],
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.8,
          bottom: 16,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-16, -3),
                  child: Text("Logout"),
                ),
                onTap: () => {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      content: Text(
                        "Are you sure do you want to logout from this app",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 33,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Strings.appThemecolor),
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(color: Colors.white)))),
                              ),
                              //SizedBox(width: 15),
                              SizedBox(
                                width: 100,
                                height: 33,
                                child: ElevatedButton(
                                  onPressed: () {
                                    //Navigator.of(ctx).pop();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                },
              ),
            ],
          ),
        ),
      ]),
    );
    ;
  }
}
