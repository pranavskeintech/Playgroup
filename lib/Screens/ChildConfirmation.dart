import 'package:flutter/material.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChooseChild.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/Strings.dart';

class ChildConfirmation extends StatefulWidget {
  const ChildConfirmation({Key? key}) : super(key: key);

  @override
  State<ChildConfirmation> createState() => _ChildConfirmationState();
}

class _ChildConfirmationState extends State<ChildConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile info"),
        backgroundColor: Strings.appThemecolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          tooltip: 'back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                  "Child Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context,int index)
        {
          return Card(
            elevation: 5,
            shadowColor: Colors.grey.withOpacity(0.2),
                  color: Color.fromRGBO(248, 248, 248, 1),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [                       
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset("assets/imgs/edit2.png",
                          fit: BoxFit.fill,
                          width: 18,
                          height: 18,),),
                        // SizedBox(
                        //   height: 10,
                        // ),
                       const CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/imgs/child.jpg'),
                        ),
                      const SizedBox(height: 10,),
                      const Text(
                              "Alex Timo Dissusa",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DOB",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("12-03-2022",style: TextStyle(fontWeight: FontWeight.w500),)
                                ],
                              ),
                              // SizedBox(
                              //   width: 20,
                              // ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey,
                              ),
                              // SizedBox(
                              //   width: 20,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Gender",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("Male",style: TextStyle(fontWeight: FontWeight.w500),)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
                // Container(
                //   margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                //   child: Text(
                //     "Parents Details",
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Jhon Alex",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(
                //         height: 3,
                //       ),
                //       Text(
                //         "Jhonalex34@gmail.com",
                //         style: TextStyle(color: Colors.grey),
                //       )
                //     ],
                //   ),
                // ),
        }),
              )],
          ),
        ),
        Positioned(
            left: 20,
            right: 20,
            bottom: 50,
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Strings.appThemecolor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseChild(),
                            ),
                          );                       
                        },
                        child: Text("Next")),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.grey.withOpacity(0.2))))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChildDetails()));
                        },
                        child: Text(
                          "Add Another Child",
                          style: TextStyle(color: Colors.black),
                        )),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
