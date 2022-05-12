import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';

class CustomStyle {
  static var textFormFieldBoldttf = TextStyle(
      fontSize: 16,
      fontFamily: "Boldttf",
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static var itemBoxBlack = BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      // color: Colors.white,
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [
            0.1,
            0.4,
            0.6,
            0.9
          ],
          colors: const [
            Color(0xff202022),
            Color(0xff202022),
            Color(0xff202022),
            Color(0xff202022),
          ]));

  static var sidemenuBG = BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: Strings.appThemecolor,
    // gradient: LinearGradient(
    //     begin: Alignment.topRight,
    //     end: Alignment.bottomLeft,
    //     stops: [
    //       0.1,
    //       0.4,
    //       0.6,
    //       0.9
    //     ],
    //     colors: [
    //       Color(0xfff6a338),
    //       Color(0xfff6a338),
    //       Color(0xfff6a338),
    //       Color(0xfff6a338),
    //       // Color(0xfff67620),
    //       // Color(0xfff6a338),
    //       // Color(0xfff67620),
    //       // Color(0xfff6a338),
    //     ]),
  );

  static var appBtn = BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Strings.appThemecolor,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 10.0,
        ),
      ]);

  static var date = TextStyle(
      color: Color(0xff909090),
      fontFamily: "Boldttf",

      // fontFamily: "Regular",
      fontSize: 11,
      fontWeight: FontWeight.w500);

  static var key = TextStyle(
      color: Color(0xff909090),
      fontFamily: "Boldttf",
      // fontSize: 14,
      fontWeight: FontWeight.w400);
  static var settingsSub = TextStyle(
      color: Colors.grey,
      //fontFamily: "Boldttf",
      // fontSize: 14,
      );
  static var val = TextStyle(
      color: Colors.black, fontFamily: "Boldttf", fontWeight: FontWeight.w800);

  static var title = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: "Boldttf",
      fontWeight: FontWeight.w800);
  static var whiteTitle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontFamily: "Boldttf",
      fontWeight: FontWeight.w800);

  static var subTitle = TextStyle(
      color: Colors.black54,
      fontFamily: "Boldttf",
      fontWeight: FontWeight.w400);

  static var orangeTitle = TextStyle(
      color: Strings.appThemecolor,
      fontFamily: "Boldttf",
      fontWeight: FontWeight.w400);

  static var blue = TextStyle(color: Colors.blue, fontWeight: FontWeight.w600);
}
