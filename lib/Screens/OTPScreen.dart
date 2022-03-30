import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/LocationSelection.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var _btnController = RoundedLoadingButtonController();
  FocusNode one = new FocusNode();
  FocusNode two = new FocusNode();
  FocusNode three = new FocusNode();
  FocusNode four = new FocusNode();
  FocusNode five = new FocusNode();
  FocusNode six = new FocusNode();

  final oneT = TextEditingController();
  final twoT = TextEditingController();
  final threeT = TextEditingController();
  final fourT = TextEditingController();
  final fiveT = TextEditingController();
  final sixT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Image.asset(
                  "assets/imgs/otp.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  "OTP Verification",
                  style: const TextStyle(
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
                        textAlign:TextAlign.justify,
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
                    resetDuration: const Duration(seconds: 10),
                    resetAfterDuration: true,
                    successColor: const Color.fromRGBO(94, 37, 108, 1),
                    width: 500,
                    borderRadius: 10,
                    color: Strings.appThemecolor,
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white)),
                    controller: _btnController,
                    onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LocationSelection()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _boxBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _box(1),
        _box(2),
        _box(3),
        _box(4),
        _box(5),
        _box(6)
      ],
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
