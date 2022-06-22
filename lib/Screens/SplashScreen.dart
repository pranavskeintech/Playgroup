import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status $e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  

  showAlertDialog(BuildContext context) {
    Strings.internetDialog = true;

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Connection Lost"),
      content: Text("No Internet Available!"),
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print("Status --> $_connectionStatus");
    });
    if (result == ConnectivityResult.none) {
      if (!Strings.firstLogin) {
        showAlertDialog(context);
      }
    } else {
      if (Strings.internetDialog) {
        Navigator.pop(context);
      }
    }

    // switch (result) {
    //   case ConnectivityResult.wifi:
    //   case ConnectivityResult.mobile:
    //   case ConnectivityResult.none:

    //   default:

    //     break;
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCMToken();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      Strings.firstLogin == false;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

   getFCMToken() async 
  {
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        print("token: $token");
        Strings.fcmToken = token!;
       
      });
      
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) 
    {
      setState(() {
        print("message recieved inside get");
        print("data received ---  ${message.notification!.body}");
        //  _showMyDialog("", message.notification!.title ?? "", message.notification!.body ?? "", "doc");
        print(message.data);
       
        
      });
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {

          print("trying to open app");
      
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      print("on openening message: " + message.notification!.body!);
     
    });

    

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      provisional: true,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Image.asset(
        'assets/imgs/splashscreen.png',
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    ));
  }
}
