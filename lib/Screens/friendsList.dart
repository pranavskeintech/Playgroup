import 'package:flutter/material.dart';
import 'package:playgroup/Models/AcceptedFriendsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/OtherChildProfile.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class friendsList extends StatefulWidget {
  int? FID;
  friendsList({Key? key, this.FID}) : super(key: key);

  @override
  State<friendsList> createState() => _friendsListState();
}

class _friendsListState extends State<friendsList> {
  BuildContext? ctx;

  List<FriendsData>? FriendsDatum;

  List<FriendsData> _foundedUsers = [];

  bool _isLoading = true;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => getFriends());
  }

  getFriends() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAcceptedFriendReq(widget.FID!).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          FriendsDatum = response.data!;
          setState(() {
            _foundedUsers = FriendsDatum!;
          });
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  onSearch(String search) {
    print("Searching for $search");
    setState(() {
      _foundedUsers = FriendsDatum!
          .where((user) =>
              user.childName!.toLowerCase().contains(search.toLowerCase()))
          .toList();
      print(_foundedUsers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Strings.appThemecolor,
            title: Text("Friends"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp),
            ),
          ),
          // resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return friendsList(newContext);
          }),
        ));
  }

  friendsList(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              children: [
                SizedBox(height: 20),
                FriendsDatum!.length > 0
                    ? Container(
                        decoration: BoxDecoration(
                            color: Strings.textFeildBg,
                            border: Border.all(color: Strings.textFeildBg),
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        child: TextField(
                          onChanged: (searchString) {
                            onSearch(searchString);
                          },
                          enabled: true,
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          textAlign: TextAlign.justify,
                          style: TextStyle(height: 1),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Search",
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Strings.textFeildBg),
                                  borderRadius: BorderRadius.circular(6)),
                              filled: true,
                              fillColor: Strings.textFeildBg,
                              prefixIcon: Icon(Icons.search)),
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                FriendsDatum!.length > 0
                    ? Expanded(
                        child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _foundedUsers.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OtherChildProfile(
                                                    otherChildID:
                                                        _foundedUsers[index]
                                                            .childId,
                                                    chooseChildId:
                                                        Strings.ChoosedChild)));
                                  },
                                  leading: Transform.translate(
                                    offset: Offset(-16, 0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          _foundedUsers[index].profile != "null"
                                              ? NetworkImage(Strings.imageUrl +
                                                  (_foundedUsers[index]
                                                          .profile ??
                                                      ""))
                                              : AssetImage(
                                                      "assets/imgs/appicon.png")
                                                  as ImageProvider,
                                    ),
                                  ),
                                  title: Transform.translate(
                                    offset: Offset(-16, 0),
                                    child:
                                        Text(_foundedUsers[index].childName!),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.4),
                                height: 1,
                              ),
                            ],
                          );
                        },
                      ))
                    : SizedBox(
                        height: 5,
                      ),
              ],
            ),
          );
  }
}
