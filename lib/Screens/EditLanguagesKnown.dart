import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/Strings.dart';

class EditLangKnwn extends StatefulWidget {
  const EditLangKnwn({Key? key}) : super(key: key);

  @override
  State<EditLangKnwn> createState() => _EditLangKnwnState();
}

class _EditLangKnwnState extends State<EditLangKnwn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> Languages = [
    "English",
    "Hindi",
    "Tamil",
    "Urdu",
    "Malayalam",
    "Bengali",
    "Kannada",
    "Telugu",
    "Gujarati",
    "Nepali",
    "Punjabi"
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
            "Edit Languages Known",
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
            // child: GridView.builder(
            //     padding: EdgeInsets.fromLTRB(14, 100, 14, 0),
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 4,
            //         mainAxisSpacing: 20,
            //         mainAxisExtent: 120),
            //     itemCount: Languages.length,
            //     itemBuilder: (BuildContext ctx, index) {
            //       return Container(
            //         //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            //         child: InkWell(
            //           onTap: () {
            //             setState(() {
            //               _tick[index] = !_tick[index];
            //             });
            //           },
            //           child: Column(children: [
            //             Stack(children: [
            //               Opacity(
            //                 opacity: _tick[index] ? 0.2 : 1.0,
            //                 child: CircleAvatar(
            //                   backgroundImage:
            //                       AssetImage("assets/imgs/${images[index]}"),
            //                   radius: 33,
            //                 ),
            //               ),
            //               Container(
            //                 child: Visibility(
            //                   visible: _tick[index],
            //                   child: Positioned(
            //                     right: 3,
            //                     child: CircleAvatar(
            //                       backgroundImage:
            //                           AssetImage("assets/imgs/tick.png"),
            //                       radius: 8,
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             ]),
            //             SizedBox(
            //               height: 12,
            //             ),
            //             Text(activities[index],
            //                 style: TextStyle(
            //                     fontSize: 12, fontWeight: FontWeight.w500)),
            //           ]),
            //         ),
            //       );
            //     }),
            child: Padding(
              padding: EdgeInsets.fromLTRB(14, 100, 14, 0),
              child: Wrap(
                spacing: 18.0,
                //runSpacing: 6.0,
                direction: Axis.horizontal,
                children: List<Widget>.generate(Languages.length, (int index) {
                  return GestureDetector(
                    onTap: () {
                      _selectedvalues.add(Languages[index]);
                      print("Lang:$_selectedvalues");

                      setState(() {
                        _tick[index] = !_tick[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Chip(
                        label: Container(
                          width: 80,
                          child: Center(
                            child: Text(Languages[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: _tick[index]
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                        backgroundColor:
                            _tick[index] ? Colors.green : Colors.grey.shade200,

                        // onDeleted: () {
                        //   setState(() {
                        //     QuesData.removeAt(index);
                        //   });
                        // },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Strings.appThemecolor),
                onPressed: () {
                  for (int i = 0; i < 12; i++) {
                    if (_tick[i] == true) {
                      // print(activities[i]);
                      _selectedvalues.add(Languages[i]);
                      Navigator.pop(context);
                      print(_selectedvalues);
                      _selectedvalues[i] = Languages[i];
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
