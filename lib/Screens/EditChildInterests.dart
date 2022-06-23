import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Models/GetInterestsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class EditChildInterests extends StatefulWidget {
  int? chooseChildId;
  EditChildInterests({
    Key? key,
    this.chooseChildId,
  }) : super(key: key);

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

  BuildContext? ctx;

  bool _isLoading = true;

  List<Data>? _InterestData;

  fetchInterest() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetInterests(widget.chooseChildId!).then((response) {
      print(response.status);
      if (response.status == true) {
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));

        setState(() {
          _InterestData = response.data;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        functions.createSnackBar(context, response.status.toString());
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchInterest());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return EditInt(newContext);
          }),
        ));
  }

  EditInt(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
              backgroundColor: Strings.appThemecolor,
              title: Transform(
                transform: Matrix4.translationValues(-10.0, 0, 0),
                child: Text(
                  "Edit Child Interests",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
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
                      itemCount: _InterestData!.length,
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
                                    backgroundImage: AssetImage(
                                        "assets/imgs/${images[index]}"),
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
                              Text(_InterestData![index].interestName!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ]),
                          ),
                        );
                      }),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            for (int i = 0; i < 12; i++) {
                              if (_tick[i] == true) {
                                print(activities[i]);
                                _selectedvalues.add(activities[i]);
                                Navigator.pop(context);
                                print(_selectedvalues);
                                // _selectedvalues[i] = activities[i];
                              } else {
                                // _selectedvalues[i] = "null";
                                continue;
                              }
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Strings.appThemecolor)),
                        )),
                  ),
                )
              ],
            ),
          );
  }
}
