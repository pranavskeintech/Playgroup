import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:social_share/social_share.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({ Key? key }) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> 
{
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
        margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Invite Friends",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Invite your Friends to the Playgroup App.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                 SocialShare.shareOptions("Hey I found an new app Named Playgroup, Install With my link https://play.google.com/store/apps/details?id=com.netflix.mediaclient").then((data) {
                        print(data);
                      });
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/imgs/add-user.png",
                  width: 15,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Invite Friends")
              ])),
              SizedBox(height: 10,),
              Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "No Availabilities",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
              SizedBox(height: 20,),
              Card(
                elevation: 8,
                shadowColor: Colors.grey.withOpacity(0.1),
                child: 
                Container(
                  height: 140,
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Column
                  (crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                    Text("There are no friend's availabilities please add friends and view their availabilities",style: TextStyle(color: Strings.textFeildHeading,fontSize: 15),),
                    SizedBox(height:10),
                                     Text("Add your friends and share with your availabilities",style: TextStyle(color: Strings.textFeildHeading)),
 
                  ]),
                ),
              )
          ],
        ),
      );
  }
}