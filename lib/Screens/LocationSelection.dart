import 'package:flutter/material.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChooseChild.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../Utilities/Strings.dart';

class LocationSelection extends StatefulWidget {
  const LocationSelection({Key? key}) : super(key: key);

  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  final _btnController = RoundedLoadingButtonController();
  String? selectedValue;
  List<String> items = [
    'Coimbatore',
    'Chennai',
    'Pune',
    'Kochin',
    'Thrissur',
    'Palakkad',
    'Calicut',
    'Tivandrum',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
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
                    Navigator.pop(context);
                  },
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back_sharp)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Image.asset(
                  "assets/imgs/location.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Location",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Enter your current location",style: TextStyle(color: Strings.textFeildHeading),)),
                  SizedBox(height: 10,),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Select Location',
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
                              child: 
                              Text(
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
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: MediaQuery.of(context).size.width * 0.9,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(
                      //   color: Colors.black26,
                      // ),
                      color: Strings.textFeildBg,
                    ),
                    buttonElevation: 0,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                   // dropdownWidth: 300,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                    resetDuration: const Duration(seconds: 10),
                    resetAfterDuration: true,
                    successColor: const Color.fromRGBO(94, 37, 108, 1),
                    width: 500,
                    borderRadius: 5,
                    color: Strings.appThemecolor,
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    controller: _btnController,
                    onPressed: () 
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ChildDetails()));
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
}
