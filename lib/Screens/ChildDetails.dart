import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:playgroup/Models/AddChildReq.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Screens/ChildConfirmation.dart';
import 'package:playgroup/Screens/Login.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Network/ApiService.dart';
import '../Utilities/AppUtlis.dart';
import '../Utilities/Strings.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChildDetails extends StatefulWidget {
  const ChildDetails({Key? key}) : super(key: key);

  @override
  State<ChildDetails> createState() => _ChildDetailsState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ChildDetailsState extends State<ChildDetails> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();

  final _btnController = RoundedLoadingButtonController();
  late AppState state;

  String? selectedValue;
  List<String> items = [
    'Male',
    'Female',
    'Prefer Not to say',
  ];
  final ImagePicker _picker = ImagePicker();

  File? _imageFile;

  var ctx;

  String img64 = "";

  var profilepage;

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),

      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String date1 = "${picked.day}-${picked.month}-${picked.year}";
        _dobController.text = date1;
        print("date selected");
      });
    }
  }

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
        print("img64" + img64);
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return AddChildpage(newContext);
          }),
        ));
  }

  AddChildpage(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (Strings.profilepage == true) {
            Navigator.pop(context);

            Strings.profilepage = false;
            throw '';
          } else if (Strings.DashboardPage == true) {
            Navigator.pop(context);
            Strings.DashboardPage = false;
            throw '';
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));
            throw '';
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                    },
                    child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_back_sharp)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    "Child Details",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 10),
                  Stack(children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      backgroundColor: Colors.transparent,
                      child: _imageFile == null
                          ? Image.asset("assets/imgs/appicon.png")
                          : SizedBox(),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            openGallery();
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/imgs/camera.png")),
                        ))
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.050,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "Child's Name",
                          style: TextStyle(
                            fontSize: 15,
                            color: Strings.textFeildHeading,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Strings.textFeildBg,
                        //border: Border.all(color: const Color(0xFFf2f3f4)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Strings.textFeildBg, width: 0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Strings.textFeildBg, width: 0.0),
                              ),
                              fillColor: Strings.textFeildBg,
                              filled: true,
                              hintText: "Enter Child Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "DOB",
                          style: TextStyle(
                            fontSize: 15,
                            color: Strings.textFeildHeading,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectDate();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              enabled: false,
                              style: TextStyle(color: Colors.black),
                              controller: _dobController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Strings.textFeildBg, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Strings.textFeildBg, width: 1),
                                ),
                                fillColor: Strings.textFeildBg,
                                filled: true,
                                hintText: "Select DOB",
                                suffixIcon: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 0, 0),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 15,
                            color: Strings.textFeildHeading,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Select Gender',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      // iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: MediaQuery.of(context).size.width * 0.9,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Strings.textFeildBg,
                      ),
                      buttonElevation: 0,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 300,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(0, 0),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RoundedLoadingButton(
                      animateOnTap: false,
                      resetDuration: const Duration(seconds: 10),
                      resetAfterDuration: true,
                      successColor: const Color.fromRGBO(94, 37, 108, 1),
                      width: 500,
                      borderRadius: 5,
                      color: Strings.appThemecolor,
                      child: const Text('Continue',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      controller: _btnController,
                      onPressed: () {
                        if (_nameController.text.length < 3) {
                          AppUtils.showError(context,
                              "Child name should be minimum 3 characters", "");
                        } else if (_dobController.text.isEmpty) {
                          AppUtils.showError(
                              context, "Please select child DOB", "");
                        } else if (selectedValue == null) {
                          AppUtils.showError(
                              context, "Please select gender", "");
                        } else {
                          AppUtils.showprogress();
                          checkChild();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _AddChild() {
    AddChildReq ChildReg = AddChildReq();
    ChildReg.parentId = Strings.Parent_Id.toString();
    ChildReg.childName = _nameController.text;
    ChildReg.dob = _dobController.text;
    ChildReg.gender = selectedValue;

    if (img64 != "") {
      ChildReg.profile = "data:image/jpeg;base64,$img64";
    } else {
      ChildReg.profile = "null";
    }
    print(jsonEncode(ChildReg));
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.AddChild(ChildReg).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");
      if (response.status == true) {
        AppUtils.dismissprogress();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ChildConfirmation()));
        print("result2:$response");
      } else {
        AppUtils.dismissprogress();
        functions.createSnackBar(context, response.message.toString());
        _btnController.stop();
        print("error");
      }
    });
  }

  checkChild() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.Checkchild(_nameController.text, Strings.Parent_Id).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");
      if (response.status == true) {
        _AddChild();
      } else {
        AppUtils.dismissprogress();
        // functions.createSnackBar(context, response.message.toString());
        AppUtils.showError(context, "Child already exists", "");
        _btnController.stop();
        print("error");
      }
    });
  }
}
