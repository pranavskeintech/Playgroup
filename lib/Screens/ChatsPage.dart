import 'package:flutter/material.dart';
import 'package:playgroup/Screens/ConversationList.dart';

class Chat_List extends StatefulWidget {
  const Chat_List({Key? key}) : super(key: key);

  @override
  State<Chat_List> createState() => _Chat_ListState();
}

class _Chat_ListState extends State<Chat_List> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      name: "Jane Russel",
      messageText: "Awesome Setup",
      imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
      time: "Now",
    ),
    ChatUsers(
      name: "Glady's Murphy",
      messageText: "That's Great",
      imageURL: "https://randomuser.me/api/portraits/men/1.jpg",
      time: "Yesterday",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black),
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
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: chatUsers.length,
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
                              color: Theme.of(context).dividerColor,
                              width: 1))),
                  child: ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
