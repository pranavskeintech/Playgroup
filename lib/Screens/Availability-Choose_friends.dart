import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';


class Availability_choose_friends extends StatefulWidget {
  const Availability_choose_friends({ Key? key }) : super(key: key);

  @override
  State<Availability_choose_friends> createState() => _Availability_choose_friendsState();
}

class _Availability_choose_friendsState extends State<Availability_choose_friends> 
{
   List<bool> values = [];

    List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<bool>? _isChecked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_sharp,color: Colors.white,)),title: Text("Your Availability"),
      backgroundColor: Strings.appThemecolor,),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Choose Friends to join you?"),),
              SizedBox(height: 10),
              TextField(
                  enabled: false,
                  style: TextStyle(height: 1),
                  decoration: InputDecoration(
                      hintText: "Search",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: .0),
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      prefixIcon: Icon(Icons.search)),
                ),
                SizedBox(height: 10,),
                Expanded(child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                  return Container(
                    child: CheckboxListTile(
          title: Text(_texts[index]),
          value: _isChecked?[index] ?? true ,
          onChanged: (val) {
            setState(
              () {
                _isChecked?[index] = val!;
              },
            );
          },
        )
                  );
                },))
          ],
        ),
      ),
      
    );
  }
}