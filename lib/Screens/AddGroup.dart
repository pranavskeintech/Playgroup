import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playgroup/Models/CreateGroupReq.dart';
import 'package:playgroup/Models/updateGroupReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/ChildProfile.dart';
import 'package:playgroup/Screens/GroupInfo.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddGroup extends StatefulWidget {
  final List<int>? friendsId;
  final bool? FromGroupInfo;
  final int? groupId;
  final String? GroupName;
  final String? Groupimg;
  final int? ChoosedChildId;
  AddGroup(
      {Key? key,
      this.friendsId,
      this.FromGroupInfo,
      this.groupId,
      this.GroupName,
      this.Groupimg,
      this.ChoosedChildId})
      : super(key: key);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _AddGroupState extends State<AddGroup> {
  final TextEditingController GroupNameController = TextEditingController();

  BuildContext? ctx;

  final ImagePicker _picker = ImagePicker();

  File? _imageFile;

  String img64 = "";

  openGallery() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile?.path != null) {
      setState(() {
        print("Img selected");
        _imageFile = croppedFile;
        final bytes = File(_imageFile!.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        widget.Groupimg == "null";
        print("img64" + img64);
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    if (widget.FromGroupInfo == true) {
      GroupNameController.text = widget.GroupName!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return CreateGroup(newContext);
          }),
        ));
  }

  CreateGroup(BuildContext context) {
    ctx = context;
    print("groupimg:${widget.Groupimg}");
    print("imgfile:${_imageFile}");
    return Scaffold(
      appBar: AppBar(
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: !widget.FromGroupInfo!
            ? Text(
                "Add Group",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            : Text(
                "Edit Group",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImageIcon(
              AssetImage("assets/imgs/back arrow.png"),
              color: Colors.white,
            )),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                openGallery();
              },
              child: Container(
                height: 150,
                width: 150,
                child: (_imageFile != null)
                    ? CircleAvatar(
                        radius: 40.0,
                        backgroundImage:
                            FileImage(_imageFile!) as ImageProvider,
                        backgroundColor: Colors.transparent,
                      )
                    : (widget.Groupimg == "null")
                        ? ClipOval(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black12,
                                  size: 60,
                                ),
                                Text(
                                  "Add Group Icon",
                                  style: TextStyle(color: Colors.black12),
                                )
                              ],
                            ),
                          )
                        : CircleAvatar(
                            radius: 40.0,
                            backgroundImage: NetworkImage(
                                Strings.imageUrl + (widget.Groupimg ?? "")),
                            backgroundColor: Colors.transparent,
                          ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Group Name",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 42,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(color: const Color(0xFFf2f3f4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: GroupNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 235, 235, 235),
                              width: 0.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 235, 235, 235),
                              width: 0.0),
                        ),
                        fillColor: Color.fromARGB(255, 235, 235, 235),
                        filled: true,
                        hintText: "Enter Group Name",
                        contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 40,
              width: 150,
              child: !widget.FromGroupInfo!
                  ? ElevatedButton(
                      onPressed: () {
                        if (GroupNameController.text.isNotEmpty) {
                          print("text:${GroupNameController.text}");
                          createGrp();
                        } else {
                          AppUtils.showToast("Please add a group name", ctx);
                        }
                      },
                      child: Text(
                        "Add Group+",
                        style: TextStyle(fontSize: 14),
                      ))
                  : ElevatedButton(
                      onPressed: () {
                        if (GroupNameController.text.isNotEmpty) {
                          print("text:${GroupNameController.text}");
                          EditGroup();
                        } else {
                          AppUtils.showToast("Please add a group name", ctx);
                        }
                      },
                      child: Text(
                        "Edit Group",
                        style: TextStyle(fontSize: 14),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  createGrp() {
    CreateGroupReq GroupInfo = CreateGroupReq();
    GroupInfo.groupName = GroupNameController.text;
    GroupInfo.groupMembers = widget.friendsId;
    if (img64 == "") {
      GroupInfo.groupImage = "null";
    } else {
      GroupInfo.groupImage = "data:image/jpeg;base64,$img64";
    }
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.CreateGroup(GroupInfo, widget.ChoosedChildId!).then((response) {
      if (response.status == true) {
        int GroupId = response.groupDetails!.insertId!.toInt();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Groupinfo(
                groupId: GroupId, choosedChildId: widget.ChoosedChildId,fromChat: false,)));
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }

  EditGroup() {
    updateGroupReq editGroup = updateGroupReq();
    editGroup.groupName = GroupNameController.text;

    if (img64 == "") {
      editGroup.groupImage = widget.Groupimg;
    } else {
      editGroup.groupImage = "data:image/jpeg;base64,$img64";
    }
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.updateGroup(editGroup, widget.groupId!).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.pop(context);
        functions.createSnackBarGreen(context, response.message.toString());
      } else {
        functions.createSnackBar(context, response.message.toString());
        print("error");
      }
    });
  }
}
