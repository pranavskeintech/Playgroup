import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:playgroup/Screens/NoInternet.dart';
import 'package:playgroup/Screens/OnBoardingScreen.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Timer? timer;

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
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => WillPopScope(
              onWillPop: () async {
                print("back");
                return false;
              },
              child: alert,
            ));
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print("Status --> $_connectionStatus");
    });
    if (result == ConnectivityResult.none) {
      showAlertDialog(context);
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (BuildContext context) => NoInternet()));
    } else {
      if (Strings.internetDialog == true) {
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
    getToken();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Timer(const Duration(seconds: 3), () {
      checkToken();
    });
  }

  checkToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Strings.authToken = sharedPreferences.getString("token")!;
    Strings.refreshToken = sharedPreferences.getString("refreshToken")!;
    Strings.SelectedChild = sharedPreferences.getInt("SelectedChild")!;
    print("object:${Strings.authToken}");
    if (Strings.authToken == null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      Strings.firstLogin == false;
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void getToken() {
    DefaultCacheManager().emptyCache();

    getFCMToken();
    timer = new Timer(const Duration(milliseconds: 3000), () {
      // pageselector
      AppUtils.getStringPreferences('isFirstTime').then((res) {
        print(res);
        if (res != "null") {
          // Navigator.popAndPushNamed(context, "/login");
          // _checkRememberMobile();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => OnBoardingScreen()));
        }
      }).catchError((onError) {
        print(onError.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => OnBoardingScreen()));
      });
    });
  }

  getFCMToken() async {
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        print("token: $token");
        Strings.fcmToken = token!;
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
