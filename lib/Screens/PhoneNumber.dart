import 'package:flutter/material.dart';
import 'package:playgroup/Screens/OTPScreen.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
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
  final _numberController = TextEditingController();
  final _btnController = RoundedLoadingButtonController();

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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:50),
                      child: const Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back_sharp)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  Image.asset(
                    "assets/imgs/phone.png",
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Phone Number Verification",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 50),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child:  Text(
                          "Enter Phone Number",
                          style: TextStyle(
                              fontSize: 15,
                              color: Strings.textFeildHeading,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                          color: Strings.textFeildBg,
                          border: Border.all(color: const Color(0xFFf2f3f4)),
                          borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: GestureDetector(
                            onTap: (){
                                _showCountryPicker();
                            },
                            child: Text(_selectedCountry?.callingCode ?? "+91",style: TextStyle(color: Colors.blue),)),
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
                              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Strings.textFeildBg, width: 0.0),
                              ),
                              enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Strings.textFeildBg,
                                    width: 0.0),
                              ),
                              fillColor: Strings.textFeildBg,
                              filled: true,
                              hintText: "Enter Phone number",
                              contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            ),
                            keyboardType: TextInputType.phone,
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
                      borderRadius: 5,
                      color:  Strings.appThemecolor,
                      child: const Text('Continue',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      controller: _btnController,
                      onPressed: () {
                          if(_numberController.text.length != 10)
                          {
                            AppUtils.showWarning(context, "Invalid Number","" );
                            _btnController.stop();
                          }
                          else
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                ),
                              ),
                            );
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
}

        
        

