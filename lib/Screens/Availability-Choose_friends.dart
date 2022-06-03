import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playgroup/Models/MarkAvailabilityReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

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

  TextEditingController searchController = TextEditingController();

  bool _switchValue = false;

  BuildContext? ctx;
  @override
  void initState() {
    // TODO: implement initState
    _isChecked = List<bool>.filled(_texts.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Strings.appThemecolor,
            title: Text("Your Availability"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp),
            ),
          ),
          // resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return MarkAvail(newContext);
          }),
        ));
  }

  MarkAvail(BuildContext context) {
    ctx = context;
    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose Friends to join you?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Strings.textFeildBg,
                  border: Border.all(color: Strings.textFeildBg),
                  borderRadius: BorderRadius.circular(10)),
              height: 40,
              child: TextField(
                enabled: true,
                controller: searchController,
                textInputAction: TextInputAction.search,
                textAlign: TextAlign.justify,
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Search",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Strings.textFeildBg),
                        borderRadius: BorderRadius.circular(6)),
                    filled: true,
                    fillColor: Strings.textFeildBg,
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Select all friends",
                  style: TextStyle(color: Colors.blue),
                ),
                Switch(
                  activeColor: Colors.blue,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                   
                    if (_switchValue == true) {
                      for (var index = 0; _isChecked!.length > index; index++) {
                        _isChecked![index] = true;
                      }
                    } else {
                      for (var index = 0; _isChecked!.length > index; index++) {
                        _isChecked![index] = false;
                      }
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                        ),
                        title: Text("Ramesh"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          width: 20,
                          height: 20,
                          child: Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.green,
                              activeColor: Colors.transparent,
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
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.8),
                      height: 1,
                    ),
                  ],
                );
              },
            )),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _MarkAvailability();
                    },
                    child: Text("Done",),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Strings.appThemecolor)),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      );
  }

  _MarkAvailability() {
    AppUtils.showprogress();


    MarkAvailabilityReq markavail = MarkAvailabilityReq();

    markavail.date = Strings.markAvailabiltydate;
    markavail.from = Strings.markAvailabiltystartTime;
    markavail.to = Strings.markAvailabiltyendTime;
    markavail.description = Strings.markAvailabiltydesc;
    markavail.location = Strings.markAvailabiltylocations;
    markavail.activitiesId = Strings.markAvailabiltyTopic;
    markavail.sportId = Strings.markAvailabiltycategory;
    markavail.childId = Strings.SelectedChild;
    
    var dat = jsonEncode(markavail);

    print(dat);
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.createAvailability(markavail).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
      } else {
        functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }
}
