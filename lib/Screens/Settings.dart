import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                    }),
                    title: Text("Account"),
                    subtitle: Text(
                      "Lorm ipsum dolor sit amet,consectetur",
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing:
                        //  Icon(
                        //   Icons.arrow_right_alt,
                        //   color: Colors.grey,
                        //   size: 20,
                        // ),
                        IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage("assets/imgs/right arrow.png"),
                              size: 16,
                            )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                    }),
                    title: Text("Privacy"),
                    subtitle: Text("Lorm ipsum dolor sit amet,consectetur",
                        style: TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("assets/imgs/right arrow.png"),
                          size: 16,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                    }),
                    title: Text("Location"),
                    subtitle: Text("Lorm ipsum dolor sit amet,consectetur",
                        style: TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("assets/imgs/right arrow.png"),
                          size: 16,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                    }),
                    title: Text("Help"),
                    subtitle: Text("Lorm ipsum dolor sit amet,consectetur",
                        style: TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("assets/imgs/right arrow.png"),
                          size: 16,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                    }),
                    title: Text("FAQ"),
                    subtitle: Text("Lorm ipsum dolor sit amet,consectetur",
                        style: TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("assets/imgs/right arrow.png"),
                          size: 16,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5.0,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: (() {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                    }),
                    title: Text("Policies, Terms & Conditions"),
                    subtitle: Text("Lorm ipsum dolor sit amet,consectetur",
                        style: TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("assets/imgs/right arrow.png"),
                          size: 16,
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
