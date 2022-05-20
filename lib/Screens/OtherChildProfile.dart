import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/Strings.dart';

class OtherChildProfile extends StatefulWidget {
  const OtherChildProfile({Key? key}) : super(key: key);

  @override
  State<OtherChildProfile> createState() => _OtherChildProfileState();
}

class _OtherChildProfileState extends State<OtherChildProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> images = [
    "cricket.jpg",
    "cooking.jpg",
    "reading.jpg",
    "trekking.jpg",
    "singing.jpg",
    "art.jpg",
    "hockey.jpg"
  ];
  List<String> activities = [
    "Cricket",
    "Cooking",
    "Reading",
    "Trekking",
    "Singing",
    "Art",
    "Hockey"
  ];
  bool _limitImage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Transform(
          transform: Matrix4.translationValues(-10.0, 0, 0),
          child: Text(
            "Anne Besta ",
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/imgs/child6.jpg"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Anne Besta",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 12,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Gandhipuram, Coimbatore",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      width: 140,
                      child: Center(
                        child: Text(
                          "Add Friend",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ))
              ]),
              margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
              //padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              height: 250,
              //width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ]),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "School",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "ADB High School, Old Post Office, New Siddhapudhur, Coimbatore - 640023",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: Divider(
                height: 2,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Interests",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextButton(
                            onPressed: () {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          vertical: 150.0, horizontal: 45.0),
                                      content: Stack(children: [
                                        ListView.builder(
                                          itemCount: images.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "assets/imgs/${images[index]}"),
                                                ),
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 0, 0, 0),
                                                  child: Text(activities[index],
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ),

                                                //Icon(Icons.access_alarm)
                                              ),
                                            );
                                          },
                                        ),
                                        Positioned(
                                          right: 0.0,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 15,
                                  color: Colors.grey,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          if (index > 4) {
                            _limitImage = false;
                          }
                          return _limitImage
                              ? Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //     width: 1.3,
                                        //     color: Color.fromARGB(255, 251, 132, 138)),
                                      ),
                                      padding: EdgeInsets.all(2),
                                      width: 41.5,
                                      height: 41.5,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/imgs/${images[index]}",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(activities[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11.0))
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //     width: 1.3,
                                        //     color: Color.fromARGB(255, 251, 132, 138)),
                                      ),
                                      padding: EdgeInsets.all(2),
                                      width: 44,
                                      height: 44,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                        child: Text(
                                          "3+",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ), //Text
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11.0))
                                  ],
                                );
                        })),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 5),
              child: Divider(
                height: 2,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Friends",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 15,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            padding: EdgeInsets.fromLTRB(12, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //     width: 1.3,
                                    //     color: Color.fromARGB(255, 251, 132, 138)),
                                  ),
                                  //padding: EdgeInsets.all(2),
                                  width: 30,
                                  height: 30,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/imgs/child2.jpg",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Robert Doe",
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            padding: EdgeInsets.fromLTRB(12, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //     width: 1.3,
                                    //     color: Color.fromARGB(255, 251, 132, 138)),
                                  ),
                                  //padding: EdgeInsets.all(2),
                                  width: 30,
                                  height: 30,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/imgs/child4.jpg",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Alen Tom",
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            padding: EdgeInsets.fromLTRB(12, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //     width: 1.3,
                                    //     color: Color.fromARGB(255, 251, 132, 138)),
                                  ),
                                  //padding: EdgeInsets.all(2),
                                  width: 30,
                                  height: 30,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/imgs/child.jpg",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sandra Doe",
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            padding: EdgeInsets.fromLTRB(12, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //     width: 1.3,
                                    //     color: Color.fromARGB(255, 251, 132, 138)),
                                  ),
                                  //padding: EdgeInsets.all(2),
                                  width: 30,
                                  height: 30,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/imgs/child1.jpg",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Jhon Doe",
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: Divider(
                height: 2,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Availability",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 15,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.2)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Playing - Cricket",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "14 Jan 2021",
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 5),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "4-5 pm",
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Gandhipuram, Coimbatore",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.2)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Drawing Lesson",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "14 Jan 2021",
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 5),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "10-11 am",
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Gandhipuram, Coimbatore",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}