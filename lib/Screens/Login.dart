import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/Forgotpassword.dart';
import 'package:playgroup/Screens/Own_Availability.dart';
import 'package:playgroup/Screens/SignupEmailScreen.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/ExitPopup.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


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

  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController forgotPassEmailID = TextEditingController();

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
      print(googleSignInAccount.email);
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
        accessToken.accessToken!.token
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
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
              clipBehavior: Clip.none, alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              children: <Widget>[
                SizedBox(
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
                      height: 80,
                      width: 80,
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
                    SizedBox(
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
                      child:  TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _emailIdController,
                        decoration: InputDecoration(
                            suffixIcon: Image.asset("assets/imgs/mail.png",width: 10,height: 10,color: Colors.grey,),
                            hintText: "Enter email Id",
                            hintStyle: TextStyle(fontSize:15, color: Colors.grey),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                            // hintStyle:
                            //     TextStyle(fontSize: 14.0, color: Colors.white),
                            // border: OutlineInputBorder(),
                            border: InputBorder.none),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                         // border: Border.all(color: const Color(0xFFf2f3f4)),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 2),
                          child: const Text(
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
                      child:  TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          decoration: InputDecoration(
                              suffixIcon: Image.asset("assets/imgs/pass.png",width: 10,height: 10,color: Colors.grey,),
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize:15, color: Colors.grey),
                              contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                              // border: OutlineInputBorder(),
                              border: InputBorder.none),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          //border: Border.all(color: const Color(0xFFf2f3f4)),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Forgotpassword()));
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
                        borderRadius: 5,
                        color: Color.fromRGBO(94, 37, 108, 1),
                        child:
                            const Text('LOGIN', style: TextStyle(color: Colors.white,fontSize: 18)),
                        controller: _btnController,
                        onPressed: ()
                        {

                             if (_passwordController.text.isNotEmpty && _emailIdController.text.isNotEmpty) {
                        if (AppUtils.validateEmail(_emailIdController.text)) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DashBoard()));
                        } else {
                          AppUtils.showWarning(context, "Invalid email", "");
                          _btnController.stop();
                        }
                      } else {
                        AppUtils.showWarning(
                            context, "Please enter parent name", "");
                        _btnController.stop();
                      }


                        Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => DashBoard()));
                        },
                      ),
                    ),
                    
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          "Or login using",
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
                                        color: Color.fromARGB(255, 124, 125, 126)),
                                    borderRadius: BorderRadius.circular(5)),
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: FlatButton(
                                  child: ImageIcon(
                                    AssetImage("assets/imgs/google.png"),
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
                                        color: Color.fromARGB(255, 124, 125, 126)),
                                    borderRadius: BorderRadius.circular(5)),
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: FlatButton(
                                  color: Colors.black.withOpacity(0.05),
                                  child: ImageIcon(
                                    AssetImage("assets/imgs/facebook.png"),
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
                          style: TextStyle(color: Color.fromRGBO(248, 103, 171, 1)),
                        ),
                      )
                    ],
                  ),
                  bottom: 10,
                )
              ]),
        ),
      ),
    );
  }
  Future<void> _forgotPass() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctxd) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(ctxd).pop();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(ctxd).size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          new Icon(Icons.close,
                              size: 22.0, color: Colors.black),
                        ],
                      ),
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Regitered Email Id",
                      style: TextStyle(
                          color: Color(0xFF0061b0),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: forgotPassEmailID,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,
                              size: 14, color: Color(0xFF0061b0))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                       // _generateOtp(context);
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        width: MediaQuery.of(ctxd).size.width * 0.8,
                        height: 40,
                        margin: EdgeInsets.fromLTRB(10, 25, 20, 2),
                        decoration: BoxDecoration(
                            color: Color(0xFF0061b0),
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
