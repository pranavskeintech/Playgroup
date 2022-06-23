import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:playgroup/Models/EditChildReq.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class EditLangKnwn extends StatefulWidget {
  const EditLangKnwn({Key? key}) : super(key: key);

  @override
  State<EditLangKnwn> createState() => _EditLangKnwnState();
}

class _EditLangKnwnState extends State<EditLangKnwn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> Languages = [
    "English",
    "Hindi",
    "Tamil",
    "Urdu",
    "Malayalam",
    "Bengali",
    "Kannada",
    "Telugu",
    "Gujarati",
    "Nepali",
    "Punjabi"
  ];
  List<bool> _tick = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> _selectedvalues = [];

  BuildContext? ctx;

  List<Data>? _ChildData;

  bool _isLoading = true;

  _GetChildData() {
    //int? PId = Strings.Parent_Id;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetChild().then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          _ChildData = response.data;
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetChildData());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return EditLanguages(newContext);
          }),
        ));
  }

  EditLanguages(BuildContext context) {
    ctx = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Transform(
          transform: Matrix4.translationValues(-10.0, 0, 0),
          child: Text(
            "Edit Languages Known",
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
          ),
        ),
        leading: Transform(
          transform: Matrix4.translationValues(8.0, 0, 0),
          child: IconButton(
              onPressed: () {
                // _scaffoldKey.currentState?.openDrawer();
                Navigator.pop(context);
              },
              icon: Icon(
                // AssetImage("assets/imgs/menu_ver2.png"),
                Icons.arrow_back,
                size: 32,
                color: Colors.white,
              )),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(14, 100, 14, 0),
              child: Wrap(
                spacing: 18.0,
                direction: Axis.horizontal,
                children: List<Widget>.generate(Languages.length, (int index) {
                  return GestureDetector(
                    onTap: () {
                      _selectedvalues.add(Languages[index]);
                      print("Lang:$_selectedvalues");

                      setState(() {
                        _tick[index] = !_tick[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Chip(
                        label: Container(
                          width: 80,
                          child: Center(
                            child: Text(Languages[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: _tick[index]
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                        backgroundColor:
                            _tick[index] ? Colors.green : Colors.grey.shade200,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < 12; i++) {
                        if (_tick[i] == true) {
                          // print(activities[i]);
                          _selectedvalues.add(Languages[i]);
                          _EditChild();
                          print(_selectedvalues);
                          _selectedvalues[i] = Languages[i];
                        } else {
                          // _selectedvalues[i] = "null";
                          continue;
                        }
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Strings.appThemecolor)),
                  )),
            ),
          )
        ],
      ),
    );
  }

  _EditChild() {
    EditChildReq ChildEdit = EditChildReq();
    ChildEdit.childId = _ChildData![Strings.editIndex].childId;
    //ChildEdit.parentId = Strings.Parent_Id.toString();
    ChildEdit.childName = _ChildData![Strings.editIndex].childName;
    ChildEdit.dob = _ChildData![Strings.editIndex].dob;
    ChildEdit.gender = _ChildData![Strings.editIndex].gender;
    ChildEdit.school = _ChildData![Strings.editIndex].school;
    ChildEdit.profile = _ChildData![Strings.editIndex].profile;
    ChildEdit.language = _selectedvalues;
    print(jsonEncode(ChildEdit));
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.EditChild(ChildEdit).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.pop(context);
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
