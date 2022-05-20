import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playgroup/Screens/AddGroup.dart';
import 'package:playgroup/Screens/EditChildDetails.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class ChildProfile extends StatefulWidget {
  const ChildProfile({Key? key}) : super(key: key);

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile>
    with TickerProviderStateMixin {
  TabController? _tabController;
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

  List<String> Games = [
    "Playing-Cricket",
    "Drawing Lessions",
    "Art Natural Painting",
    "Maths Coaching",
    "Playing-Cricket",
    "Science Experiments"
  ];

  List<String> Places = [
    "Gandhipuram, Coimbatore",
    "Laximi Mills",
    "PN Palayam",
    "Gandhipuram, Coimbatore",
    "Railway Station",
    "Gandhipuram, Coimbatore",
  ];

  List<String> options = [
    'English',
    'Tamil',
    'Kannada',
  ];

  List<int> tag1 = [];
  // Initial Selected Value
  String dropdownvalue = 'ALL';

  // List of items in our dropdown menu
  var items = [
    'ALL',
    'GROUPS',
    'FRIENDS',
  ];

  bool value = false;

  var _AddGroup = false;

  bool _show = false;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Activity"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      bottomSheet: _showBottomSheet(),
      body: Tabbarwidgets(),
    );
  }

  Widget Tabbarwidgets() {
    return Container(
        // padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 1.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 60,
            child: TabBar(
              tabs: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text('Profile Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text('Friends',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text('Friend Request',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text('Activities',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                )
              ],
              unselectedLabelColor: const Color(0xffacb3bf),
              indicatorColor: Color.fromRGBO(62, 244, 216, 0.8),
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.all(10),
              isScrollable: true,
              controller: _tabController,
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: <Widget>[
            ProfileInfo(),
            Friends(),
            FriendRequest(),
            Activities(),
          ])),
        ]));
  }

  Widget ProfileInfo() {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditChildDetails()));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Edit"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit_outlined,
                                size: 15,
                              )
                            ],
                          ),
                        )),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                    radius: 45,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Anne Besta",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Gandhipuram, Coimbathore",
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "School",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "ADB Higher Secondary School",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1.5,
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DOB",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "04-06-2015",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Interests",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("Edit"),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit_outlined,
                            size: 15,
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
              height: 80,
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Column(
                        children: [
                          if (index < 5)
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(2),
                                  width: 45,
                                  height: 45,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/imgs/${images[index]}",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  activities[index],
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          else
                            Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                child: Text(
                                  "3+",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ), //Text
                              ),
                            ),
                        ],
                      ),
                    );
                  })),
            ),
            SizedBox(
              height: 0,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Languages Known",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("Edit"),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit_outlined,
                            size: 15,
                          )
                        ],
                      )),
                ],
              ),
            ),
            ChipsChoice<int>.multiple(
              spacing: 20,
              wrapped: true,
              verticalDirection: VerticalDirection.up,
              choiceStyle: C2ChoiceStyle(color: Colors.black),
              value: tag1,
              onChanged: (val) {},
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Friends() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 5, 10),
            child: Row(
              children: [
                Container(
                  width: width * 0.6,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          style: TextStyle(height: 1.5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          child: DropdownButton(
                            underline: SizedBox(),
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: width * 0.07,
                  width: width * 0.24,
                  child: _AddGroup
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _AddGroup = false;
                              _show = false;
                            });
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 11),
                          ))
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _AddGroup = true;
                            });
                          },
                          child: Text(
                            "Add Group+",
                            style: TextStyle(fontSize: 11),
                          )),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ChildProfile()));
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                    ),
                    trailing: _AddGroup
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
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
                                  value: this.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.value = value!;
                                      print("value:$value");
                                      if (value == true) {
                                        _show = true;
                                      }
                                    });
                                  }),
                            ),
                          )
                        : null,
                    title: Text("Christopher Janglen"),
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
        ],
      ),
    );
  }

  Widget? _showBottomSheet() {
    if (_show) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 5.0,
                  offset: new Offset(0.0, 2.0),
                ),
              ],
            ),
            height: 100,
            width: double.infinity,
            // color: Colors.white,
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  _show = false;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddGroup()));
                  setState(() {});
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NEXT",
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green,
                        size: 15,
                      )
                    ],
                  ),
                )),
          );
        },
      );
    } else {
      return null;
    }
  }

  Widget FriendRequest() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ChildProfile()));
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                  ),
                  title: Text(
                    "Christopher Janglen",
                  ),
                  trailing: Container(
                    width: width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: width * 0.06,
                          width: width * 0.20,
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => AddCoParent()));
                              },
                              child: Text("Accept",
                                  style: TextStyle(fontSize: 11))),
                        ),
                        Container(
                          height: width * 0.06,
                          width: width * 0.20,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => AddCoParent()));
                              },
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                              )),
                        ),
                        Icon(
                          Icons.more_vert,
                          size: 18,
                        )
                      ],
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
        ],
      ),
    );
  }

  Widget Activities() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            width: width * 0.9,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: false,
                    style: TextStyle(height: 1),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    child: DropdownButton(
                      underline: SizedBox(),
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            //                   <--- left side
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(1, 1), // Shadow position
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            Games[index],
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Container(
                            width: width * 0.28,
                            child: Row(
                              children: [
                                Text(
                                  "14 Jan 2021",
                                  style: TextStyle(fontSize: 11),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "4-5 Pm",
                                  style: TextStyle(fontSize: 11),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          isThreeLine: false,
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                Places[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  handleClick(String value) {
    switch (value) {
      case 'ALL':
        setState(() {});
        break;
      case 'GROUPS':
        setState(() {});
        break;
      case 'FRIENDS':
        setState(() {});
        break;
    }
  }
}
