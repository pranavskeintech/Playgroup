import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playgroup/Models/GetMarkAvailabilityListRes.dart';
import 'package:playgroup/Models/PastActivitiesRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/PastActivityDetailView.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';

class PastActivity extends StatefulWidget {
  const PastActivity({Key? key}) : super(key: key);

  @override
  State<PastActivity> createState() => _PastActivityState();
}

class _PastActivityState extends State<PastActivity> {
  List<String> childImgs = [
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300"
  ];

  bool isHighlighted = true;

  BuildContext? ctx;

  bool _ShowNoData = false;

  List<Data>? PastActData;

  bool _isLoading = true;

  bool _showNoPastAct = false;

  _GetPastAct() {
    //AppUtils.showprogress();
    int CID = Strings.SelectedChild;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.PastActivities(CID).then((response) {
      if (response.status == true) {
        setState(() {
          // AppUtils.dismissprogress();
          PastActData = response.data;
          _isLoading = false;
          print(jsonEncode(PastActData));
          // if (PastActData != null) {
          //   _ShowNoData = false;
          // }
        });
      } else {
        setState(() {
          _ShowNoData = true;
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetPastAct());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return PastActivity(newContext);
          }),
        ));
  }

  PastActivity(BuildContext context) {
    ctx = context;
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)));
    }
    return Container(
      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: _ShowNoData
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Invite Friends",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Invite your Friends to the Playgroup App.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          SocialShare.shareOptions(
                                  "Hey I found an new app Named Playgroup, Install With my link https://play.google.com/store/apps/details?id=com.netflix.mediaclient")
                              .then((data) {
                            print(data);
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/imgs/add-user.png",
                                width: 15,
                                height: 15,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Invite Friends")
                            ])),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "No Availabilities",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.1),
                      child: Container(
                        height: 140,
                        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "There are no friend's availabilities please add friends and view their availabilities",
                                style: TextStyle(
                                    color: Strings.textFeildHeading,
                                    fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  "Add your friends and share with your availabilities",
                                  style: TextStyle(
                                      color: Strings.textFeildHeading)),
                            ]),
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: PastActData!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 10  horizontally
                            2.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          isThreeLine: true,
                          leading:
                              //  CircleAvatar(
                              //   backgroundImage: AssetImage("assets/imgs/child.jpg"),
                              // ),
                              CircleAvatar(
                            backgroundImage:
                                (PastActData![index].profile! != "null")
                                    ? NetworkImage(Strings.imageUrl +
                                        PastActData![index].profile!)
                                    : AssetImage("assets/imgs/appicon.png")
                                        as ImageProvider,
                          ),
                          title: Text(PastActData![index].childName!),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    PastActData![index].dateon!,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 1,
                                    height: 10,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        PastActData![index].fromTime! + " - ",
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        PastActData![index].toTime!,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Past_Activity_Details(
                                              markavailId: PastActData![index]
                                                  .markavailId!,
                                              childId: PastActData![index]
                                                  .childId!)));
                                }),
                                child: Text(
                                  "See More",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                                  //overflow: TextOverflow.fade,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              PastActData![index].categoryName! + " - ",
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              PastActData![index].activitiesName!,
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GalleryImage(
                          imageUrls: childImgs,
                          titleGallery: "Playgroup",
                        ),
                        Row(children: [
                          Column(
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onHighlightChanged: (value) {
                                  setState(() {
                                    isHighlighted = !isHighlighted;
                                  });
                                },
                                onTap: () {
                                  setState(() {});
                                },
                                child: Image.asset(
                                  "assets/imgs/Like2.png",
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {}),
                                child: Text("5 likes",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.black87)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/imgs/Comments.png",
                                width: 60,
                                height: 60,
                              ),
                              Text("3 comments",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black87)),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/imgs/share3.png",
                                width: 60,
                                height: 60,
                              ),
                              Text("3 share",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black87)),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                  "Participants(${PastActData![index].totalParticipants!})",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black87)),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  PhotoGrid(
      {required this.imageUrls,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      Key? key})
      : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.15,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child:
                // Image.asset('assets/imgs/${imageUrl[index]}'),
                Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}
