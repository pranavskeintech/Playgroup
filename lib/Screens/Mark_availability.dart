import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/ChatsPage.dart';
import 'package:playgroup/Screens/ChooseTopic.dart';
import 'package:playgroup/Screens/G-Map.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:playgroup/Utilities/NavigationDrawer.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

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

  _selectFromTime(context) async {
    final ChoosenTime1 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: "CONFIRM",
      // cancelText: "NOT NOW",
      helpText: "SELECT TIME",
    );

    if (ChoosenTime1 != null) {
      setState(() {
        // String time1 = "${ChoosenTime1.hour}:${ChoosenTime1.minute}";
        _FromTimeController.text = ChoosenTime1.format(context);
      });
    }
  }

  // TimeOfDay selectedTime = TimeOfDay.now();
  // _selectFromTime(BuildContext context) async {
  //   final TimeOfDay? picked_s = await showTimePicker(
  //       context: context,
  //       initialTime: selectedTime,
  //       builder: (BuildContext context, child) {
  //         return MediaQuery(
  //           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
  //           child: Text("data"),
  //         );
  //       });

  //   if (picked_s != null && picked_s != selectedTime)
  //     setState(() {
  //       String time1 = "${picked_s.hour}-${picked_s.minute}";
  //       _FromTimeController.text = time1;
  //       selectedTime = picked_s;
  //       print("object:$selectedTime");
  //     });
  // }

  _selectTOTime() async {
    final ChoosenTime2 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        confirmText: "CONFIRM",
        // cancelText: "NOT NOW",
        helpText: "SELECT TIME");

    if (ChoosenTime2 != null) {
      setState(() {
        _TOTimeController.text = ChoosenTime2.format(context);
      });
    }
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (picked != null) {
      setState(() {
        String date1 = "${picked.day}-${picked.month}-${picked.year}";
        _dobController.text = date1;
        print("date selected");
        todaySelected = false;
        TommorowSelected = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    iconList.add(Icons.home_outlined);
    iconList.add(Icons.schedule);
    iconList.add(Icons.search);
    iconList.add(Icons.notifications_outlined);
    super.initState();
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
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/imgs/appicon.png",
                width: 28,
                height: 28,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Play Group",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              print(now.day.toString() +
                  " " +
                  now.month.toString() +
                  "  " +
                  now.year.toString());
              showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Image(
                          image: AssetImage(
                              "assets/imgs/child5.jpg")), //Hard code for profile image
                    );
                  });
            },
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/imgs/child5.jpg"),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Chat_List()));
              },
              icon: Image.asset(
                "assets/imgs/chat.png",
                width: 25,
                height: 25,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: ImageIcon(
              AssetImage("assets/imgs/menu_ver2.png"),
              color: Colors.black,
            )),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          // Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => Choose_Category()));
        },
        backgroundColor: Strings.appThemecolor,
        child: Icon(Icons.close_rounded),

        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 60,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          backgroundColor: Strings.appThemecolor,
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
            print(index);
          }
          //other params
          ),
      body: SingleChildScrollView(
        child: Container(
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
                        String date2 = "${now.day}-${now.month}-${now.year}";
                        _dobController.text = date2;
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
                        String date3 = "${tom.day}-${tom.month}-${tom.year}";
                        _dobController.text = date3;
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
                  decoration: BoxDecoration(
                      color: Strings.textFeildBg,
                      border: Border.all(color: const Color(0xFFf2f3f4)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
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
                              hintText: "Pick a Date",
                              suffixIcon: Icon(Icons.calendar_today_outlined,
                                  size: 18,
                                  color: Colors.grey.withOpacity(0.3)),
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ],
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
              SizedBox(height: 10),
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
                height: 10,
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

                    child: GestureDetector(
                      onTap: () {
                        _selectFromTime(context);
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
                                height: 42,
                                child: TextField(
                                  controller: _FromTimeController,
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Strings.textFeildBg,
                                    filled: true,
                                    hintText: "Select Time",
                                    suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.grey.withOpacity(0.3)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ],
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
                        _selectTOTime();
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
                                height: 42,
                                child: TextField(
                                  controller: _TOTimeController,
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Strings.textFeildBg,
                                    filled: true,
                                    hintText: "Select Time",
                                    suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.grey.withOpacity(0.3)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 0, 0),
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
                height: 20,
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
                height: 42,
                decoration: BoxDecoration(
                    color: Strings.textFeildBg,
                    border: Border.all(color: const Color(0xFFf2f3f4)),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: _DescriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Strings.textFeildBg, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Strings.textFeildBg, width: 0.0),
                          ),
                          fillColor: Strings.textFeildBg,
                          filled: true,
                          hintText: "Type Here",
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                height: 5,
              ),
              Text(
                "Choose your location",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Strings.textFeildBg,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    // SizedBox(
                    //   height: 42,
                    //   width: MediaQuery.of(context).size.width * 0.7,
                    //   child: TextDropdownFormField(
                    //     options: const ["Open to anything", "Current location"],
                    //     // decoration: InputDecoration(
                    //     //     border: OutlineInputBorder(),
                    //     //     suffixIcon: Icon(Icons.arrow_drop_down),
                    //     //     labelText: "Gender"),
                    //     decoration: InputDecoration(
                    //       fillColor: Colors.transparent,
                    //       filled: true,
                    //       border: InputBorder.none,
                    //       focusedBorder: InputBorder.none,
                    //       enabledBorder: InputBorder.none,
                    //       errorBorder: InputBorder.none,
                    //       disabledBorder: InputBorder.none,
                    //       contentPadding: EdgeInsets.only(
                    //           left: 15, bottom: 11, top: 11, right: 15),
                    //       //labelText: "Gender"),
                    //     ),
                    //     dropdownHeight: 120,
                    //   ),
                    // ),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ((_currentAddress != null &&
                                  _currentAddress != '') ||
                              (_AddressController.text == ''))
                          ? TextField(
                              style: TextStyle(color: Colors.black),
                              controller: _AddressController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                      width: 0.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Strings.textFeildBg, width: 0.0),
                                ),
                                fillColor: Strings.textFeildBg,
                                filled: true,
                                hintText: "Type here",
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 5, 0, 0),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _currentAddress = null;
                                      });
                                    },
                                    icon: Icon(Icons.clear)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            )
                          : TextDropdownFormField(
                              options: ["Open to anything", "Current Location"],
                              // decoration: InputDecoration(
                              //     border: OutlineInputBorder(),
                              //     suffixIcon: Icon(Icons.arrow_drop_down),
                              //     labelText: "Gender"),
                              onChanged: (dynamic str) async {
                                if (str == "Current Location") {
                                  AppUtils.showprogress();
                                  Position position =
                                      await _getGeoLocationPosition();
                                  var location =
                                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                                  GetAddressFromLatLong(position);
                                } else {
                                  _AddressController.text = "Open to anything";
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                //labelText: "Gender"),
                                hintText: "Type here",
                              ),
                              dropdownHeight: 120,
                            ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MapsPage()));
                        setState(() {
                          _getAddress();
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Map",
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                padding: EdgeInsets.only(bottom: 20),
                child: TextButton(
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
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: 100,
              )
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
