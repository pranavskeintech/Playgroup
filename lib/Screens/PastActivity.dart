import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playgroup/Models/CommonReq.dart';
import 'package:playgroup/Models/GetMarkAvailabilityListRes.dart';
import 'package:playgroup/Models/PastActivitiesRes.dart';
import 'package:playgroup/Models/uploadPastActPhotos.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Comments.dart';
import 'package:playgroup/Screens/PastActivityDetailView.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:playgroup/Screens/PhotosView.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

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

  List<String>? imgList;

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imageFileList = [];

  List<String> listBase64Images = [];

  bool _isLoading2 = false;

  int? MID;

  int? CID;

  _GetPastAct() {
    //AppUtils.showprogress();
    int CID = Strings.SelectedChild;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.PastActivities(CID).then((response) {
      if (response.status == true) {
        setState(() {
          // AppUtils.dismissprogress();
          PastActData = response.data;
          // for (var i = 0; i < PastActData!.length; i++) {
          //   for (var j = 0; j < PastActData![i].images!.length; j++) {
          //     imgList!.add(Strings.imageUrl +
          //         "past_photos/" +
          //         PastActData![i].images![j].imageName!);
          //   }
          // }
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
  addLike(markavailId) {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    CommonReq req = CommonReq();
    req.childId = Strings.SelectedChild;
    req.markavailId = markavailId;

    print(jsonEncode(req));
    api.addLike(req).then((response) {
      if (response.status == true) {
        print("Like added successfully");
        _GetPastAct();
      
      } else {
        print("unable to add like");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
  unLike(markavailId) {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    
    api.unLike(Strings.SelectedChild,markavailId).then((response) {
      if (response.status == true) {
        print("Like deleted successfully");
        _GetPastAct();
      
      } else {
        print("unable to add dislike");
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
            : AnimationLimiter(
                child: ListView.builder(
                  itemCount: PastActData!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            color: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 8.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      2.0, // Move to right 10  horizontally
                                      2.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.fromLTRB(13, 2, 12, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    isThreeLine: true,
                                    contentPadding: EdgeInsets.all(0),
                                    leading:
                                        //  CircleAvatar(
                                        //   backgroundImage: AssetImage("assets/imgs/child.jpg"),
                                        // ),
                                        CircleAvatar(
                                      backgroundImage:
                                          (PastActData![index].profile! !=
                                                  "null")
                                              ? NetworkImage(Strings.imageUrl +
                                                  PastActData![index].profile!)
                                              : AssetImage(
                                                      "assets/imgs/appicon.png")
                                                  as ImageProvider,
                                    ),
                                    title: Text(PastActData![index].childName!),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  PastActData![index]
                                                          .fromTime! +
                                                      " - ",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  PastActData![index].toTime!,
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
                                        GestureDetector(
                                          onTap: (() {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Past_Activity_Details(
                                                            markavailId:
                                                                PastActData![
                                                                        index]
                                                                    .markavailId!,
                                                            childId:
                                                                PastActData![
                                                                        index]
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
                                  (PastActData![index].categoryName != null)
                                      ? Row(
                                          children: [
                                            Text(
                                              PastActData![index]
                                                      .categoryName! +
                                                  " - ",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              PastActData![index]
                                                  .activitiesName!,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          "Open to anything",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  (PastActData![index].images!.length != 0)
                                      ? GalleryImage(
                                          imageUrls: List.generate(
                                              PastActData![index]
                                                  .images!
                                                  .length,
                                              (i) =>
                                                  Strings.imageUrl +
                                                  "past_photos/" +
                                                  PastActData![index]
                                                      .images![i]
                                                      .imageName!,
                                              growable: false),
                                          titleGallery: "Playgroup",
                                        )
                                      : Container(
                                          //  padding: EdgeInsets.all(0),
                                          child: TextButton(
                                              onPressed: () {
                                                MID = PastActData![index]
                                                    .markavailId;
                                                CID = Strings.ChoosedChild;
                                                //PastActData![index].childId;
                                                _getFromGallery(MID, CID);
                                              },
                                              child: Text(
                                                  "Tap to Add photos for the activity",
                                                  style: TextStyle(
                                                      fontSize: 13)))),
                                  // Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 10, bottom: 10),
                                  //     child: Center(
                                  //       child: GestureDetector(
                                  //         onTap: () async {
                                  //           MID = PastActData![index]
                                  //               .markavailId;
                                  //           CID =
                                  //               PastActData![index].childId;
                                  //           await _getFromGallery();
                                  //           setState(() {
                                  //             _GetPastAct();
                                  //           });
                                  //         },
                                  //         child: Container(
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.rectangle,
                                  //               border: Border.all(
                                  //                 width: 5.3,
                                  //                 color:
                                  //                     Strings.appThemecolor,
                                  //               ),
                                  //               borderRadius:
                                  //                   BorderRadius.circular(
                                  //                       10)),
                                  //           padding: EdgeInsets.all(2),
                                  //           width: 240,
                                  //           height: 90,
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               // Icon(
                                  //               //   Icons
                                  //               //       .add_photo_alternate_outlined,
                                  //               //   size: 50,
                                  //               //   color:
                                  //               //       Strings.appThemecolor,
                                  //               // ),
                                  //               Text(
                                  //                 "Add photos for the activity",
                                  //                 style: TextStyle(
                                  //                     color: Strings
                                  //                         .appThemecolor),
                                  //                 textAlign:
                                  //                     TextAlign.center,
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
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
                                           if( PastActData![index].liked == 0)
                                           {
                                            addLike(PastActData![index].markavailId);

                                           }
                                           else
                                           {
                                            unLike(PastActData![index].markavailId);

                                           }
                                          },
                                          child: Image.asset(
                                            "assets/imgs/Like2.png",
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (() {}),
                                          child: Text("${PastActData![index].likeCount} likes",
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black87)),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: (){
                                        print(PastActData![index].markavailId);
                                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Comments(markAvailId: PastActData![index].markavailId,profile: PastActData![index].profile!,childName: PastActData![index].childName,categoryName: PastActData![index].categoryName,activityName: PastActData![index].activitiesName,)));
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/imgs/Comments.png",
                                            width: 60,
                                            height: 60,
                                          ),
                                          Text("${PastActData![index].commentCount} comments",
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black87)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/imgs/share3.png",
                                          width: 60,
                                          height: 60,
                                        ),
                                        // Text("3 share",
                                        //     style: TextStyle(
                                        //         fontSize: 8,
                                        //         color: Colors.black87)),
                                      ],
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                            "Participants(${PastActData![index].totalParticipants!})",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87)),
                                      ),
                                    )
                                  ]),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  _getFromGallery(MID, CID) async {
    final pickedFile = await _picker.pickMultiImage(imageQuality: 50);
    if (pickedFile!.isNotEmpty) {
      imageFileList!.addAll(pickedFile);
      // for (var file in imageFileList!) {
      //   List<int> imageBytes = File(file.path).readAsBytesSync();
      //   String base64Image = base64Encode(imageBytes);
      //   listBase64Images.add("data:image/jpeg;base64,${base64Image}");
      // }
      //showImages();
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              photosView(imageFileList: imageFileList, MID: MID, CID: CID)));
      setState(() {
        imageFileList = [];
        _GetPastAct();
      });
    }
    print("Image List Length:" + listBase64Images.toString());
    setState(() {});
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
