import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:playgroup/Models/SuggestTimeReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class SuggestTime extends StatefulWidget {
  final String? FromTime;
  final String? TOTime;
  int? markavailId;
  int? ChildId;
  int? OtherChildId;
  SuggestTime(
      {Key? key,
      this.FromTime,
      this.TOTime,
      this.markavailId,
      this.ChildId,
      this.OtherChildId})
      : super(key: key);

  @override
  State<SuggestTime> createState() => _SuggestTimeState();
}

class _SuggestTimeState extends State<SuggestTime> {
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

  BuildContext? ctx;

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
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
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
        helpText: "SELECT TIME",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },);

    if (ChoosenTime2 != null) {
      setState(() {
        _TOTimeController.text = ChoosenTime2.format(context);
      });
    }
  }

  @override
  void initState() {
    _FromTimeController.text = widget.FromTime!;
    _TOTimeController.text = widget.TOTime!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return SuggestTime(newContext);
          }),
        ));
  }

  SuggestTime(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Suggest a time"),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      _selectTOTime();
                    },
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
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey.withOpacity(0.3)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  child: Text("Send"),
                  onPressed: () {
                    SuggestTimes();
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

  SuggestTimes() {
    AppUtils.showprogress();

    SuggestTimeReq suggestTime = SuggestTimeReq();

    suggestTime.childId = Strings.SelectedChild;
    suggestTime.otherChildId = widget.OtherChildId;
    suggestTime.from = _FromTimeController.text;
    suggestTime.to = _TOTimeController.text;
    print(jsonEncode(suggestTime));
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.suggestTime(suggestTime).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.pop(context);
      } else {
        functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }
}
