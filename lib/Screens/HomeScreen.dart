import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:playgroup/Screens/Own_Availability.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  List<String> childImgs = [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Your Play dates",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.3,
                              color: Color.fromARGB(255, 251, 132, 138)),
                        ),
                        padding: EdgeInsets.all(2),
                        width: 50,
                        height: 50,
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
                              fontWeight: FontWeight.w300, fontSize: 11.0))
                    ],
                  );
                })),
          ),
          Divider(
            height: 4,
            color: Colors.grey.shade400,
          ),
          SizedBox(
            height: 13,
          ),
          Expanded(
            child: Container(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Own_Availability()));
                              }),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                height: 220,
                                color: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 8.0, // soften the shadow
                                        spreadRadius: 5.0, //extend the shadow
                                        offset: Offset(
                                          2.0, // Move to right 10  horizontally
                                          2.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.fromLTRB(13, 2, 12, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        isThreeLine: false,
                                        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        contentPadding: EdgeInsets.all(0),
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/imgs/child.jpg"),
                                        ),
                                        title: Text(
                                          "Kingston Jackey",
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "14 Jan 2021",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Colors.red,
                                                  size: 12.5,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "Gandhipuram busstand",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  overflow: TextOverflow.fade,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "Art Work - Natural Painting",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Other Participants",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: 5,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    if (index < 4) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        width: 32,
                                                        height: 32,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/imgs/${childImgs[index]}"),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        height: 32,
                                                        width: 32,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                          child: Text(
                                                            "3+",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12),
                                                          ), //Text
                                                        ),
                                                      );
                                                    }
                                                  })),
                                            ),
                                            SizedBox(
                                              height: 32,
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "JOIN",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(
                                                          94, 37, 108, 1),
                                                      // fontWeight:
                                                      //     FontWeight.w400
                                                    ),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white,
                                                    side: BorderSide(
                                                      width: 1.6,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
