import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playgroup/Models/GetAllActivities.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Own_Availability.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';

class availabilityList extends StatefulWidget {
  int? FID;
  availabilityList({Key? key, this.FID}) : super(key: key);

  @override
  State<availabilityList> createState() => _availabilityListState();
}

class _availabilityListState extends State<availabilityList> {
  List<ActData>? AllActivity;

  List<ActData>? _foundedActivity = [];

  BuildContext? ctx;

  bool _isLoading = true;

  var width;

  GetAllActivity() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetAllActivity(widget.FID!).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          AllActivity = response.data;
          setState(() {
            _foundedActivity = AllActivity!;
          });

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  onSearch3(String search) {
    print("Searching for $search");
    setState(() {
      _foundedActivity = AllActivity!
          .where((user) =>
              user.categoryName!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => GetAllActivity());
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
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            width: MediaQuery.of(context).size.width * 1.0,
            child: Column(
              children: [
                SizedBox(height: 20),
                _foundedActivity!.length > 0
                    ? Container(
                        decoration: BoxDecoration(
                            color: Strings.textFeildBg,
                            border: Border.all(color: Strings.textFeildBg),
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        child: TextField(
                          onChanged: (searchString) {
                            onSearch3(searchString);
                          },
                          enabled: true,
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
                      )
                    : Container(),
                SizedBox(height: 20),
                _foundedActivity!.length > 0
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: _foundedActivity!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Own_Availability(
                                                  markavailId:
                                                      _foundedActivity![index]
                                                          .markavailId,
                                                  fromAct: true,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          //                   <--- left side
                                          color: Colors.primaries[Random()
                                              .nextInt(
                                                  Colors.primaries.length)],
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4,
                                            offset:
                                                Offset(1, 1), // Shadow position
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              _foundedActivity![index]
                                                      .categoryName! +
                                                  " - ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(
                                              width: 70,
                                              child: Text(
                                                _foundedActivity![index]
                                                    .activitiesName!,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Container(
                                          width: 150,
                                          child: Row(
                                            children: [
                                              Text(
                                                _foundedActivity![index]
                                                    .dateon!,
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: 1,
                                                height: 10,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _foundedActivity![index]
                                                            .fromTime!
                                                            .replaceAll(
                                                                ' PM', '')
                                                            .replaceAll(
                                                                ' AM', '') +
                                                        " - ",
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    _foundedActivity![index]
                                                        .toTime!,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        isThreeLine: false,
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              _foundedActivity![index]
                                                  .location!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      )
                    : Spacer()
              ],
            ),
          );
  }
}
