import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:playgroup/Screens/EditAvailability_Time.dart';
import '../Utilities/Strings.dart';

class Own_Availability extends StatefulWidget {
  const Own_Availability({Key? key}) : super(key: key);

  @override
  State<Own_Availability> createState() => _Own_AvailabilityState();
}

class _Own_AvailabilityState extends State<Own_Availability>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool activityConfirmed = false;
  List<String> childImgs = 
  [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];
List<String> options = [
  'News', 'Entertainment', 'Politics',
  'Automotive', 'Sports', 'Education',
];

  int tag = 1;
  List<int> tag1 = [];
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
            availabilityDetails(),
            Container(color: Colors.blue)
          ])),
        ]));
  }

  Widget availabilityDetails() 
  {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 16,
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
                child: !activityConfirmed? Row(
                  children: [
                    IconButton(
                        onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAvailabilityTime(),));                        
                        },
                        icon: Icon(
                          Icons.edit_note_rounded,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          size: 20,
                        ))
                  ],
                ):InkWell(
                  child: Row(
                    children: const [
                      Text("Share"),
                      SizedBox(width: 5,),
                      Icon(Icons.share,size: 15,)
                    ],
                  ),
                )
              )
            ],
          ),
          Card(
            elevation: 3,
            child: SizedBox(
              height: 120,
              child: ListTile(
                title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                      "Art-Work - Natural Painting",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    )),
                subtitle: Text(
                  "Natural Painting also reffered to as Landscape or Scenery Painting Mostly shows reference of mountains,trees or other natural elements, in recent times.",
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10, 0, 10 ),
                  child: Row(
                    children: [
                      Text("14 Jan 2021"),
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
                        "4-5 Pm",
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                activityConfirmed?Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: InkWell(
                  child:
                  Text("Suggest time Slot",style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline),),
                )):Container()
              ]),
              Row(
                children: const [
                  Text(
                    "Direction",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Icon(
                    Icons.directions,
                    color: Colors.blue,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Other Participnts",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          if (index < 5) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              width: 40,
                              height: 40,
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
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                child: Text(
                                  "3+",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ), //Text
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
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Optional Benifits")),
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
          Spacer(),
          !activityConfirmed?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
                  // ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Pause",
                          style: TextStyle(color: Colors.black),
                        ),Icon(Icons.pause_circle,color: Colors.black,)
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Delete",
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.delete,color: Colors.black,)
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ))
            ],
          ):Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Remove",
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.close,color: Colors.black,)
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                  ),
          )
        ],
      ),
    );
  }
}
