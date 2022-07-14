import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/LocationSelection.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Screens/ResetPassword.dart';
import 'package:playgroup/Screens/SetPassword.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Utilities/AppUtlis.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _btnController = RoundedLoadingButtonController();
  FocusNode one = FocusNode();
  FocusNode two = FocusNode();
  FocusNode three = FocusNode();
  FocusNode four = FocusNode();
  FocusNode five = FocusNode();
  FocusNode six = FocusNode();
  int time = 30;

  final oneT = TextEditingController();
  final twoT = TextEditingController();
  final threeT = TextEditingController();
  final fourT = TextEditingController();
  final fiveT = TextEditingController();
  final sixT = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDownTimer();
  }

  countDownTimer() {
    print("inside count");
    var timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (time > 0) {
            time--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerUp: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back_sharp)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                    Image.asset(
                      "assets/imgs/otp.png",
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.075,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: const Text(
                            "Enter the 6 digit OTP that has been send to your mobile number.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _boxBuilder(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(right: 0, top: 10),
                        child: time != 0
                            ? Text(time.toString() + " seconds",
                                style: TextStyle(color: Colors.grey))
                            : TextButton(
                                child: Text("Resend"),
                                onPressed: () {
                                  AppUtils.showprogress();
                                  firebase.verifyPhone(
                                      context, Strings.PhoneNumber);
                                },
                              ),
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //         color: Colors.grey.withOpacity(0.3),
                    //         border: Border.all(color: const Color(0xFFf2f3f4)),
                    //         borderRadius: BorderRadius.circular(10)),
                    //   child:
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RoundedLoadingButton(
                        animateOnTap: false,
                        resetDuration: const Duration(seconds: 10),
                        resetAfterDuration: true,
                        successColor: const Color.fromRGBO(94, 37, 108, 1),
                        width: 500,
                        borderRadius: 5,
                        color: Strings.appThemecolor,
                        child: const Text('Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        controller: _btnController,
                        onPressed: () {
                          _btnController.reset();
                          var enteredOTP = oneT.text +
                              twoT.text +
                              threeT.text +
                              fourT.text +
                              fiveT.text +
                              sixT.text;
                          print(enteredOTP);

                          if (enteredOTP.length == 6) {
                            AppUtils.showprogress();
                            firebase.signIn(context, enteredOTP);
                          } else {
                            AppUtils.showToast("Please enter valid OTP", "");
                          }

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         LocationSelection()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _boxBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[_box(1), _box(2), _box(3), _box(4), _box(5), _box(6)],
    );
  }

  Widget _box(val) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        alignment: Alignment.center,
        height: 50,
        width: 40,
        child: TextField(
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          textInputAction: TextInputAction.done,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}'))
          ],
          maxLength: 1,
          autofocus: true,
          controller: val == 1
              ? oneT
              : val == 2
                  ? twoT
                  : val == 3
                      ? threeT
                      : val == 4
                          ? fourT
                          : val == 5
                              ? fiveT
                              : sixT,
          focusNode: val == 1
              ? one
              : val == 2
                  ? two
                  : val == 3
                      ? three
                      : val == 4
                          ? four
                          : val == 5
                              ? five
                              : six,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10), counterText: ''),
          textAlign: TextAlign.center,
          onChanged: (value) {
            print(value);
            if (value == '') {
              FocusScope.of(context).requestFocus(
                val == 6
                    ? five
                    : val == 5
                        ? four
                        : val == 4
                            ? three
                            : val == 3
                                ? two
                                : val == 2
                                    ? one
                                    : null,
              );
            } else {
              FocusScope.of(context).requestFocus(
                val == 1
                    ? two
                    : val == 2
                        ? three
                        : val == 3
                            ? four
                            : val == 4
                                ? five
                                : val == 5
                                    ? six
                                    : null,
              );
              print("not null");
            }
          },
        ),
      ),
    );
  }
}
