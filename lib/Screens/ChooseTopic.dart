import 'package:flutter/material.dart';
import 'package:playgroup/Screens/Availability-Choose_category.dart';
import 'package:playgroup/Utilities/Strings.dart';

import 'Availability-Choose_friends.dart';

class ChooseTopic extends StatefulWidget {
  const ChooseTopic({Key? key}) : super(key: key);

  @override
  State<ChooseTopic> createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  int? selectedActivities;
  int? selectedOtherActivities;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Availability"),
        backgroundColor: Strings.appThemecolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          tooltip: 'back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "Top Activities",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Container(
<<<<<<< HEAD
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: GridView.builder(
                  itemCount: 3,
=======
                margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: GridView.builder(
                  itemCount: 2,
>>>>>>> 6790bfe3dd6cf8acc9c2632cfb9e8cd202cbc4d8
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 30.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOtherActivities = null;
                            selectedActivities = index;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow:  [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                    offset: Offset(
                                      2.0, // Move to right 10  horizontally
                                      2.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
                                  children: [
                                    // Image.asset(
                                    // "assets/imgs/book.png",width: 100,height: 100,),
                                    ImageIcon(
                                      AssetImage("assets/imgs/book.png"),
                                      color: Colors.grey,
                                      size: 68,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Learn")
                                  ],
=======
                                  children: [Image.asset(
                                    "assets/imgs/book.png",width: 50,height: 50,),
                                    SizedBox(height: 10,),
                                    Text("Learn")],
>>>>>>> 6790bfe3dd6cf8acc9c2632cfb9e8cd202cbc4d8
                                ),
                              ),
                            ),
                            if (selectedActivities == index)
                              Positioned(
                                  right: 3,
                                  top: 3,
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("assets/imgs/check.png"),
                                  ))
                          ],
                        ));
                  },
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "Other Activities",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: GridView.builder(
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 30.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOtherActivities = index;
                            selectedActivities = null;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow:  [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                    offset: Offset(
                                      2.0, // Move to right 10  horizontally
                                      2.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
<<<<<<< HEAD
                                  children: [
                                    // Image.asset(
                                    //   "assets/imgs/book.png",
                                    //   width: 100,
                                    //   height: 100,
                                    // ),
                                    ImageIcon(
                                      AssetImage("assets/imgs/book.png"),
                                      color: Colors.grey,
                                      size: 68,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Learn")
                                  ],
=======
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Image.asset(                                  
                                    "assets/imgs/book.png",width: 50,height: 50,),
                                    SizedBox(height: 10,),
                                    Text("Learn")],
>>>>>>> 6790bfe3dd6cf8acc9c2632cfb9e8cd202cbc4d8
                                ),
                              ),
                            ),
                            if (selectedOtherActivities == index)
                              Positioned(
                                  right: 3,
                                  top: 3,
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("assets/imgs/check.png"),
                                  ))
                          ],
                        ));
                  },
                )),
          ),
          Center(
<<<<<<< HEAD
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Choose_Category()));
                  },
                  child: Text("Continue"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Strings.appThemecolor)),
                )),
          ),
          Center(
            child: SizedBox(
                //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
                // ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                )),
          )
=======
            child: Container(            
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Choose_Category()));
              }, child: Text("Continue"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Strings.appThemecolor)),)),
          ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
              // ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(onPressed: (){}, child: Text("Skip",style: TextStyle(color: Colors.black),),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),)),
            )
>>>>>>> 6790bfe3dd6cf8acc9c2632cfb9e8cd202cbc4d8
        ],
      ),
    );
  }
}
