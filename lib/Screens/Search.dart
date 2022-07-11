import 'package:flutter/material.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Screens/SearchResults.dart';
import 'package:playgroup/Screens/ShowOtherChild.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

import '../Models/SearchResultRes.dart';
import '../Network/ApiService.dart';
import '../Utilities/AppUtlis.dart';
import '../Utilities/Strings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var ctx;
  TextEditingController searchController = TextEditingController();
  List<SearchData> searchData = [];

  bool noMatchFound = false;
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return Search(newContext);
          }),
        ));
  }

  Search(BuildContext context) {
    ctx = context;
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
            height: 42,
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              // enabled: false,
              //style: TextStyle(height: 3),
              onChanged: (changedvar) {
                if (changedvar != "") {
                  searchResults(changedvar);
                } else {
                  setState(() {});
                }
              },
              onEditingComplete: () {
                Strings.searchText = searchController.text;
                //searchResults();
                //  Navigator.of(context).push(MaterialPageRoute(
                //                     builder: (BuildContext context) =>
                //                         SearchResults()));
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search",
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 0.0),
                      borderRadius: BorderRadius.circular(6)),
                  filled: true,
                  fillColor: Strings.textFeildBg,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          searchController.text != ""
              ? noMatchFound
                  ? Center(
                      child: Text("No Match Found"),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: searchData.length,
                        itemBuilder: (context, index) {
                          int startIndex = searchData[index]
                              .childName!
                              .toLowerCase()
                              .indexOf(searchController.text.toLowerCase());
                          return GestureDetector(
                            onTap: () {
                              Strings.FriendNotification = false;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OtherChildProfile(
                                          otherChildID:
                                              searchData[index].childId,
                                          fromSearch: true)));
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: searchData[index]
                                                .profile !=
                                            "null"
                                        ? NetworkImage(Strings.imageUrl +
                                            (searchData[index].profile ?? ""))
                                        : AssetImage(
                                                "assets/imgs/profile-user.png")
                                            as ImageProvider,
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(searchData[index].childName ?? "",style: TextStyle(fontSize: 14)),
                                        RichText(
                                            text: TextSpan(
                                          text: searchData[index]
                                              .childName!
                                              .substring(0, startIndex),
                                          style: TextStyle(color: Colors.grey),
                                          children: [
                                            TextSpan(
                                              text: searchData[index]
                                                  .childName!
                                                  .substring(
                                                      startIndex,
                                                      startIndex +
                                                          searchController
                                                              .text.length),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: searchData[index]
                                                  .childName!
                                                  .substring(startIndex +
                                                      searchController
                                                          .text.length),
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        )),
                                        SizedBox(height: 5),
                                        Row(
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
                                              searchData[index].location ?? "",
                                              overflow: TextOverflow.fade,
                                              maxLines: 3,
                                            )
                                          ],
                                        ),
                                      ])
                                ])),
                          );
                        },
                      ),
                    )
              : Container(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Invite Friends",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Invite your Friends to the Playgroup App.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 38)),
                          onPressed: () {
                            SocialShare.shareOptions(
                                    "Hey I found an new app Named Playgroup, Install With my link https://play.google.com/store/apps/details?id=com.netflix.mediaclient")
                                .then((data) {
                              print(data);
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/imgs/add-user.png",
                                  width: 15,
                                  height: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Invite Friends",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                )
                              ])),
                    )
                  ],
                )),
        ],
      ),
    );
  }

  searchResults(searchText) {
    var PId = Strings.Parent_Id.toInt();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.SearchChild(searchText, Strings.SelectedChild).then((response) {
      print(response.status);
      if (response.status == true) {
        noMatchFound = false;
        searchData = response.data!;
        setState(() {
          AppUtils.dismissprogress();
        });
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));

      } else {
        setState(() {
          noMatchFound = true;
        });
        //AppUtils.createSnackBar(context, response.message ?? "Unable to Search Details");
        // _btnController.stop();
      }
    }).catchError((onError) {
      AppUtils.dismissprogress();
      print(onError.toString());
    });
  }
}
