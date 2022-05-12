import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';

class ChooseTopic extends StatefulWidget {
  const ChooseTopic({Key? key}) : super(key: key);

  @override
  State<ChooseTopic> createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  int? selectedindex;

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text("Top Activities",style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedindex = index;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
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
                                  children: [Image.asset(
                                    "assets/imgs/book.png",width: 100,height: 100,),
                                    SizedBox(height: 10,),
                                    Text("Learn")],
                                ),
                              ),
                            ),
                            if (selectedindex == index)
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
            child: Text("Other Activities",style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: GridView.builder(
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedindex = index;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
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
                                  children: [Image.asset(
                                    
                                    "assets/imgs/book.png",width: 100,height: 100,),
                                    SizedBox(height: 10,),
                                    Text("Learn")],
                                ),
                              ),
                            ),
                            if (selectedindex == index)
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
        ],
      ),
    );
  }
}
