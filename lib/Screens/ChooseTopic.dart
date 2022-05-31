import 'package:flutter/material.dart';
import 'package:playgroup/Models/GetActivitiesRes.dart';
import 'package:playgroup/Models/Get_CityRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Availability-Choose_category.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

import 'Availability-Choose_friends.dart';

class ChooseTopic extends StatefulWidget {
  const ChooseTopic({Key? key}) : super(key: key);

  @override
  State<ChooseTopic> createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  int? selectedActivities;
  int? selectedOtherActivities;
  BuildContext? ctx;

  bool _isLoading = true;

  List<GetSportsMessage>? Activities;

  List<GetSportsMessage>? TopCount = [];

  List<GetSportsMessage>? BottomCount = [];

  _GetActivities() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetActivities().then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          Activities = response.data!;
          _isLoading = false;
          print("Activities:${Activities![0].activitiesName!}");
          print("Activities:${Activities![0].position!}");
          for (int i = 0; i < Activities!.length; i++) {
            if (Activities![i].position == "top") {
              TopCount!.add(Activities![i]);
            } else {
              BottomCount!.add(Activities![i]);
              print('bottom');
            }
          }
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetActivities());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return ChooseTopic(newContext);
          }),
        ));
  }

  ChooseTopic(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            appBar: AppBar(
              title: Text("Your Availability"),
              backgroundColor: Strings.appThemecolor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_sharp),
                tooltip: 'back',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Top Activities",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: GridView.builder(
                        itemCount: TopCount!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOtherActivities = null;
                                  selectedActivities = index;
                                  //Strings.Activities = selectedActivities;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 2.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            0.5, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/imgs/book.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(TopCount![index].activitiesName!)
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (selectedActivities == index)
                                    Positioned(
                                        right: 3,
                                        top: 3,
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                              "assets/imgs/check.png"),
                                        ))
                                ],
                              ));
                        },
                      )),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Other Activities",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: GridView.builder(
                        itemCount: BottomCount!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOtherActivities = index;
                                  selectedActivities = null;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 2.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            0.5, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/imgs/book.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(BottomCount![index]
                                              .activitiesName!)
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (selectedOtherActivities == index)
                                    Positioned(
                                        right: 3,
                                        top: 3,
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                              "assets/imgs/check.png"),
                                        ))
                                ],
                              ));
                        },
                      )),
                ),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedActivities != null ||
                              selectedOtherActivities != null) {
                            (selectedActivities == null)
                                ? Strings.markAvailabiltyTopic =
                                    selectedOtherActivities!
                                : Strings.markAvailabiltyTopic =
                                    selectedActivities!;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Choose_Category()));
                          } else {
                            AppUtils.showWarning(
                                context, "Please select anyone activity", "");
                          }
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Strings.appThemecolor)),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
                      // ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 18),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
  }
}
