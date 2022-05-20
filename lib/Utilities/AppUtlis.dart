import 'package:flutter/material.dart';
import 'CustomStyle.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:playgroup/Utilities/Strings.dart';
//import 'package:toast/toast.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils 
{
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
    final snackBar =  SnackBar(
        content: Container(
          height: 20,
            child:  Text(message)
        ),
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
        fontSize: 16.0
    );



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
        fontSize: 16.0
    );
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
}
