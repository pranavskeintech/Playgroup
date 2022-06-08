import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playgroup/Models/ChooseChildReq.dart';
import 'package:playgroup/Models/GetProfileRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:provider/provider.dart';
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

  static void showPopUp(context, msg) {
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
                          print('no selected');
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

  static void showParticipant(context, num) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: Stack(children: [
              Positioned(
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                  ),
                  right: 3),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 350, minHeight: 100),
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
            ]),
          ));
        });
  }
}

class TimeAgo {
  static String calculateTimeDifferenceOfSeconds(String? createdAt) {
    DateTime startDate = DateTime.parse(createdAt!);
    DateTime endDate = DateTime.now();
    int seconds = endDate.difference(startDate).inSeconds;
    int Days = endDate.difference(startDate).inDays;
    final yearsDifference = endDate.year - startDate.year;

    if (seconds < 60)
      return '${seconds.abs()} seconds';
    else if (seconds >= 60 && seconds < 3600)
      return '${startDate.difference(endDate).inMinutes.abs()} minutes';
    else if (seconds >= 3600 && seconds < 86400)
      return '${(endDate.hour) - (startDate.hour).abs()} hours';
    // else if (seconds >= 86400 && seconds < 2073600)
    //   return '${startDate.difference(endDate).inDays.abs()} days';
    else if (Days >= 1 && Days < 30)
      return '${startDate.difference(endDate).inDays.abs()} days';
    else if (Days >= 30 && Days < 365)
      return '${(endDate.month) - (startDate.month).abs()} months';
    else
      return '${(endDate.year) - (startDate.year).abs()} years';
  }
}

class SwitchChild {
  static bool _isLoading = true;

  static Profile? _ProfileData;

  static int? _SelectedChildId;

  static int? index1;

  static Children? HeaderData;

  static Children? ListViewData;

  static GetProfile(ctx) {
    print("hiiii");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetProfile().then((response) {
      if (response.status == true) {
        // AppUtils.dismissprogress();

        _ProfileData = response.profile;
        _SelectedChildId = _ProfileData!.selectedChildId;
        for (var i = 0; i < _ProfileData!.children!.length; i++) {
          if (_ProfileData!.children![i].childId == _SelectedChildId) {
            index1 = i;
          }
        }
        HeaderData = _ProfileData!.children![index1!];
        ListViewData = _ProfileData!.children!.removeAt(index1!);
        _isLoading = false;
        // _showDialog(ctx);
      } else {
        functions.createSnackBar(ctx, response.status.toString());
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  static showChildDialog(ctx) {
    GetProfile(ctx);
    _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : showDialog(
            context: ctx,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Switch Child",
                          style: TextStyle(fontSize: 17),
                        ),
                        GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: Icon(Icons.clear))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                        backgroundImage: AssetImage("assets/imgs/child5.jpg"),
                        radius: 32),
                    SizedBox(
                      height: 10,
                    ),
                    Text(HeaderData!.childName!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                content: setupAlertDialoadContainer(ctx),
                // Image(
                //     image: AssetImage(
                //         "assets/imgs/child5.jpg")), //Hard code for profile image
              );
            });
  }

  static Widget setupAlertDialoadContainer(ctx) {
    print("object:${_ProfileData!.children!.length}");
    return (_ProfileData!.children!.length == 0)
        ? Container(
            height: 0,
          )
        : Container(
            height: 150.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _ProfileData!.children!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: InkWell(
                      onTap: () {
                        AppUtils.showprogress();
                        var ChildId =
                            _ProfileData!.children![index].childId ?? "";
                        _ChooseChild(ChildId, ctx);
                      },
                      child: Container(
                        width: 250,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.15),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.fromLTRB(12, 5, 0, 5),
                        child: Center(
                          child: Text(
                            _ProfileData!.children![index].childName!,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }

  static _ChooseChild(ChildId, ctx) {
    //var Pid = Strings.Parent_Id.toInt();
    ChooseChildReq ChooseChild = ChooseChildReq();
    ChooseChild.selectedChildId = ChildId;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.ChooseChild(ChooseChild).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.push(
            ctx, MaterialPageRoute(builder: (context) => DashBoard()));
        print("result2:$response");
      } else {
        functions.createSnackBar(ctx, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }
}
