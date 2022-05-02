import 'package:flutter/material.dart';
import 'package:playgroup/Screens/Dashboard.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../Utilities/Strings.dart';

class LocationSelection extends StatefulWidget 
{
  const LocationSelection({ Key? key }) : super(key: key);

  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection>
 {
  var _btnController = RoundedLoadingButtonController();
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
  Widget build(BuildContext context) 
  {
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Image.asset(
                  "assets/imgs/location.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Location",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.075,),
                const SizedBox(
                  height: 5,
                ),
                DropdownButton2(      
            isExpanded: true,
            hint: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Select Location',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
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
            iconDisabledColor: Colors.grey,
            buttonHeight: 50,
            buttonWidth: MediaQuery.of(context).size.width * 0.9,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white,
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
              Container(
                  decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: const Color(0xFFf2f3f4)),
                        borderRadius: BorderRadius.circular(10)),
                  child: Container()
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RoundedLoadingButton(
                    resetDuration: const Duration(seconds: 10),
                    resetAfterDuration: true,
                    successColor: const Color.fromRGBO(94, 37, 108, 1),
                    width: 500,
                    borderRadius: 10,
                    color:  Strings.appThemecolor,
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white)),
                    controller: _btnController,
                    onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => DashBoard()));
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