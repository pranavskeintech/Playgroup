import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:playgroup/Screens/EditParticipatingFriends.dart';
import 'package:intl/intl.dart';
import '../Utilities/Strings.dart';

class EditAvailabilityTime extends StatefulWidget {
  final String? FromTime;
  final String? TOTime;
  EditAvailabilityTime({Key? key, this.FromTime, this.TOTime})
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
  _selectFromTime(context) async {
    final ChoosenTime1 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dt1!.hour, minute: dt1!.minute),
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

  @override
  void initState() {
    // TODO: implement initState

    _FromTimeController.text = widget.FromTime!;
    _TOTimeController.text = widget.TOTime!;

    var df = DateFormat("h:mma");
    dt1 = df.parse(widget.FromTime!);
    dt2 = df.parse(widget.TOTime!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Availability"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              height: MediaQuery.of(context).size.height * 0.04,
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
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
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
                )
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
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          if (index < 5) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              width: 40,
                              height: 40,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/imgs/${childImgs[index]}"),
                              ),
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                child: Text(
                                  "3+",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ), //Text
                              ),
                            );
                          }
                        })),
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  child: Text("Save"),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
