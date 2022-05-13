import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playgroup/Screens/LocationSelection.dart';
import 'package:playgroup/Screens/OTPScreen.dart';
import 'package:playgroup/Screens/PhoneNumber.dart';

class firebase {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static String? smsOTP;
  static String? verId;

  static void verifyPhone(context) async {
    final auth = FirebaseAuth.instance;
//
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      final res = await auth.signInWithCredential(phoneAuthCredential);
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
      // functions.createSnackBar(context, authException.message.toString());
      // Get.off(() => const PhoneNumber());
    };
//
    final PhoneCodeSent smsOTPSent =
        (String verificationId, [int? forceResendingToken]) async {
      print('verification id is $verificationId');
      verId = verificationId;
      // _isLoading = false;
      //  continued();
      // Get.to(() => OTPScreen());
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => OTPScreen()));
    };
//
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verId = verificationId;
    };
//
    await auth.verifyPhoneNumber(
        // mobile no. with country code
        phoneNumber: '+91${8848216020}',
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static void signIn(context) async {
    try {
      final AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId!, smsCode: '123456'
              //smsOTP!,
              );
      final user = await _auth.signInWithCredential(credential);
      final currentUser = await _auth.currentUser!;
      user == currentUser.uid;
      // Navigator.of(context).pop();
      //Navigator.of(context).pushReplacementNamed('/homepage');
      // _isLoading = false;
      //Get.to(() => const LocationSelection());

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => LocationSelection()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //functions.createSnackBar(context, e.code.toString());
        // handle the error here
        print("account-exists-with-different-credential");
      } else if (e.code == 'invalid-credential') {
        //  functions.createSnackBar(context, e.code.toString());
        // handle the error here
        print("invalid-credential");
      }
    } catch (e) {
      //  handleError(e);
      print("Error:$e");
      // functions.createSnackBar(context, e.toString());
    }
  }
}

class functions {
  static void createSnackBar(scaffoldContext, String message) {
    final snackBar = new SnackBar(
        content: Container(
            child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(scaffoldContext).viewInsets.bottom),
          child: new Text(message),
        )),
        backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }
}
