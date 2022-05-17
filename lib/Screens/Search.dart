import 'package:flutter/material.dart';
import 'package:playgroup/Screens/SearchResults.dart';
import 'package:social_share/social_share.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
            height: 42,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SearchResults()));
              },
              child: TextField(
                // enabled: false,
                style: TextStyle(height: 3),
                decoration: InputDecoration(
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 0.0),
                        borderRadius: BorderRadius.circular(6)),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "Invite Friends",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ]),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Invite your Friends to the Playgroup App.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size(300, 38)),
                onPressed: () {
                  SocialShare.shareOptions(
                          "Hey I found an new app Named Playgroup, Install With my link https://play.google.com/store/apps/details?id=com.netflix.mediaclient")
                      .then((data) {
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
                  Text(
                    "Invite Friends",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )
                ])),
          )
        ],
      ),
    );
  }
}
