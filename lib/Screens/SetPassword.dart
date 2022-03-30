import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playgroup/Screens/OTPScreen.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  var errorpassword = null;
  bool validatePassword() {
    if (_passwordController.text == _confirmPasswordController.text) {
      setState(() {
        errorpassword = null;
        _btnController.reset();
      });
      return true;
    } else {
      setState(() {
        Timer(Duration(seconds: 1), () {
          _btnController.stop();
        });
        _btnController.error();
        errorpassword = "Password Mismatch";
      });
      return false;
    }
  }

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
                  "assets/imgs/password.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Set Password",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                      child: const Text(
                        "Enter Password",
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
                Container(
                  height: 40,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(94, 37, 108, 1), width: 0.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(230, 230, 230, 1),
                            width: 0.0),
                      ),
                      fillColor: Color.fromRGBO(230, 230, 230, 1),
                      filled: true,
                      suffixIcon: Icon(Icons.password_outlined),
                      hintText: "Enter Password",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 5.0),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                      child: const Text(
                        "Confirm Password",
                        style: const TextStyle(
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
                Container(
                  height: 80,
                  child: TextField(
                      onEditingComplete: () {
                        validatePassword();
                      },
                      onChanged: (data) {
                        if (data == "") {
                          setState(() {
                            errorpassword = null;
                          });
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        errorText: errorpassword,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(94, 37, 108, 1),
                              width: 0.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1),
                              width: 0.0),
                        ),
                        fillColor: Color.fromRGBO(230, 230, 230, 1),
                        filled: true,
                        suffixIcon: Icon(Icons.password_outlined),
                        hintText: "Confirm Password",
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true),
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
                       bool _validate = validatePassword();
                        if (_validate) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => OTPScreen()));
                        }
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
}
