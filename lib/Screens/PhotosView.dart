import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:playgroup/Models/getPastActPhotos.dart';
import 'package:playgroup/Models/uploadPastActPhotos.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class photosView extends StatefulWidget {
  List<XFile>? imageFileList;
  int? MID;
  int? CID;
  photosView({Key? key, this.imageFileList, this.MID, this.CID})
      : super(key: key);

  @override
  State<photosView> createState() => _photosViewState();
}

class _photosViewState extends State<photosView> {
  final ImagePicker _picker = ImagePicker();

  List<String> listBase64Images = [];

  BuildContext? ctx;
  final _btnController = RoundedLoadingButtonController();

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
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Photos'),
          backgroundColor: Strings.appThemecolor,
          actions: [
            TextButton(
                onPressed: () {
                  selectImages();
                },
                child: Row(
                  children: [
                    Text(
                      "Add More",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.add_photo_alternate_outlined,
                        size: 15, color: Colors.white)
                  ],
                )),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.imageFileList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.5 / 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          fit: StackFit.passthrough,
                          children: [
                            GestureDetector(
                              onTap: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => picView(
                                        imageFileList: widget.imageFileList,
                                        CurrentPosition: index)));
                              }),
                              child: Image.file(
                                File(widget.imageFileList![index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 3,
                              right: 3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print(
                                        "hiii:${widget.imageFileList!.length}");
                                    widget.imageFileList!.removeAt(index);
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.yellow.shade700,
                                            Colors.orange.shade600
                                          ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Icon(
                                    Icons.clear,
                                    size: 17,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                        //return Text("data");
                      }),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width * 0.9,
                child: RoundedLoadingButton(
                  animateOnTap: false,
                  resetDuration: const Duration(seconds: 10),
                  resetAfterDuration: true,
                  successColor: const Color.fromRGBO(94, 37, 108, 1),
                  width: 500,
                  borderRadius: 5,
                  color: Strings.appThemecolor,
                  child: const Text('Upload',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  controller: _btnController,
                  onPressed: () {
                    if (widget.imageFileList!.length == 0) {
                      AppUtils.showError(context, "No photos selected", "");
                    } else {
                      AppUtils.showprogress();
                      uploadPastActImgs();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void selectImages() async {
    final List<XFile>? selectedImages =
        await _picker.pickMultiImage(imageQuality: 50);
    if (selectedImages!.isNotEmpty) {
      setState(() {
        widget.imageFileList!.addAll(selectedImages);
      });
    }
    setState(() {});
    print("Image List Length:" + widget.imageFileList!.length.toString());
  }

  uploadPastActImgs() {
    uploadPastActPhotos ImgDetails = uploadPastActPhotos();
    ImgDetails.childId = widget.CID;
    ImgDetails.markavailId = widget.MID;
    if (widget.imageFileList!.length == 0) {
      ImgDetails.image = [];
    } else {
      // ImgDetails.image = ["data:image/jpeg;base64,${listBase64Images}"];
      for (var file in widget.imageFileList!) {
        List<int> imageBytes = File(file.path).readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        listBase64Images.add("data:image/jpeg;base64,${base64Image}");
      }
      ImgDetails.image = listBase64Images;
    }
    print("object:${jsonEncode(ImgDetails)}");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.uploadPastActPhoto(ImgDetails).then((response) {
      if (response.status == true) {
        setState(() {
          AppUtils.dismissprogress();
          Navigator.pop(context);
        });
      } else {
        functions.createSnackBar(context, response.message.toString());
        _btnController.stop();
        print("error");
      }
    });
  }
}

class picView extends StatefulWidget {
  List<XFile>? imageFileList;
  int? CurrentPosition;
  picView({Key? key, this.imageFileList, this.CurrentPosition})
      : super(key: key);

  @override
  State<picView> createState() => _picViewState();
}

class _picViewState extends State<picView> {
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  // final _controller = PageController();
  // int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Icon(Icons.clear, size: 35, color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 1,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: PageController(
                    initialPage: widget.CurrentPosition!,
                    keepPage: true,
                    viewportFraction: 1),
                itemCount: widget.imageFileList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Spacer(flex: 1),

                      Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Image.file(
                          File(widget.imageFileList![index].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Spacer(
                      //   flex: 2,
                      // ),
                      //Spacer(),
                    ],
                  );
                },
                //onPageChanged: (value) => setState(() => _currentPage = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class picsFromGallery extends StatefulWidget {
  List<imgData>? PastActPhotos;
  int? currentPage;
  picsFromGallery({Key? key, this.PastActPhotos, this.currentPage})
      : super(key: key);

  @override
  State<picsFromGallery> createState() => _picsFromGalleryState();
}

class _picsFromGalleryState extends State<picsFromGallery> {
  //final _controller = PageController();
  //int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Icon(Icons.clear, size: 35, color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 1,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: PageController(
                    initialPage: widget.currentPage!,
                    keepPage: true,
                    viewportFraction: 1),
                itemCount: widget.PastActPhotos!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Spacer(flex: 1),

                      Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Image.network(
                          Strings.imageUrl +
                              "past_photos/" +
                              (widget.PastActPhotos![index].imageName ?? ""),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.softLight,
                        ),
                      ),
                      // Spacer(
                      //   flex: 2,
                      // ),
                      //Spacer(),
                    ],
                  );
                },
                //onPageChanged: (value) => setState(() => _currentPage = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
