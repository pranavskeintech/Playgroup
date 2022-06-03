import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Utilities/Strings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "A Bright Future for Kids",
      "subtitle":
          "Gratitude is the most heartwarming feeling. Praise someone in the easiest way possible",
      "image": "assets/imgs/Welcome_1.png"
    },
    {
      "title": "Support Your Child's Interests",
      "subtitle":
          "Browse kudos list. See what your community is up to and get inspired",
      "image": "assets/imgs/Welcome_2.png"
    },
    {
      "title": "Improve Child's Learning Style",
      "subtitle":
          "Do your best in your day to day life and unlock achievements",
      "image": "assets/imgs/Welcome_3.png"
    },
  ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Strings.appThemecolor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 14, color: Strings.appThemecolor),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _controller,
                itemCount: splashData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      //Spacer(flex: 1),
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          splashData[index]['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF424242),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        splashData[index]['image']!,
                        //fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          splashData[index]['subtitle']!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      //Spacer(),
                    ],
                  );
                },
                onPageChanged: (value) => setState(() => _currentPage = value),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (int index) => _buildDots(index: index),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Text(
                          "NEXT",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade700),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: ImageIcon(
                            AssetImage("assets/imgs/right arrow.png"),
                            size: 16,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Strings.appThemecolor,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
