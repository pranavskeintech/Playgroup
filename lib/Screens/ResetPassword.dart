import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playgroup/Models/RegisterReq.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Screens/PhoneNumber.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Network/ApiService.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var ctx;
  var errorpassword;

  bool showpassword = false;

  bool showConfirmPassword = false;
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
    return Provider(
      create: (context) => ApiService.create(),
      child: Scaffold(
        body: Builder(builder: (BuildContext newContext) {
          return PasswordReset(newContext);
        }),
      ),
    );
  }

  PasswordReset(BuildContext context) {
    ctx = context;
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_back_sharp)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Image.asset(
                  "assets/imgs/setpassword.png",
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 2),
                      child: Text(
                        "Enter Password",
                        style: TextStyle(
                            fontSize: 15,
                            color: Strings.textFeildHeading,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          showpassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(230, 230, 230, 1),
                            width: 0.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(230, 230, 230, 1),
                            width: 0.0),
                      ),
                      fillColor: Strings.textFeildBg,
                      filled: true,
                      // suffixIcon: Icon(Icons.key),
                      hintText: "Enter Password",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: !showpassword,
                  ),
                ),
                const SizedBox(height: 5.0),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontSize: 15,
                            color: Strings.textFeildHeading,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                      // onEditingComplete: () {
                      //   // validatePassword();
                      // },
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            !showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                        ),
                        errorText: errorpassword,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1),
                              width: 0.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1),
                              width: 0.0),
                        ),
                        fillColor: Strings.textFeildBg,
                        filled: true,
                        // suffixIcon: Icon(Icons.key),
                        hintText: "Confirm Password",
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        hintStyle:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: showConfirmPassword),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RoundedLoadingButton(
                    resetDuration: const Duration(seconds: 10),
                    resetAfterDuration: true,
                    successColor: const Color.fromRGBO(94, 37, 108, 1),
                    width: 500,
                    borderRadius: 5,
                    color: Strings.appThemecolor,
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    controller: _btnController,
                    onPressed: () {
                      bool _validate = true; //validatePassword();
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        ;
                        if (_confirmPasswordController.text.length > 6) {
                          updatePassword(_confirmPasswordController.text);
                        } else {
                          _btnController.stop();
                          AppUtils.showError(context,
                              "Password should be minimum 6 characters", "");
                        }
                      } else {
                        functions.createSnackBar(
                            context, "The passwords do not match !!!");
                        _btnController.stop();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have a account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Strings.ForgotPassword = false;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color.fromRGBO(248, 103, 171, 1)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updatePassword(password) {
    final api = Provider.of<ApiService>(ctx, listen: false);
    UserRegisterReq user = UserRegisterReq();
    user.phone = Strings.PhoneNumber;
    user.password = password;

    api.ForgotPassword(user).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");

      if (response.status == true) {
        AppUtils.showToast("Password Updated Successfully", ctx);

        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        _btnController.stop();
        print("error");
      }
    });
  }
}
