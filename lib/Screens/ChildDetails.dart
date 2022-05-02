import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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


class _ChildDetailsState extends State<ChildDetails> 
{
  var _numberController = TextEditingController();
    var _dobController = TextEditingController();


  var _btnController = RoundedLoadingButtonController();
  late AppState state;


  String? selectedValue;
  List<String> items = [
    'Male',
    'Female',
    'Prefer Not to say',
  ];
   ImagePicker _picker = ImagePicker();

  File? _imageFile;


  _selectDate() async 
  {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),

      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
       String date1 = "${picked.day}-${picked.month}-${picked.year}";
        _dobController.text = date1;
        print("date selected");
      });



  }

  openGallery() async 
  {
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

    if (croppedFile?.path != null) 
    {
      setState(() {
        _imageFile = croppedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  Navigator.pop(context);
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(height: 10),
              Stack(
                children:[
                  CircleAvatar(
                  radius: 40.0,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : null,
                  backgroundColor: Colors.transparent,
                  child: _imageFile == null
                      ? Image.asset("assets/imgs/appicon.png")
                      : SizedBox(),
                ),
                Positioned(bottom: 0,
                right: 0,
                  child: GestureDetector(
                    onTap: (){
                      openGallery();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      border: Border.all(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.camera_enhance_outlined,
                        size: 15,)),
                  ))]         ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.050,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      "Child's Name",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    border: Border.all(color: const Color(0xFFf2f3f4)),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: _numberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(230, 230, 230, 1),
                                width: 0.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(230, 230, 230, 1),
                                width: 0.0),
                          ),
                          fillColor: Color.fromRGBO(230, 230, 230, 1),
                          filled: true,
                          hintText: "",
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
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
                    child: const Text(
                      "DOB",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
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
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(color: const Color(0xFFf2f3f4)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          style: TextStyle(
                            color: Colors.black),
                          controller: _dobController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(230, 230, 230, 1),
                                  width: 0.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(230, 230, 230, 1),
                                  width: 0.0),
                            ),
                            fillColor: Color.fromRGBO(230, 230, 230, 1),
                            filled: true,
                            hintText: "",
                            suffixIcon: Icon(Icons.calendar_today_outlined),
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
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
                    child: const Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Select Gender',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
                              fontWeight: FontWeight.bold,
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
                 
                  color: Color.fromARGB(255,230,230,230),
                ),
                buttonElevation: 2,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: 300,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(0, 0),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: RoundedLoadingButton(
                  resetDuration: const Duration(seconds: 10),
                  resetAfterDuration: true,
                  successColor: const Color.fromRGBO(94, 37, 108, 1),
                  width: 500,
                  borderRadius: 10,
                  color: Strings.appThemecolor,
                  child: const Text('Continue',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: () {
                    //          Navigator.of(context).push(MaterialPageRoute(
                    // builder: (BuildContext context) => OTPScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
