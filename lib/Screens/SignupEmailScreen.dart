import 'package:flutter/material.dart';
import 'package:playgroup/Screens/SetPassword.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignupEmailScreen extends StatefulWidget {
  const SignupEmailScreen({Key? key}) : super(key: key);

  @override
  State<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends State<SignupEmailScreen> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
                Image.asset(
                  "assets/imgs/appicon.png",
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 10),
                Text(
                  "Email Verification",
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
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 2),
                      child: Text(
                        "Email Id",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
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
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    // controller: _emailIdController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email_outlined),
                        hintText: "Email ID",
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        // hintStyle:
                        //     TextStyle(fontSize: 14.0, color: Colors.white),
                        // border: OutlineInputBorder(),
                        border: InputBorder.none),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(color: const Color(0xFFf2f3f4)),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 5.0),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 2),
                      child: Text(
                        "Password",
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
                  child: const TextField(
                      style: TextStyle(color: Colors.white),
                      //controller: _passwordController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.password_outlined),
                          hintText: "Password",
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          hintStyle:
                              TextStyle(fontSize: 14.0, color: Colors.black),
                          // border: OutlineInputBorder(),
                          border: InputBorder.none),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(color: const Color(0xFFf2f3f4)),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RoundedLoadingButton(
                      resetDuration: Duration(seconds: 10),
                      resetAfterDuration: true,
                      successColor: Color.fromRGBO(94, 37, 108, 1),
                      width: 500,
                      borderRadius: 10,
                      color: Strings.appThemecolor,
                      child:
                          Text('Verify', style: TextStyle(color: Colors.white)),
                      controller: _btnController,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SetPassword()));
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
                        "Do not have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SignupEmailScreen()));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.pink),
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
}
