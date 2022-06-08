import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'CustomStyle.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:playgroup/Utilities/Strings.dart';
//import 'package:toast/toast.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<String> ChildName = [
  "Kingston Jackey",
  "Ronny Thomas",
  "Alex Timo",
  "Christina Timo",
  "George Timo",
  "Mariya Timo",
  "Angel Timo",
  "Kingston Jackey",
  "Ronny Thomas",
  "Alex Timo"
];

List<String> Images = [
  'child.jpg',
  'child1.jpg',
  'child2.jpg',
  'child3.jpg',
  'child4.jpg',
  'child5.jpg',
  'child6.jpg',
  'child.jpg',
  'child1.jpg',
  'child2.jpg'
];

class AppUtils {
  static appbutton(String title, Function() ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        // margin: EdgeInsets.symmetric(horizontal: 20.0),
        height: 50,
        decoration: CustomStyle.appBtn,
        child: Center(
          child: Text(title, style: CustomStyle.whiteTitle),
        ),
      ),
    );
  }

  static void createSnackBar(scaffoldContext, String message) {
    final snackBar = SnackBar(
        content: Container(height: 20, child: Text(message)),
        backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }

  static void showprogress() {
    EasyLoading.show(status: 'loading...');
  }

  static void dismissprogress() {
    EasyLoading.dismiss();
  }

  static void showToast(message, ctx) {
    // Toast.show(message, ctx,
    //     backgroundColor: Strings.appColor,
    //     textColor: Colors.white,
    //     duration: Toast.LENGTH_LONG,
    //     gravity: Toast.BOTTOM);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showToastCenter(message, ctx) {
    // Toast.show(message, ctx,
    //     duration: Toast.LENGTH_LONG,
    //     gravity: Toast.CENTER,
    //     backgroundColor: Strings.appColor,
    //     textColor: Colors.white);

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static void showWarning(context, msg, onTap) {
    WarningAlertBox(
      titleTextColor: Colors.red.shade800,
      buttonColor: Strings.appThemecolor,
      context: context,
      messageText: msg,
      title: "ALERT",
    );
  }

  static void showError(context, msg, onTap) {
    DangerAlertBox(
      context: context,
      messageText: msg,
      title: "ALERT",
    );
  }

  static void showSucess(context, msg, onTap) {
    SuccessAlertBox(
      context: context,
      messageText: msg,
      title: "ALERT",
    );
  }

  static void showPopUp(context, msg, onTap) 
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            onTap();
                            Navigator.of(context).pop();
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Strings.appThemecolor),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showParticipant(context, num) 
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Stack(children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: (
                      Icon(
                        Icons.close_rounded,
                        size: 20,
                      )
                      ),
                ),
                Container(
                  height: 300,
                  width: 200,
                  child: ListView.builder(
                    itemCount: num,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/imgs/${Images[index]}"),
                              radius: 17,
                            ),
                            title: Text(
                              ChildName[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13.5),
                            ),
                          ),
                          Divider(
                            height: 3,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ]));
        });
  }
}

class TimeAgo {
  static String calculateTimeDifferenceBetween(String? createdAt) {
    DateTime startDate = DateTime.parse(createdAt!);
    DateTime endDate = DateTime.now();
    int seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60)
      return '${seconds.abs()} seconds';
    else if (seconds >= 60 && seconds < 3600)
      return '${startDate.difference(endDate).inMinutes.abs()} minutes';
    else if (seconds >= 3600 && seconds < 86400)
      return '${startDate.difference(endDate).inHours.abs()} hours';
    else if (seconds >= 86400 && seconds < 2073600)
      return '${startDate.difference(endDate).inDays.abs()} days';
    else
      return '${startDate.difference(endDate).inDays.abs()} months';
  }
}
