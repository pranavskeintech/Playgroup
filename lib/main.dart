import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:playgroup/Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Utilities/Strings.dart';



void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:SplashScreen(),builder: EasyLoading.init(),
));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 60)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..progressColor = Colors.red
    ..backgroundColor = Strings.appThemecolor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
}


 



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
         home: const MyHomePage(title: 'Flutter Demo Home Page'),
         builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  int _counter = 0;

  var _bottomNavIndex = 0;

  List<IconData> iconList = [];

  @override
  void initState() {
    // TODO: implement initState

    iconList.add(Icons.home);
    iconList.add(Icons.schedule);
    iconList.add(Icons.settings);
    iconList.add(Icons.more);
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 60)
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.orange
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = true;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Clicked center");
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add_a_photo),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 60,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          backgroundColor: Colors.pink,
          activeColor: Colors.white,
          onTap: (index) {
            setState(() 
            {
              _bottomNavIndex = index;

              EasyLoading.show(status: 'loading...');
            });
            print(index);
          }
          //other params
          ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(94, 37, 108, 1),
        child: Center(child: Text("Welcome to Play group"),),
      ),
    );
  }
}
