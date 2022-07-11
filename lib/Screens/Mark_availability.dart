import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Models/ChooseChildReq.dart';
import 'package:playgroup/Models/GetProfileRes.dart';
import 'package:playgroup/Models/MarkAvailabilityReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/ChatsPage.dart';
import 'package:playgroup/Screens/ChooseTopic.dart';
import 'package:playgroup/Screens/G-Map.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/NavigationDrawer.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../Utilities/AppUtlis.dart';
import 'ChooseTopic.dart';

class Mark_Availabilty extends StatefulWidget {
  const Mark_Availabilty({Key? key}) : super(key: key);

  @override
  State<Mark_Availabilty> createState() => _Mark_AvailabiltyState();
}

class _Mark_AvailabiltyState extends State<Mark_Availabilty> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dobController = TextEditingController();
  final _FromTimeController = TextEditingController();
  final _TOTimeController = TextEditingController();
  final _DescriptionController = TextEditingController();
  final _AddressController = TextEditingController();
  List<IconData> iconList = [];
  var _bottomNavIndex = 0;
  String? selectedStartTime;
  String? selectedEndTime;
  List<String> items = [
    '1 pm',
    '2 pm',
    '3 pm',
    '4 pm',
    '5 pm',
    '6 pm',
    '7 pm',
    '8 pm',
  ];

  String? _currentAddress;

  bool todaySelected = false;
  bool TommorowSelected = false;

  TimeOfDay? ltime;

  var _currentSelectedValue;

  var _site = 'Open to anything';

  var _isChecked = false;

  BuildContext? ctx;

  String? _OpenLocation;

  bool _isLoading1 = true;
  bool _isLoading2 = true;

  Children? ListViewData;

  Children? HeaderData;
  Profile? _ProfileData;
  int? _SelectedChildId;
  int? index1;

  var checkFrom = false;

  TimeOfDay? ChoosenTime1;

  DateTime? picked;

  String? date1;

  String? date3;

  String? date2;

  _selectFromTime(context) async {
    ChoosenTime1 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      // cancelText: "NOT NOW",
      helpText: "SELECT TIME",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (ChoosenTime1 != null) {
      setState(() {
        checkFrom = true;

        if (ChoosenTime1!.format(context) == _TOTimeController.text) {
          AppUtils.showWarning(
              context, "The from and to time should not be same", "");
          _FromTimeController.text = "";
        } else {
          var currDate = DateTime.now();
          var currDateTime =
              "${currDate.day}-${currDate.month}-${currDate.year}";
          if (picked != null) {
            final now1 = picked;

            var startShift = DateTime(now1!.year, now1.month, now1.day,
                ChoosenTime1!.hour, ChoosenTime1!.minute);
            final endShift =
                DateTime(now.year, now.month, now.day, now.hour, now.minute);
            if (date1 == currDateTime) {
              if (startShift.isAfter(endShift)) {
                _FromTimeController.text = ChoosenTime1!.format(context);
              } else {
                AppUtils.showWarning(context,
                    "Time should not be below current date and time", "");
                _FromTimeController.text = "";
              }
            } else {
              _FromTimeController.text = ChoosenTime1!.format(context);
            }
          } else if (todaySelected) {
            final now1 = now;
            var startShift = DateTime(now1.year, now1.month, now1.day,
                ChoosenTime1!.hour, ChoosenTime1!.minute);
            final endShift =
                DateTime(now.year, now.month, now.day, now.hour, now.minute);
            if (date2 == currDateTime) {
              if (startShift.isAfter(endShift)) {
                _FromTimeController.text = ChoosenTime1!.format(context);
              } else {
                AppUtils.showWarning(context,
                    "Time should not be below current date and time", "");
                _FromTimeController.text = "";
              }
            }
          } else if (TommorowSelected) {
            _FromTimeController.text = ChoosenTime1!.format(context);
          }
          // else {
          //   _FromTimeController.text = ChoosenTime1!.format(context);
          // }
        }
      });
    }
  }

  _selectTOTime() async {
    final ChoosenTime2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      // cancelText: "NOT NOW",
      helpText: "SELECT TIME",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (ChoosenTime2 != null) {
      var time = todaySelected
          ? now
          : TommorowSelected
              ? tom
              : picked != null
                  ? picked
                  : null;
      var startShift = DateTime(time!.year, time.month, time.day,
          ChoosenTime2.hour, ChoosenTime2.minute);
      var t2 = ChoosenTime1;
      final endShift =
          DateTime(time.year, time.month, time.day, t2!.hour, t2.minute);
      print("t3:$startShift");
      print("t4:$endShift");
      if (startShift.isAfter(endShift)) {
        _TOTimeController.text = ChoosenTime2.format(context);
      } else {
        AppUtils.showWarning(
            context, "Time should not be below current date and time", "");
        _TOTimeController.text = "";
      }
    }
  }

  _selectDate() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (picked != null) {
      setState(() {
        date1 = "${picked!.day}-${picked!.month}-${picked!.year}";
        _dobController.text = date1!;
        print("date selected");
        todaySelected = false;
        TommorowSelected = false;
      });
    }
  }

  // GetProfile() {
  //   _isLoading2 = true;
  //   final api = Provider.of<ApiService>(ctx!, listen: false);
  //   api.GetProfile().then((response) {
  //     if (response.status == true) {
  //       // AppUtils.dismissprogress();
  //       setState(() {
  //         _ProfileData = response.profile;
  //         _SelectedChildId = _ProfileData!.selectedChildId;
  //         for (var i = 0; i < _ProfileData!.children!.length; i++) {
  //           if (_ProfileData!.children![i].childId == _SelectedChildId) {
  //             index1 = i;
  //             print("Assigned data to header");
  //             HeaderData = _ProfileData!.children![index1!];
  //           }
  //         }
  //         Strings.ProfilePic = HeaderData!.profile;
  //         ListViewData = _ProfileData!.children!.removeAt(index1!);
  //         _isLoading2 = false;
  //         _isLoading1 = false;
  //         // _showDialog(ctx);
  //       });
  //     } else {
  //       _isLoading1 = false;
  //       _isLoading2 = false;
  //       functions.createSnackBar(ctx, response.status.toString());
  //       // _btnController.stop();
  //     }
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    iconList.add(Icons.home_outlined);
    iconList.add(Icons.schedule);
    iconList.add(Icons.search);
    iconList.add(Icons.notifications_outlined);
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) => GetProfile());
  }

  final now = DateTime.now();
  final tom = DateTime.now().add(Duration(days: 1));

  _getAddress() async {
    if (Strings.Latt != 0) {
      try {
        List<Placemark> p =
            await placemarkFromCoordinates(Strings.Latt, Strings.Long);

        Placemark place = p[0];
        setState(() {
          _currentAddress =
              "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
          _AddressController.text = _currentAddress!;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  var _Data = ["Open to anything", "Current Location"];

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return MarkAvailability(newContext);
          }),
        ));
  }

  MarkAvailability(BuildContext context) {
    ctx = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      // appBar: AppBar(
      //   // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      //   backgroundColor: Colors.white,
      //   title: Transform(
      //     transform: Matrix4.translationValues(-15.0, 0, 0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Image.asset(
      //           "assets/imgs/profile-user.png",
      //           width: 28,
      //           height: 28,
      //         ),
      //         const SizedBox(
      //           width: 10,
      //         ),
      //         const Text(
      //           "Play Group",
      //           style: TextStyle(
      //               fontSize: 17,
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold),
      //         ),
      //       ],
      //     ),
      //   ),
      //   actions: [
      //     InkWell(
      //       onTap: () async {
      //         // Navigator.of(context).push(MaterialPageRoute(
      //         // builder: (BuildContext context) => ProfileScreen()))
      //         await showChildDialog();
      //         setState(() {
      //           GetProfile();
      //         });
      //       },
      //       child: CircleAvatar(
      //         backgroundImage: (HeaderData!.profile != "null")
      //             ? NetworkImage(
      //                 Strings.imageUrl + (HeaderData!.profile!),
      //               )
      //             : AssetImage("assets/imgs/profile-user.png")
      //                 as ImageProvider,
      //         radius: 16,
      //       ),
      //     ),
      //     SizedBox(
      //       width: 3,
      //     ),
      //     IconButton(
      //         onPressed: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (BuildContext context) => Chat_List()));
      //         },
      //         icon: Image.asset(
      //           "assets/imgs/chat.png",
      //           width: 25,
      //           height: 25,
      //         ))
      //   ],
      //   leading: IconButton(
      //       onPressed: () {
      //         _scaffoldKey.currentState?.openDrawer();
      //       },
      //       icon: ImageIcon(
      //         AssetImage("assets/imgs/menu_ver2.png"),
      //         color: Colors.black,
      //       )),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //     // Navigator.of(context).push(MaterialPageRoute(
      //     //         builder: (BuildContext context) => Choose_Category()));
      //   },
      //   backgroundColor: Strings.appThemecolor,
      //   child: Icon(Icons.close_rounded),

      //   //params
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //     height: 60,
      //     icons: iconList,
      //     activeIndex: _bottomNavIndex,
      //     gapLocation: GapLocation.center,
      //     notchSmoothness: NotchSmoothness.defaultEdge,
      //     leftCornerRadius: 0,
      //     rightCornerRadius: 0,
      //     backgroundColor: Strings.appThemecolor,
      //     activeColor: Colors.white,
      //     inactiveColor: Colors.grey,
      //     onTap: (index) {
      //       setState(() {
      //         _bottomNavIndex = index;
      //       });
      //       print(index);
      //     }
      //     //other params
      //     ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          margin: EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mark Your Availability",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        date2 = "${now.day}-${now.month}-${now.year}";
                        _dobController.text = date2!;
                        print("date selected");
                        todaySelected = true;
                        TommorowSelected = false;
                        // _dobController.text = "";
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 68,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                                color: todaySelected
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.white,
                                spreadRadius: 3)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: const [
                              Color.fromARGB(255, 251, 182, 149),
                              Color.fromARGB(255, 245, 106, 133),
                            ],
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 13),
                              child: Text(
                                "Today",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                          SizedBox(
                            height: 13,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 14),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  now.day.toString() +
                                      "-" +
                                      now.month.toString() +
                                      "-" +
                                      now.year.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        date3 = "${tom.day}-${tom.month}-${tom.year}";
                        _dobController.text = date3!;
                        print("date selected");
                        todaySelected = false;
                        TommorowSelected = true;
                        // _dobController.text = "";
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 68,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                                color: TommorowSelected
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.white,
                                spreadRadius: 3)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: const [
                              Color.fromARGB(255, 146, 202, 247),
                              Color.fromARGB(255, 137, 123, 247),
                            ],
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 13),
                              child: Text(
                                "Tomorrow",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                          SizedBox(
                            height: 13,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 14),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  (tom.day).toString() +
                                      "-" +
                                      tom.month.toString() +
                                      "-" +
                                      tom.year.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              // Text(
              //   "DOB",
              //   style: TextStyle(
              //       fontSize: 15,
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _selectDate();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.045,
                  child: TextField(
                    controller: _dobController,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(3),
                      // ),
                      // focusedBorder: const OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       color: Color.fromRGBO(230, 230, 230, 1),
                      //       width: 0.0),
                      // ),
                      // enabledBorder: const OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       color: Color.fromRGBO(230, 230, 230, 1),
                      //       width: 0.0),
                      // ),
                      fillColor: Strings.textFeildBg,
                      filled: true,
                      contentPadding: EdgeInsets.all(15),
                      hintText: "Pick a Date",
                      hintStyle: TextStyle(fontSize: 13.5),
                      suffixIcon: Icon(Icons.calendar_today_outlined,
                          size: 18, color: Colors.grey.withOpacity(0.3)),
                      //contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Timing",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "From",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "To",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    // child: DropdownButtonHideUnderline(
                    //   child: DropdownButton2(
                    //     isExpanded: true,
                    //     hint: Row(
                    //       children: const [
                    //         Expanded(
                    //           child: Text(
                    //             'Select time',
                    //             style: TextStyle(
                    //                 fontSize: 15,
                    //                 //fontWeight: FontWeight.w300,
                    //                 color: Colors.grey),
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     items: items
                    //         .map((item) => DropdownMenuItem<String>(
                    //               value: item,
                    //               child: Text(
                    //                 item,
                    //                 style: const TextStyle(
                    //                   fontSize: 13,
                    //                   //fontWeight: FontWeight.bold,
                    //                   color: Colors.black,
                    //                 ),
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //             ))
                    //         .toList(),
                    //     value: selectedStartTime,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedStartTime = value as String;
                    //       });
                    //     },
                    //     icon: const Icon(
                    //       Icons.keyboard_arrow_down_rounded,
                    //     ),
                    //     iconSize: 16,
                    //     iconEnabledColor: Colors.grey,
                    //     iconDisabledColor: Colors.grey,
                    //     buttonHeight: 42,
                    //     buttonWidth: MediaQuery.of(context).size.width * 0.9,
                    //     buttonPadding:
                    //         const EdgeInsets.only(left: 14, right: 14),
                    //     buttonDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       color: Strings.textFeildBg,
                    //     ),
                    //     buttonElevation: 0,
                    //     itemHeight: 40,
                    //     itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    //     dropdownMaxHeight: 200,
                    //     dropdownWidth: 300,
                    //     dropdownPadding: null,
                    //     dropdownDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(3),
                    //       color: Colors.white,
                    //     ),
                    //     dropdownElevation: 1,
                    //     scrollbarRadius: const Radius.circular(20),
                    //     scrollbarThickness: 6,
                    //     scrollbarAlwaysShow: true,
                    //     offset: const Offset(0, 0),
                    //   ),
                    // ),

                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: GestureDetector(
                        onTap: () {
                          _selectFromTime(context);
                        },
                        child: TextField(
                          controller: _FromTimeController,
                          enabled: false,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Strings.textFeildBg,
                            filled: true,
                            contentPadding: EdgeInsets.all(15),
                            hintText: "Select Time",
                            hintStyle: TextStyle(fontSize: 13.5),
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey.withOpacity(0.3)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    // child: DropdownButtonHideUnderline(
                    //   child: DropdownButton2(
                    //     isExpanded: true,
                    //     hint: Row(
                    //       children: const [
                    //         Expanded(
                    //           child: Text(
                    //             'Select time',
                    //             style:
                    //                 TextStyle(fontSize: 15, color: Colors.grey),
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     items: items
                    //         .map((item) => DropdownMenuItem<String>(
                    //               value: item,
                    //               child: Text(
                    //                 item,
                    //                 style: const TextStyle(
                    //                   fontSize: 13,
                    //                   //fontWeight: FontWeight.bold,
                    //                   color: Colors.black,
                    //                 ),
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //             ))
                    //         .toList(),
                    //     value: selectedEndTime,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedEndTime = value as String;
                    //       });
                    //     },
                    //     icon: const Icon(
                    //       Icons.keyboard_arrow_down_rounded,
                    //     ),
                    //     iconSize: 16,
                    //     iconEnabledColor: Colors.grey,
                    //     iconDisabledColor: Colors.grey,
                    //     buttonHeight: 42,
                    //     buttonWidth: MediaQuery.of(context).size.width * 0.9,
                    //     buttonPadding:
                    //         const EdgeInsets.only(left: 14, right: 14),
                    //     buttonDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       color: Strings.textFeildBg,
                    //     ),
                    //     buttonElevation: 0,
                    //     itemHeight: 40,
                    //     itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    //     dropdownMaxHeight: 200,
                    //     dropdownWidth: 300,
                    //     dropdownPadding: null,
                    //     dropdownDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(14),
                    //       color: Colors.white,
                    //     ),
                    //     dropdownElevation: 8,
                    //     scrollbarRadius: const Radius.circular(40),
                    //     scrollbarThickness: 6,
                    //     scrollbarAlwaysShow: true,
                    //     offset: const Offset(0, 0),
                    //   ),
                    // ),

                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          checkFrom ? _selectTOTime() : null;

                          !checkFrom
                              ? AppUtils.showWarning(context,
                                  "Please check the From time first", "")
                              : null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Strings.textFeildBg,
                            border: Border.all(color: const Color(0xFFf2f3f4)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: TextField(
                                  controller: _TOTimeController,
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Strings.textFeildBg,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(15),
                                    hintText: "Select Time",
                                    hintStyle: TextStyle(fontSize: 13.5),
                                    suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.grey.withOpacity(0.3)),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: const Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextField(
                  maxLength: 150,
                  //style: TextStyle(color: Colors.black),
                  controller: _DescriptionController,
                  decoration: InputDecoration(
                    fillColor: Strings.textFeildBg,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Type here",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintStyle: TextStyle(fontSize: 13.5, color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: const Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    width: 20,
                    height: 20,
                    child: Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: Colors.green,
                        activeColor: Colors.transparent,
                        value: _isChecked,
                        onChanged: (bool? val) {
                          setState(
                            () {
                              _isChecked = val!;
                              setState(() {
                                if (_isChecked == true) {
                                  _AddressController.text = "Open to anything";
                                } else {
                                  _AddressController.text = "";
                                }
                              });
                              print("object:${_isChecked}");
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "Open to anything",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.39,
                      child: Divider(
                        color: Colors.grey.withOpacity(0.8),
                        height: 1,
                      ),
                    ),
                  ),
                  Text("or"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.39,
                      child: Divider(
                        color: Colors.grey.withOpacity(0.8),
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "Choose your location",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                //height: MediaQuery.of(context).size.height * 0.045,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  enabled: !_isChecked,
                  textAlign: TextAlign.justify,
                  maxLines: null,
                  controller: _AddressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // focusedBorder: const OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       color: Color.fromRGBO(230, 230, 230, 1), width: 0.0),
                      // ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide:
                      //       BorderSide(color: Strings.textFeildBg, width: 0.0),
                      // ),
                      // disabledBorder: OutlineInputBorder(
                      //   borderSide:
                      //       BorderSide(color: Strings.textFeildBg, width: 0.0),
                      // ),
                      fillColor: Strings.textFeildBg,
                      filled: true,
                      contentPadding: EdgeInsets.all(15),
                      hintText: "Type here",
                      hintStyle: TextStyle(fontSize: 13.5, color: Colors.grey),
                      // contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                      suffixStyle: TextStyle(color: Colors.blue, height: 2.5),
                      suffixIcon:
                          // (_currentAddress != null)
                          //     ? IconButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             _currentAddress = null;
                          //           });
                          //         },
                          //         icon: Icon(Icons.clear))
                          //     : null
                          Container(
                        width: 70,
                        child: InkWell(
                          onTap: () async {
                            // Position position =
                            //     await _getGeoLocationPosition();
                            // var location =
                            //     'Lat: ${position.latitude} , Long: ${position.longitude}';
                            // GetAddressFromLatLong(position);
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MapsPage()));
                            setState(() {
                              _getAddress();
                            });
                          },
                          child: Row(
                            children: [
                              Text("Map", style: TextStyle(color: Colors.blue)),
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.04,
              // ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 70,
                padding: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(
                                        width: 2,
                                        color: Colors.grey.withOpacity(0.2))))),
                    onPressed: () {
                      if (_dobController.text.isNotEmpty &&
                          _FromTimeController.text.isNotEmpty &&
                          _TOTimeController.text.isNotEmpty &&
                          _DescriptionController.text.isNotEmpty &&
                          _AddressController.text.isNotEmpty) {
                        Strings.markAvailabiltydate = _dobController.text;
                        Strings.markAvailabiltystartTime =
                            _FromTimeController.text;
                        Strings.markAvailabiltyendTime = _TOTimeController.text;
                        Strings.markAvailabiltydesc =
                            _DescriptionController.text;
                        Strings.markAvailabiltylocations =
                            _AddressController.text;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChooseTopic()));
                      } else {
                        AppUtils.showWarning(
                            context, "Please fill all the feilds", "");
                      }
                    },
                    child: Text(
                      "Continue",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _getGeoLocationPosition() async {
    print("1");
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[1];
    _currentAddress = '${place.name}, ${place.locality}, ${place.postalCode}';
    setState(() {
      AppUtils.dismissprogress();
      _AddressController.text = _currentAddress!;
    });
    print("Address:$_currentAddress");
  }
}
