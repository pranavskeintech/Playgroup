import 'package:flutter/material.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Screens/SplashScreen.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arg = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      default:
        return _errorRoute();
        break;
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
