import 'package:flutter/material.dart';
import 'package:playgroup/Screens/ChildConfirmation.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/Strings.dart';


class ChooseChild extends StatefulWidget {
  const ChooseChild({ Key? key }) : super(key: key);

  @override
  State<ChooseChild> createState() => _ChooseChildState();
}

class _ChooseChildState extends State<ChooseChild> 
{

  List<String> ChildName = ["Alex Timo","Christina Timo","George Timo","Mariya Timo","Angel Timo"];
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Select Child"),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_sharp),
      ),
    ),
    body: Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          Text("Choose Child",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          SizedBox(height: 20,),
          Text("Choose a child to view the child's activities, friends, availability",style: TextStyle(color: Colors.grey),),
           Expanded(
             flex: 2,
             child: ListView.builder(
                   itemCount: ChildName.length,
                   itemBuilder: (BuildContext context,int index){
                     return Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 60,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
                },
                child: Card(
                  shadowColor: Colors.grey.withOpacity(0.1),
                  child: Center(child: Text(ChildName[index])),
                elevation: 8,),
              ),
                     );
                     }),
           )
        ],
      ),
    ),);
  }
}