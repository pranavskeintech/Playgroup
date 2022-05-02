import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChooseChild.dart';
import 'package:playgroup/Screens/ChooseTopic.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/LocationSelection.dart';
import 'package:playgroup/Screens/Mark_availability.dart';
import 'package:playgroup/Screens/Own_Availability.dart';
import 'package:playgroup/Screens/PhoneNumber.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:playgroup/Screens/SignupEmailScreen.dart';
import 'package:playgroup/main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'ChildConfirmation.dart';

class LoginPage extends StatefulWidget 
{
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async 
  {
    print("Clicked me");
    Timer(Duration(seconds: 3), () 
    {
      _btnController.error();
    });
  }

  Future googleSignIn(context) async 
  {
    await _googleSignIn.signOut();

    try {
      GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn() as GoogleSignInAccount;
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      print('access Token ${googleAuth.accessToken}');
      print('id Token ${googleAuth.idToken}');
      print('${googleSignInAccount.email}');
      print('${googleSignInAccount.displayName}');
      print(googleSignInAccount.photoUrl);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DashBoard(
                
              )));
    } catch (error) {
      print(error);
      print("enteres");
      return null;
    }
  }

  signInWithFacebook() async {
    try {
      print("fb");
      // AccessToken accessToken = await FacebookAuth.instance.login();
      LoginResult accessToken = await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]);
      // Create a credential from the access token
      print('accessToken ${accessToken.accessToken}');
      OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.accessToken!.token,
      );
      print('credential $credential');
      // Once signed in, return the UserCredential
      print('creadentials ${FirebaseAuth.instance.currentUser}');
      final value =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("user deatisl--> ${value.user}");

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DashBoard()));
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // handle the FirebaseAuthException
      print("------2");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
            alignment: Alignment.center,
            textDirection: TextDirection.rtl,
            fit: StackFit.loose,
            overflow: Overflow.visible,
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/imgs/loginbg.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 80,
                  // ),
                  Image.asset(
                    'assets/imgs/appicon.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Play Group",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 20, 2),
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
                    width: MediaQuery.of(context).size.width * 0.9,
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 2),
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
                    width: MediaQuery.of(context).size.width * 0.9,
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
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      //_login();
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.fromLTRB(10, 0, 20, 2),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RoundedLoadingButton(
                      resetDuration: Duration(seconds: 10),
                      resetAfterDuration: true,
                      successColor: Color.fromRGBO(94, 37, 108, 1),
                      width: 500,
                      borderRadius: 10,
                      color: Color.fromRGBO(94, 37, 108, 1),
                      child:
                          Text('LOGIN', style: TextStyle(color: Colors.white)),
                      controller: _btnController,
                      onPressed: ()
                      {
                      Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Own_Availability()));
                      },
                    ),
                  ),
                  
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "Or Login using",
                        style: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 42,
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                      color: const Color(0xFFf2f3f4)),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: FlatButton(
                                child: ImageIcon(
                                  AssetImage("assets/imgs/search.png"),
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  googleSignIn(context);
                                },
                                color: Colors.transparent,
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                      color: const Color(0xFFf2f3f4)),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: FlatButton(
                                color: Colors.black.withOpacity(0.05),
                                child: Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  signInWithFacebook();
                                },
                              )),
                        ],
                      ))
                ],
              ),
              Positioned(
                child: Row(
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
                bottom: 10,
              )
            ]),
      ),
    );
  }
}
