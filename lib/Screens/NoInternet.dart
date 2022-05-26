import 'package:flutter/material.dart';

import '../Utilities/ExitPopup.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({ Key? key }) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Container(color: Colors.green,
        
      ),
    );
  }
}