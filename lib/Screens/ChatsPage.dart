import 'package:flutter/material.dart';
import 'package:playgroup/Models/GetChatsList.dart';
import 'package:playgroup/Screens/ConversationList.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class Chat_List extends StatefulWidget {
  const Chat_List({Key? key}) : super(key: key);

  @override
  State<Chat_List> createState() => _Chat_ListState();
}

class _Chat_ListState extends State<Chat_List> {
  // List<ChatUsers> chatUsers = [
  //   ChatUsers(
  //     name: "Jane Russel",
  //     messageText: "Awesome Setup",
  //     imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
  //     time: "Now",
  //   ),
  //   ChatUsers(
  //     name: "Glady's Murphy",
  //     messageText: "That's Great",
  //     imageURL: "https://randomuser.me/api/portraits/men/1.jpg",
  //     time: "Yesterday",
  //   ),
  // ];

  BuildContext? ctx;

  bool _isLoading = true;

  List<Data>? GetChatData = [];

  GetChatDatum() {
    //AppUtils.showprogress();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetChatList(Strings.SelectedChild).then((response) {
      print("sts1:${response.status}");
      print("res1:${response.data}");
      if (response.status == true) {
        setState(() {
          // AppUtils.dismissprogress();
          GetChatData = response.data;
          // setState(() {
          //   _foundedActivity = GetMarkAvailabilityData!;
          // });

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  // onSearch3(String search) {
  //   print("Searching for $search");
  //   setState(() {
  //     widget.fromOwnAvail!
  //         ? _foundedActivity = GetMarkAvailabilityData!
  //             .where((user) => user.categoryName!
  //                 .toLowerCase()
  //                 .contains(search.toLowerCase()))
  //             .toList()
  //         : _foundedActivity = AllActivity!
  //             .where((user) => user.categoryName!
  //                 .toLowerCase()
  //                 .contains(search.toLowerCase()))
  //             .toList();
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    print("100");
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => GetChatDatum());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Strings.appThemecolor,
          //   title: Text("Your Availability"),
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.arrow_back_sharp),
          //   ),
          // ),
          // resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return MarkAvail(newContext);
          }),
        ));
  }

  MarkAvail(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            // backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Mesaages',
                  // textScaleFactor: 1.12,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  print("open");
                  // _key.currentState?.openDrawer();
                },
                icon: ImageIcon(
                  AssetImage("assets/imgs/menu_ver2.png"),
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              actions: [
                IconButton(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                  tooltip: 'Search',
                  enableFeedback: true,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(.5),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: (GetChatData!.length > 0)
                    ? Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: GetChatData!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 16),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          // top: (index == 0)
                                          //     ? BorderSide(
                                          //         color: Theme.of(context).dividerColor)
                                          //     : BorderSide.none,
                                          bottom: BorderSide(
                                              color: Theme.of(context)
                                                  .dividerColor,
                                              width: 1))),
                                  child: ConversationList(
                                    id: GetChatData![index].id!,
                                    name: (GetChatData![index].type ==
                                            "Group-chats")
                                        ? GetChatData![index].groupName!
                                        : GetChatData![index].childName!,
                                    messageText: GetChatData![index].message!,
                                    imageUrl: (GetChatData![index].type ==
                                            "Group-chats")
                                        ? GetChatData![index].groupImage!
                                        : GetChatData![index].profile!,
                                    time: GetChatData![index].createdDate!,
                                    type: GetChatData![index].type!,
                                    isMessageRead: (index == 0 || index == 3)
                                        ? true
                                        : false,
                                  )),
                            );
                          },
                        ))
                    : SizedBox()));
  }
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
  });
}
