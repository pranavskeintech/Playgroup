import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Models/AddChildReq.dart';
import 'package:playgroup/Models/EditChildReq.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Screens/ChildConfirmation.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Network/ApiService.dart';
import '../Utilities/Strings.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditChildDetails extends StatefulWidget {
  EditChildDetails({Key? key}) : super(key: key);

  @override
  State<EditChildDetails> createState() => _EditChildDetailsState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EditChildDetailsState extends State<EditChildDetails> {
  final _numberController = TextEditingController();
  final _dobController = TextEditingController();
  final _schoolController = TextEditingController();

  List<childData>? _ChildData;

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

  bool _isLoading = true;
  DateTime now = DateTime.now();

  DateTime? picked;
  _selectDate() async {
    picked = await showDatePicker(
      context: context,
      initialDate: (picked! != null)
          ? DateTime(now.year - 4, now.month, now.day)
          : DateTime(now.year - 4, now.month, now.day), // Refer step 1
      firstDate: DateTime(now.year - 18, now.month, now.day),

      lastDate: DateTime(now.year - 4, now.month, now.day),
    );
    if (picked != null) {
      setState(() {
        String date1 = "${picked!.day}-${picked!.month}-${picked!.year}";
        _dobController.text = date1;
        print("date selected");
      });
    }
  }

//   if (DateTime.now().difference(date) < Duration(days: 6570)) {
// EasyLoading.showError('You should be 18 years old to register');}
// else {
// store.changeBirthday(date);}

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

  _GetChildData() {
    //int? PId = Strings.Parent_Id;
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetChild().then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          _ChildData = response.data;
          _isLoading = false;
          _numberController.text =
              _ChildData![Strings.editIndex].childName.toString();
          _dobController.text = _ChildData![Strings.editIndex].dob.toString();
          _schoolController.text = _ChildData![Strings.editIndex].school ?? "";
          selectedValue = _ChildData![Strings.editIndex].gender;
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
            return EditChildpage(newContext);
          }),
        ));
  }

  EditChildpage(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.arrow_back_sharp)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        "Edit Child Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(height: 10),
                      Stack(children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          backgroundImage: (_imageFile == null &&
                                  _ChildData![Strings.editIndex].profile !=
                                      "null")
                              ? NetworkImage(Strings.imageUrl +
                                  (_ChildData![Strings.editIndex].profile ??
                                      ""))
                              : _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : AssetImage("assets/imgs/profile-user.png")
                                      as ImageProvider,
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                style: TextStyle(color: Colors.black),
                                controller: _numberController,
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
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 5, 0, 0),
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
                            children: [
                              Expanded(
                                child: Text(
                                  _ChildData![Strings.editIndex].gender ?? "",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
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
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Strings.textFeildBg,
                          ),
                          buttonElevation: 0,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
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
                      SizedBox(height: 32),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "School Name",
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                ],
                                style: TextStyle(color: Colors.black),
                                controller: _schoolController,
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
                                  hintText: "Enter School Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 5, 0, 0),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
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
                          child: const Text('Save',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          controller: _btnController,
                          onPressed: () {
                            if (_numberController.text.length < 3) {
                              AppUtils.showError(
                                  context,
                                  "Child name should be minimum 3 characters",
                                  "");
                            } else if (_dobController.text.isEmpty) {
                              AppUtils.showError(
                                  context, "Please select child DOB", "");
                            } else if (selectedValue == null) {
                              AppUtils.showError(
                                  context, "Please select gender", "");
                            } else {
                              AppUtils.showprogress();
                              // checkChild();
                              if (_numberController.text ==
                                  _ChildData![Strings.editIndex].childName) {
                                _EditChild();
                              } else {
                                checkChild();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _EditChild() {
    EditChildReq ChildEdit = EditChildReq();
    ChildEdit.childId = _ChildData![Strings.editIndex].childId;
    //ChildEdit.parentId = Strings.Parent_Id.toString();
    ChildEdit.childName = _numberController.text;
    ChildEdit.dob = _dobController.text;
    ChildEdit.gender = selectedValue;
    ChildEdit.school = _schoolController.text;
    if (img64 == "") {
      ChildEdit.profile = _ChildData![Strings.editIndex].profile;
    } else {
      ChildEdit.profile = "data:image/jpeg;base64,$img64";
    }
    print(jsonEncode(ChildEdit));
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.EditChild(ChildEdit).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => ChildConfirmation()));
        Navigator.pop(context);
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        _btnController.stop();
        print("error");
      }
    });
  }

  checkChild() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.Checkchild(_numberController.text, Strings.Parent_Id).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");
      if (response.status == true) {
        _EditChild();
      } else {
        AppUtils.dismissprogress();
        AppUtils.showError(context, "Child Already exists", "");
        _btnController.stop();
        print("error");
      }
    });
  }
}
