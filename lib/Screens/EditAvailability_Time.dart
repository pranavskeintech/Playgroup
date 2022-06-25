import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:playgroup/Models/EditAvailabilityCommonReq.dart';
import 'package:playgroup/Models/EditAvailabilityReq.dart';
import 'package:playgroup/Models/OwnAvailabilityDetailsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/EditParticipatingFriends.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:provider/provider.dart';
import '../Utilities/Strings.dart';

class EditAvailabilityTime extends StatefulWidget {
  final String? FromTime;
  final String? TOTime;
  int? markavailId;
  EditAvailabilityTime({Key? key, this.FromTime, this.TOTime, this.markavailId})
      : super(key: key);

  @override
  State<EditAvailabilityTime> createState() => _EditAvailabilityTimeState();
}

class _EditAvailabilityTimeState extends State<EditAvailabilityTime> {
  String? selectedStartTime;
  String? selectedEndTime;
  final _FromTimeController = TextEditingController();
  final _TOTimeController = TextEditingController();
  List<String> items = [
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 Pm',
    '6 PM',
    '7 PM',
    '8 PM',
  ];
  List<String> childImgs = [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];

  DateTime? dt1;

  DateTime? dt2;

  BuildContext? ctx;

  List<Data> availabilityData = [];

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getAvailabilityDetails());
    _FromTimeController.text = widget.FromTime!;
    _TOTimeController.text = widget.TOTime!;

    // var df = DateFormat("h:mma");
    // print("time:${widget.FromTime!}");
    // var date = widget.FromTime!.replaceAll(' ', '');
    // dt1 = df.parse(date);
    // print("time2:${date}");
    // print("time3:${dt1!.hour}");
    // dt2 = df.parse(widget.TOTime!);
    super.initState();
  }

  getAvailabilityDetails() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api
        .getAvailabilityDetails(widget.markavailId!, Strings.SelectedChild)
        .then((response) {
      if (response.status == true) {
        //  print("hvhjvj:${availabilityData[0].friendsdata}");
        print("response ${response.status}");
        setState(() {
          availabilityData = response.data!;
          _isLoading = false;
        });
      } else {
        _isLoading = false;
        functions.createSnackBar(ctx, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  _selectFromTime(context) async {
    //print("time:${dt1!.hour}");
    final ChoosenTime1 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),
      //TimeOfDay(hour: dt1!.hour, minute: dt1!.minute),
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

  _selectTOTime() async {
    final ChoosenTime2 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 12, minute: 00),
        initialEntryMode: TimePickerEntryMode.dial,
        confirmText: "CONFIRM",
        // cancelText: "NOT NOW",
        helpText: "SELECT TIME");

    if (ChoosenTime2 != null) {
      setState(() {
        if (ChoosenTime2.format(context) == _FromTimeController.text) {
          AppUtils.showWarning(
              context, "The from and to time should not be same", "");
          _TOTimeController.text = "";
        } else {
          _TOTimeController.text = ChoosenTime2.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return EditMarkAvailability(newContext);
          }),
        ));
  }

  EditMarkAvailability(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Edit Availability"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
          : Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
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
                        child: Text("From"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text("To"),
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
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
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
                              suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey.withOpacity(0.3)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        // child: DropdownButtonHideUnderline(
                        //   child: DropdownButton2(
                        //     isExpanded: true,
                        //     hint: Row(
                        //       children: const [
                        //         Expanded(
                        //           child: Text(
                        //             'Select time',
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.black),
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
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.bold,
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
                        //       Icons.arrow_forward_ios_outlined,
                        //     ),
                        //     iconSize: 14,
                        //     iconEnabledColor: Colors.black,
                        //     iconDisabledColor: Colors.grey,
                        //     buttonHeight: 50,
                        //     buttonWidth: MediaQuery.of(context).size.width * 0.9,
                        //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                        //     buttonDecoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //       color: Color.fromARGB(255, 230, 230, 230),
                        //     ),
                        //     buttonElevation: 2,
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
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GestureDetector(
                          onTap: () {
                            _selectTOTime();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Strings.textFeildBg,
                                border:
                                    Border.all(color: const Color(0xFFf2f3f4)),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
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
                                            color:
                                                Colors.grey.withOpacity(0.3)),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // child: DropdownButtonHideUnderline(
                        //   child: DropdownButton2(
                        //     isExpanded: true,
                        //     hint: Row(
                        //       children: const [
                        //         Expanded(
                        //           child: Text(
                        //             'Select time',
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.black),
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
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.bold,
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
                        //       Icons.arrow_forward_ios_outlined,
                        //     ),
                        //     iconSize: 14,
                        //     iconEnabledColor: Colors.black,
                        //     iconDisabledColor: Colors.grey,
                        //     buttonHeight: 50,
                        //     buttonWidth: MediaQuery.of(context).size.width * 0.9,
                        //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                        //     buttonDecoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //       color: Color.fromARGB(255, 230, 230, 230),
                        //     ),
                        //     buttonElevation: 2,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Participating Friends",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditParticipatingFriends(),
                            ));
                          },
                          child: Text("Edit"))
                    ],
                  ),
                  (availabilityData[0].friendsdata!.length == 0)
                      ? Container(
                          child: Text(
                            "Add Some Participants",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      : SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        availabilityData[0].friendsdata!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
                                      if (index < 5) {
                                        return Container(
                                          padding: EdgeInsets.all(2),
                                          width: 40,
                                          height: 40,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            backgroundImage: availabilityData[0]
                                                        .friendsdata![index]
                                                        .profile !=
                                                    "null"
                                                ? NetworkImage(Strings
                                                        .imageUrl +
                                                    (availabilityData[0]
                                                            .friendsdata![index]
                                                            .profile ??
                                                        ""))
                                                : AssetImage(
                                                        "assets/imgs/appicon.png")
                                                    as ImageProvider,
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          padding: EdgeInsets.all(3),
                                          height: 40,
                                          width: 40,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.3),
                                            child: Text(
                                              "3+",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ), //Text
                                          ),
                                        );
                                      }
                                    })),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        child: Text("Save"),
                        onPressed: () {
                          _EditTime();
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.40,
                  // ),
                ],
              ),
            ),
    );
  }

  _EditTime() {
    EditAvailabilityCommonReq editAvailability = EditAvailabilityCommonReq();
    editAvailability.from = _FromTimeController.text;
    editAvailability.to = _TOTimeController.text;
    editAvailability.childId = availabilityData[0].childId!;
    editAvailability.markId = availabilityData[0].markavailId!;
    print("1:${_FromTimeController.text}");
    print("2:${_TOTimeController.text}");
    print("3:${availabilityData[0].childId!}");
    print("4:${availabilityData[0].markavailId!}");
    editAvailability.friendId = [];
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.EditAvailability(editAvailability).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
        print("result2:$response");
      } else {
        functions.createSnackBar(ctx, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }
}
