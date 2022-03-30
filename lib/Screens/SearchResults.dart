import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> childImgs = [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];

  List<String> parentNames = [
    "Sathish Kumar",
    "Ram Krishnamoorthy",
    "Manohar",
    "Sabarish",
    "Soumaya harish",
    "Sangeetha Arun"
  ];

  List<DetailsObject> childNames = [];
  
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    childNames.add(DetailsObject(parentName: "Sathis Kumar", firstChild: "Ram Kumar", secondChild: "Vishnu"));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset(
                "assets/imgs/appicon.png",
                width: 32,
                height: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "PlayGroup",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/imgs/child5.jpg"),
            ),
            SizedBox(
              width: 3,
            ),
            IconButton(
                onPressed: () {},
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
        body: tabbarwidget());
  }

  Widget tabbarwidget() 
  {
    return Container(

        // padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 1.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 60,
              child: TabBar(
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text('Friends',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF272626))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text('Parents',
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
                // newsFeeds(),
                // highlights()
                Container(
                  child: ListView.builder(
                    itemCount: parentNames.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/imgs/${childImgs[index]}"),
                          ),
                          title: Text(parentNames[index],style: TextStyle(fontSize: 14)),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Gandhipuram",
                                overflow: TextOverflow.fade,
                              )
                            ],
                          ),
                           trailing: //Icon(Icons.access_alarm)
                           Container(
                             width: 150,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                               Icon(
                                 
                                 Icons.phone,color: Colors.blue,
                                 size: 20,),
                                 SizedBox(width: 5,),
                               Text("+91887645676",style: TextStyle(fontSize: 13),maxLines: 2,)
                             ],
                             ),
                           ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: parentNames.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(8, 10, 0, 10),
                              child: Text(parentNames[index],style: TextStyle(fontWeight: FontWeight.bold),)),
                            for(int i = 0; i<2; i++)
                            ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/imgs/${childImgs[index]}"),
                          ),
                          title: Text("Harish Chandrakumar",style: TextStyle(fontSize: 14),),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Gandhipuram",
                                overflow: TextOverflow.fade,
                              )
                            ],
                          ),
                           trailing: //Icon(Icons.access_alarm)
                           Container(
                             width: 150,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                               Icon(  
                                 Icons.phone,color: Colors.blue,
                                 size: 20,),
                                 SizedBox(width: 5,),
                               Text("+91887645676",style: TextStyle(fontSize: 13),maxLines: 2,)
                             ],
                             ),
                           ),
                        ),
                          ],
                        )
                      );
                    },
                  ),
                ),
                
              ]),
            )
          ],
        ));
  }
}
class DetailsObject {
  final String parentName;
  final String firstChild;
  final String secondChild;

  DetailsObject({required this.parentName , required this.firstChild, required this.secondChild});
}