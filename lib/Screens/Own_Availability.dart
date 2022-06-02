import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:geocoding/geocoding.dart';
import 'package:playgroup/Screens/EditAvailability_Time.dart';
import 'package:playgroup/Screens/G-Map.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import '../Utilities/Strings.dart';

class Own_Availability extends StatefulWidget {
  const Own_Availability({Key? key}) : super(key: key);

  @override
  State<Own_Availability> createState() => _Own_AvailabilityState();
}

class _Own_AvailabilityState extends State<Own_Availability>
    with TickerProviderStateMixin {
  //final _AddressController = TextEditingController();

  String? _currentAddress;
  String _address = 'Gandhipuram, Coimbatore';

  TabController? _tabController;
  bool activityConfirmed = false;
  List<String> childImgs = [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
  ];

  int tag = 1;
  List<int> tag1 = [];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // _getAddress() async {
  //   if (Strings.Latt != 0) {
  //     try {
  //       List<Placemark> p =
  //           await placemarkFromCoordinates(Strings.Latt, Strings.Long);

  //       Placemark place = p[0];
  //       setState(() {
  //         _currentAddress = "${place.name},${place.locality}";
  //         _address = _currentAddress!;
  //       });
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Availability"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
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
          SizedBox(
            height: 60,
            child: TabBar(
              tabs: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text('Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF272626))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text('Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9e9e9e))),
                )
              ],
              //unselectedLabelColor: const Color(0xffacb3bf),
              indicatorColor: Color.fromRGBO(62, 244, 216, 0.8),
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2.0,
              //indicatorPadding: EdgeInsets.all(10),
              isScrollable: false,
              controller: _tabController,
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: <Widget>[
            availabilityDetails(),
            Container(color: Colors.blue)
          ])),
        ]));
  }

  Widget availabilityDetails() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/imgs/child5.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Kingston Jackey")
                  ],
                ),
              ),
              Container(
                  child: Strings.activityConfirmed
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditAvailabilityTime(),
                                ));
                              },
                              icon: ImageIcon(
                                AssetImage('assets/imgs/edit.png'),
                                size: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage('assets/imgs/share .png'),
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                            )
                          ],
                        )
                      : Container())
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              //borderRadius: BorderRadius.circular(30),
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
            child: SizedBox(
              height: 120,
              child: ListTile(
                title: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: Text(
                      "Art-Work - Natural Painting",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    "Nature Painting also referred to as Landscape or scenery painting mostly shows reference of mountains, trees or other natural elements, in recent times.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        height: 1.4,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 150, 149, 149)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 16,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Gandhipuram, Tamilnadu',
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 150, 149, 149)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    child: Row(
                      children: [
                        Text(
                          "14 Jan 2021",
                          style: TextStyle(
                              color: Color.fromARGB(255, 150, 149, 149),
                              fontSize: 11),
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
                              color: Color.fromARGB(255, 150, 149, 149),
                              fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Strings.activityConfirmed
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: InkWell(
                            child: Text(
                              "Suggest time Slot",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.orange,
                                  decoration: TextDecoration.underline),
                            ),
                          ))
                      : Container()
                ]),
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MapsPage()));
                    // setState(() {
                    //   _getAddress();
                    // });
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Direction",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.directions,
                        color: Colors.blue,
                        size: 17,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Divider(
                  height: 1.5,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Other Participants",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 0,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                if (index < 5) {
                                  return Container(
                                    padding: EdgeInsets.all(3),
                                    width: 35,
                                    height: 35,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/imgs/${childImgs[index]}"),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    padding: EdgeInsets.all(3),
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                      onTap: () {
                                        AppUtils.showParticipant(context, 10);
                                      },
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
                                  );
                                }
                              })),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1.5,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Optional Benefits",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                ChipsChoice<int>.multiple(
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
          Spacer(),
          Strings.activityConfirmed
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
                      // ),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          AppUtils.showPopUp(context,
                              "Are you sure want to pause the event..");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Pause",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ImageIcon(
                              AssetImage('assets/imgs/pause_1.png'),
                              color: Colors.grey,
                              size: 16,
                            )
                          ],
                        ),
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(
                                width: 2, color: Colors.grey.withOpacity(0.2))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            AppUtils.showPopUp(context,
                                "Are you sure want to Delete the event..");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ImageIcon(
                                AssetImage('assets/imgs/delete_2.png'),
                                color: Colors.grey,
                                size: 16,
                              )
                            ],
                          ),
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  width: 2,
                                  color: Colors.grey.withOpacity(0.2))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                        ))
                  ],
                )
              : Strings.availConfirm
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    2.0, // Move to right 10  horizontally
                                    9.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  Strings.availConfirm = !Strings.availConfirm;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Remove",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 17,
                                  )
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 2.0, //extend the shadow
                                  offset: Offset(
                                    2.0, // Move to right 10  horizontally
                                    10.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  Strings.availConfirm = !Strings.availConfirm;
                                });
                              },
                              child: Text(
                                "Join",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Strings.appThemecolor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
