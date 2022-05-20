import 'package:flutter/material.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/Strings.dart';

class Availability_choose_friends extends StatefulWidget {
  const Availability_choose_friends({Key? key}) : super(key: key);

  @override
  State<Availability_choose_friends> createState() =>
      _Availability_choose_friendsState();
}

class _Availability_choose_friendsState
    extends State<Availability_choose_friends> {
  List<bool> values = [];

  final List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<bool>? _isChecked;
  @override
  void initState() {
    // TODO: implement initState
    _isChecked = List<bool>.filled(_texts.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
        title: Text("Your Availability"),
        backgroundColor: Strings.appThemecolor,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose Friends to join you?",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Container(
              
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3)
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              height: 40,
              child: TextField(
                enabled: true,
                textAlign: TextAlign.justify,
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    filled: true,
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                      ),
                      title: Text("Ramesh"),
                      trailing: Checkbox(
                        value: _isChecked?[index],
                        onChanged: (val) {
                          setState(
                            () {
                              _isChecked?[index] = val!;
                            },
                          );
                        },
                      ),
                    ),
                  Divider(color: Colors.grey.withOpacity(0.8),height: 1,),
                  
                  ],
                );
              },
            )),
             Center(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 0),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DashBoard()));
              }, child: Text("Continue"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Strings.appThemecolor)),)),
          ),
            Center(
              child: SizedBox(
              //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
              // ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(onPressed: (){}, child: Text("Skip",style: TextStyle(color: Colors.black),),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),)),
            )
          ],
        ),
      ),
    );
  }
}
