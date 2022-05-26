import 'package:flutter/material.dart';
import 'package:playgroup/Models/ChooseChildReq.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Screens/ChildConfirmation.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:playgroup/Utilities/Functions.dart';

import '../Network/ApiService.dart';

class ChooseChild extends StatefulWidget {
  const ChooseChild({Key? key}) : super(key: key);

  @override
  State<ChooseChild> createState() => _ChooseChildState();
}

class _ChooseChildState extends State<ChooseChild> {
  List<String> ChildName = [
    "Alex Timo",
    "Christina Timo",
    "George Timo",
    "Mariya Timo",
    "Angel Timo"
  ];
  var ctx;
  List<ChildData>? _ChildData;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetChild());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Strings.appThemecolor,
            title: Text("Select Child"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return ChooseChild(newContext);
          }),
        ));
  }

  ChooseChild(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  "Choose Child",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Choose a child to view the child's activities, friends, availability",
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      itemCount: _ChildData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          height: 60,
                          child: InkWell(
                            onTap: () {
                              AppUtils.showprogress();
                              var ChildId = _ChildData![index].childId ?? "";
                              _ChooseChild(ChildId);
                            },
                            child: Card(
                              shadowColor: Colors.grey.withOpacity(0.1),
                              child: Center(
                                  child:
                                      Text(_ChildData![index].childName ?? "")),
                              elevation: 8,
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
  }

  _ChooseChild(ChildId) {
    //var Pid = Strings.Parent_Id.toInt();
    ChooseChildReq ChooseChild = ChooseChildReq();
    ChooseChild.selectedChildId = ChildId;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.ChooseChild(ChooseChild).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashBoard()));
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        print("error");
      }
    });
  }

  _GetChild() {
    // var PId = Strings.Parent_Id.toInt();
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetChild().then((response) {
      print(response.status);
      if (response.status == true) {
        //_btnController.stop();
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
        _ChildData = response.data;
        setState(() {
          _isLoading = false;
        });
        print("data: ${_ChildData!.length.toString()}");
      } else {
        functions.createSnackBar(context, response.status.toString());
        // _btnController.stop();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
