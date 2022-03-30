import 'package:flutter/material.dart';
import 'package:playgroup/Screens/ChooseTopic.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

import 'Availability-Choose_friends.dart';


class Choose_Category extends StatefulWidget 
{
  const Choose_Category({ Key? key }) : super(key: key);

  @override
  State<Choose_Category> createState() => _Choose_CategoryState();
}

class _Choose_CategoryState extends State<Choose_Category> {

int tag = 1;
List<String> options = [
  'News', 'Entertainment', 'Politics',
  'Automotive', 'Sports', 'Education',
  'Fashion', 'Travel', 'Food', 'Tech',
  'Science','Cricket','FoodBall','Hockey','Tennis','Kabbadi','Table Tennis',
];

  int? selectedIndex;


  @override
  Widget build(BuildContext context) 
  {
    return  Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_sharp,color: Colors.white,)),title: Text("Your Availability"),
      backgroundColor: Strings.appThemecolor,),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("What do you want to play?",style: TextStyle(fontWeight: FontWeight.bold),))),
            Container(
              height: 400,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: GridView.builder(
                  
                  itemCount: options.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 30/10,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  2.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          child: 
                          Container(
                            color:  selectedIndex != index? Colors.grey.withOpacity(0.2):Colors.green,
                            child: Center(child: Text(options[index],style: TextStyle(color: selectedIndex != index? Colors.black:Colors.white),),),
                          ),
                        ));
                  },
                )),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 0),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Availability_choose_friends()));
            }, child: Text("Continue"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Strings.appThemecolor)),)),
            Container(
            //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
            // ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(onPressed: (){}, child: Text("Skip",style: TextStyle(color: Colors.black),),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),))
          ],
        ),
      ),
    );
  }
}