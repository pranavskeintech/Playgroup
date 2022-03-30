import 'package:flutter/material.dart';
import 'package:playgroup/Screens/OTPScreen.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:country_calling_code_picker/picker.dart';


class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> 
{
  var _numberController = TextEditingController();
  var _btnController = RoundedLoadingButtonController();

  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    // TODO: implement initState
    super.initState();
  }
  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }
  void _showCountryPicker() async{
    final country = await showCountryPickerDialog(context,);
    if (country != null) {
      
      setState(() {
        _selectedCountry = country;
      });
    }
}      
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
                  "assets/imgs/phone.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Phone Number Verification",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.075,),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: const Text(
                        "Enter Phone Number",
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
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: GestureDetector(
                          onTap: (){
                              _showCountryPicker();
                          },
                          child: Text(_selectedCountry!.callingCode)),
                      ),
                      Icon(Icons.arrow_drop_down ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          controller: _numberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(230, 230, 230, 1), width: 0.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(230, 230, 230, 1),
                                  width: 0.0),
                            ),
                            fillColor: Color.fromRGBO(230, 230, 230, 1),
                            filled: true,
                            hintText: "Enter Phone number",
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
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
              builder: (BuildContext context) => OTPScreen()));
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

        
        

