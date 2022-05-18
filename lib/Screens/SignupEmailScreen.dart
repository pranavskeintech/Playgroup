import 'package:flutter/material.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Screens/SetPassword.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignupEmailScreen extends StatefulWidget {
  const SignupEmailScreen({Key? key}) : super(key: key);

  @override
  State<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends State<SignupEmailScreen> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _parentController = TextEditingController();

  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return CheckUser(newContext);
          }),
        ));
  }

  CheckUser(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Image.asset(
                  "assets/imgs/appicon.png",
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 20),
                Text(
                  "Parents Details",
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
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 2),
                      child: Text(
                        "Parent Name",
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
                Container(
                  height: 40,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _parentController,
                    decoration: InputDecoration(
                        hintText: "Enter Parent Name",
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        // border: OutlineInputBorder(),
                        border: InputBorder.none),
                    keyboardType: TextInputType.text,
                  ),
                  decoration: BoxDecoration(
                      color: Strings.textFeildBg,
                      border: Border.all(color: const Color(0xFFf2f3f4)),
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(height: 5.0),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 2),
                      child: Text(
                        "Email Id",
                        style: TextStyle(
                            fontSize: 15,
                            color: Strings.textFeildHeading,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _emailIdController,
                    decoration: const InputDecoration(
                        hintText: "Enter Email ID",
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        // border: OutlineInputBorder(),
                        border: InputBorder.none),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  decoration: BoxDecoration(
                      color: Strings.textFeildBg,
                      border: Border.all(color: const Color(0xFFf2f3f4)),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RoundedLoadingButton(
                    resetDuration: Duration(seconds: 10),
                    resetAfterDuration: true,
                    successColor: Color.fromRGBO(94, 37, 108, 1),
                    width: 500,
                    borderRadius: 5,
                    color: Strings.appThemecolor,
                    child: Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    controller: _btnController,
                    onPressed: () {
                      if (_parentController.text.isNotEmpty && _parentController.text.length > 2) {
                        if (AppUtils.validateEmail(
                            _emailIdController.text.replaceAll(' ', ''))) {
                          var email = _emailIdController.text;
                          _CheckUser(email);
                          Strings.UserName = _parentController.text;
                          Strings.EmailId = _emailIdController.text;
                          print("entered");
                        } else {
                          AppUtils.showWarning(context, "Invalid email", "");
                          _btnController.stop();
                        }
                      } else {
                        AppUtils.showWarning(
                            context, "Parents name should be minimum 3 letters", "");
                        _btnController.stop();
                      }
                    },
                  ),
                ),
                Spacer(),
                Align(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _CheckUser(email) {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.CheckUser(email).then((response) {
      print(response.status);
      if (response.status == false ) {
        _btnController.stop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SetPassword()));
      } else {
        functions.createSnackBar(context, response.message.toString());
        _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
