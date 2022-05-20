import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playgroup/Screens/LocationSelection.dart';
import 'package:playgroup/Screens/OTPScreen.dart';
import 'package:playgroup/Screens/PhoneNumber.dart';
import 'package:playgroup/Screens/ResetPassword.dart';

import 'AppUtlis.dart';
import 'Strings.dart';

class firebase {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static String? smsOTP;
  static String? verId;

  static void verifyPhone(context,phoneNumber) async 
  {
    final auth = FirebaseAuth.instance;
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      final res = await auth.signInWithCredential(phoneAuthCredential);
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
      AppUtils.dismissprogress();
      // functions.createSnackBar(context, authException.message.toString());
      // Get.off(() => const PhoneNumber());
    };
//
    final PhoneCodeSent smsOTPSent =
        (String verificationId, [int? forceResendingToken]) async 
        {
      print('verification id is $verificationId');
      verId = verificationId;
      // _isLoading = false;
      //  continued();
      // Get.to(() => OTPScreen());
            AppUtils.dismissprogress();
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
        phoneNumber: '+91$phoneNumber',
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  

  static void signIn(context,smsCode) async {
    try 
    {
      final AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId!, smsCode: smsCode
              //smsOTP!,
              );
      final user = await _auth.signInWithCredential(credential);
      final currentUser = await _auth.currentUser!;
      user == currentUser.uid;
      // Navigator.of(context).pop();
      //Navigator.of(context).pushReplacementNamed('/homepage');
      // _isLoading = false;
      //Get.to(() => const LocationSelection());
      AppUtils.dismissprogress();

      if(Strings.ForgotPassword)
      {
        print("Moing to forgot pass");
        Strings.ForgotPassword = false;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ResetPassword()));
      }
      else{
 Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => LocationSelection()));
      }
     
    } on FirebaseAuthException catch (e) 
    {
      AppUtils.dismissprogress();
      print('Error is $e');

      if(
        e.code.contains('invalid')
      )
      {
        functions.createSnackBar(context, 'Invalid OTP');
      }
      else
      {
        functions.createSnackBar(context, e.code);
      }
      
      if (e.code == 'account-exists-with-different-credential') 
      {
        //functions.createSnackBar(context, e.code.toString());
        // handle the error here
        print("account-exists-with-different-credential");
      } else if (e.code == 'invalid-credential') 
      {
        functions.createSnackBar(context, e.code.toString());
        // handle the error here
        print("invalid-credential");

      }
    } catch (e) 
    {
      //  handleError(e);
      print("Error:$e");
      // functions.createSnackBar(context, e.toString());
    }
  }
}

 class functions 
{
  static void createSnackBar(scaffoldContext, String message) {
    final snackBar =  SnackBar(
        content: Container(
          height: 20,
            child:  Text(message)
        ),
        backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }
}
