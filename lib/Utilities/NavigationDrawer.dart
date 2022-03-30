import 'package:flutter/material.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Utilities/Strings.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(28)),
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
                                  'John Albhin',
                                  style: TextStyle(
                                      color: Colors.white.withAlpha(250),
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Johnalbin@gmail.com",
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
                leading: Image.asset(
                  "assets/imgs/home.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Home'),
                ),
                onTap: () => {},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/profile.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Profile'),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/add-user.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Add Co Parent'),
                ),
                trailing: Icon(
                  Icons.add_circle_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/add_child.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text(
                    'Add Child',
                  ),
                ),
                onTap: () => {Navigator.of(context).pop()},
                trailing: Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/settings.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Settings'),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/blogs.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Blogs'),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/delete_account.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Delete Account'),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Image.asset(
                  "assets/imgs/add_friends.png",
                  width: 20,
                  height: 20,
                ),
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Text('Invite Friends'),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
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
                leading: Icon(Icons.exit_to_app),
                title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Text("Logout"),
                ),
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ))
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
