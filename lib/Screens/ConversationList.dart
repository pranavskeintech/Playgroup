import 'package:flutter/material.dart';
import 'package:playgroup/Screens/GroupsChat.dart';
import 'package:playgroup/Screens/IndividualsChat.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';

class ConversationList extends StatefulWidget {
  int id;
  String name;
  String messageText;
  String imageUrl;
  String time;
  String type;
  bool isMessageRead;

  ConversationList(
      {required this.id,
      required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead,
      required this.type});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    print("200");
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  (widget.type == "Group-chats")
                      ? Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                maxRadius: 20,
                                backgroundImage: (widget.imageUrl != "null")
                                    ? NetworkImage(
                                        Strings.imageUrl + widget.imageUrl)
                                    : AssetImage("assets/imgs/profile-user.png")
                                        as ImageProvider,
                              ),
                            ),
                            Positioned(
                                right: 27,
                                bottom: 23,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/imgs/group.png"),
                                  radius: 8,
                                ))
                          ],
                        )
                      : CircleAvatar(
                          maxRadius: 20,
                                          backgroundColor: Colors.white,
                          backgroundImage: (widget.imageUrl != "null")
                              ? NetworkImage(Strings.imageUrl + widget.imageUrl)
                              : AssetImage("assets/imgs/profile-user.png")
                                  as ImageProvider,
                        ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        (widget.type != "Group-chats")
                            ? Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                return Individuals_Chat(
                                    otherChildId: widget.id,
                                    name: widget.name,
                                    profile: widget.imageUrl);
                              }))
                            : Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                return Groups_Chat(
                                    groupId: widget.id,
                                    name: widget.name,
                                    profile: widget.imageUrl);
                              }));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.messageText,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight: widget.isMessageRead
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              TimeAgo.calculateTimeDifferenceOfSeconds(widget.time),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
