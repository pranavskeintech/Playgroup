import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/Strings.dart';

class EditChildInterests extends StatefulWidget {
  const EditChildInterests({Key? key}) : super(key: key);

  @override
  State<EditChildInterests> createState() => _EditChildInterestsState();
}

class _EditChildInterestsState extends State<EditChildInterests> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> images = [
    "music.jpg",
    "dance.jpg",
    "science.jpg",
    "cricket.jpg",
    "hockey.jpg",
    "cooking.jpg",
    "reading.jpg",
    "art.jpg",
    "outdoor.jpg",
    "trekking.jpg",
    "singing.jpg",
    "pottery.jpg"
  ];
  List<String> activities = [
    "Music",
    "Dance",
    "Science",
    "Cricket",
    "Hockey",
    "Cooking",
    "Reading",
    "Art",
    "Outdoor games",
    "Trekking",
    "Singing",
    "Pottery"
  ];
  List<bool> _tick = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> _selectedvalues = [];
  bool _limitImage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Transform(
          transform: Matrix4.translationValues(-10.0, 0, 0),
          child: Text(
            "Edit Child Interests",
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
          ),
        ),
        leading: Transform(
          transform: Matrix4.translationValues(8.0, 0, 0),
          child: IconButton(
              onPressed: () {
                // _scaffoldKey.currentState?.openDrawer();
                Navigator.pop(context);
              },
              icon: Icon(
                // AssetImage("assets/imgs/menu_ver2.png"),
                Icons.arrow_back,
                size: 32,
                color: Colors.white,
              )),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.fromLTRB(14, 100, 14, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 120),
                itemCount: images.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _tick[index] = !_tick[index];
                        });
                      },
                      child: Column(children: [
                        Stack(children: [
                          Opacity(
                            opacity: _tick[index] ? 0.2 : 1.0,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/imgs/${images[index]}"),
                              radius: 33,
                            ),
                          ),
                          Container(
                            child: Visibility(
                              visible: _tick[index],
                              child: Positioned(
                                right: 3,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/imgs/tick.png"),
                                  radius: 8,
                                ),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 12,
                        ),
                        Text(activities[index],
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                      ]),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Strings.appThemecolor),
                onPressed: () {
                  for (int i = 0; i < 12; i++) {
                    if (_tick[i] == true) {
                      print(activities[i]);
                      _selectedvalues.add(activities[i]);
                      print(_selectedvalues);
                      // _selectedvalues[i] = activities[i];
                    } else {
                      // _selectedvalues[i] = "null";
                      continue;
                    }
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 90),
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
