import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

import '../Models/SearchResultRes.dart';
import '../Network/ApiService.dart';
import '../Utilities/AppUtlis.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
  List<SearchData> searchData = [];
  List<DetailsObject> childNames = [];

  var ctx;
  
  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    childNames.add(DetailsObject(parentName: "Sathis Kumar", firstChild: "Ram Kumar", secondChild: "Vishnu"));
    // TODO: implement initState
        WidgetsBinding.instance!.addPostFrameCallback((_) => searchResults());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
       create: (context) => ApiService.create(),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            // systemOverlayStyle:
            //     SystemUiOverlayStyle(statusBarColor: Colors.white),
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
          body: Builder(builder: (BuildContext newContext) {
              return tabbarwidget(newContext);
            }),
              ),
    );
  }

  Widget tabbarwidget(BuildContext context) 
  {
    ctx = context;
    return Container(
                  child: Row(
                    children: [
                      
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: searchData[index].profile != "null" ? NetworkImage(Strings.imageUrl+(searchData[index].profile ?? "")):AssetImage("assets/imgs/appicon.png") as ImageProvider,
                                ),
                                title: Text(searchData[index].childName ?? "",style: TextStyle(fontSize: 14)),
                                subtitle: Row(
                                  children: const [
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
                                 SizedBox(
                                   width: 150,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: const [
                                    //  Icon(
                                       
                                    //    Icons.phone,color: Colors.blue,
                                    //    size: 20,),
                                    //    SizedBox(width: 5,),
                                     //Text("+91887645676",style: TextStyle(fontSize: 13),maxLines: 2,)
                                   ],
                                   ),
                                 ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
  }
  searchResults() {
    var PId = Strings.Parent_Id.toInt();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.SearchChild(Strings.searchText).then((response) {
      print(response.status);
      if (response.status == true) {
        searchData = response.data!;
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
       
      }
       else 
       {
         AppUtils.createSnackBar(context, response.message ?? "Unable to Search Details");
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
class DetailsObject {
  final String parentName;
  final String firstChild;
  final String secondChild;

  DetailsObject({required this.parentName , required this.firstChild, required this.secondChild});
}