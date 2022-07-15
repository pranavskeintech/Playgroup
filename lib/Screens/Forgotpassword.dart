import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/OTPScreen.dart';
import 'package:playgroup/Screens/PhoneNumber.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/CustomStyle.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:provider/provider.dart';
import 'package:playgroup/Utilities/Functions.dart';

import '../Network/ApiService.dart';

class Forgotpassword extends StatefulWidget {
  static const String routeName = '/forgotpassword';
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var ctx;

  Country? _selectedCountry;

  @override
  void initState() {
    setState(() {
      // _phone.text = "nowfal@yopmail.com";
    });

    super.initState();
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  continueBtn() {
    if (_phone.text.isEmpty) {
      AppUtils.showWarning(context, "Please Enter valid phone number", "");
    } else {
      // AppUtils.showprogress();
      // CommonReq loginreq = CommonReq();
      // final api = Provider.of<ApiService>(ctx, listen: false);
      // api.forgotpass(loginreq).then((response)
      // {
      //   print('response ${response.status}');
      //   AppUtils.dismissprogress();
      //   if(response.message == "Token Expired")
      //   {
      //       Navigator.pushNamed(context, '/login');
      //   }

      //   if (response.status!) {
      //     Navigator.pushNamed(context, '/otpverification');
      //   } else {
      //     AppUtils.showError(ctx, response.message, "");
      //   }
      // }).catchError((onError) {
      //   AppUtils.dismissprogress();
      //   print('response $onError');
      // });
    }
  }

  phoneno() {
    return Container(
        child: TextField(
          // style: CustomStyle.val,
          controller: _phone,
          // maxLength: 10,
          // inputFormatters: <TextInputFormatter>[
          //   new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          // ],
          decoration: new InputDecoration(
            counterText: "",
            prefix: Text("+91 "),
            // labelStyle: CustomStyle.key,
            hintStyle: TextStyle(height: 2),
            border: InputBorder.none,
            labelText: 'Phone Number',
            hintText: "Phone Number",
          ),
          keyboardType: TextInputType.number,
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            bottom: new BorderSide(
                color: Strings.appThemecolor, style: BorderStyle.solid),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return forgotBody(newContext);
          }),
        ));
  }

  forgotBody(context) {
    ctx = context;
    return Listener(
      onPointerUp: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 30),
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            //color: Strings.appThemecolor,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  child: Center(
                      child: Image.asset("assets/imgs/ForgotPassword.png")),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    Strings.fromProfile ? "Change Password" : "Forgot Password",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0)),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  color: Colors.white,
                  child: !Strings.fromProfile
                      ? Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("Enter your registered phone number",
                                  style: TextStyle(
                                      color: Strings.textFeildHeading)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Strings.textFeildBg,
                                  border: Border.all(
                                      color: const Color(0xFFf2f3f4)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: GestureDetector(
                                        onTap: () {
                                          _showCountryPicker();
                                        },
                                        child: Text(
                                          _selectedCountry?.callingCode ??
                                              "+91",
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.70,
                                      child: TextField(
                                        style: TextStyle(color: Colors.black),
                                        controller: _numberController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Strings.textFeildBg,
                                                width: 0.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Strings.textFeildBg,
                                                width: 0.0),
                                          ),
                                          fillColor: Strings.textFeildBg,
                                          filled: true,
                                          hintText: "Enter Phone number",
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 0),
                                        ),
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            AppUtils.appbutton('Continue', () {
                              AppUtils.showprogress();
                              Strings.ForgotPassword = true;
                              _CheckUser(_numberController.text);
                              Strings.PhoneNumber = _numberController.text;
                              //   Navigator.of(context).push(MaterialPageRoute(
                              // builder: (context) => OTPScreen()));
                            }),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("Enter your Old Password",
                                  style: TextStyle(
                                      color: Strings.textFeildHeading)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Strings.textFeildBg,
                                  border: Border.all(
                                      color: const Color(0xFFf2f3f4)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Expanded(
                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Strings.textFeildBg,
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Strings.textFeildBg,
                                            width: 0.0),
                                      ),
                                      fillColor: Strings.textFeildBg,
                                      filled: true,
                                      hintText: "Enter Old Password",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 5, 0, 0),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            AppUtils.appbutton('Continue', () {
                              AppUtils.showprogress();
                              Strings.ForgotPassword = true;
                              _CheckUser(_numberController.text);
                              Strings.PhoneNumber = _numberController.text;
                              //   Navigator.of(context).push(MaterialPageRoute(
                              // builder: (context) => OTPScreen()));
                            }),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _CheckUser(phone) {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.CheckUser(phone).then((response) {
      print(response.status);
      if (response.status == false) {
        firebase.verifyPhone(context, phone);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => OTPScreen(),
        //   ),
        // );
      } else {
        //functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, "User not registered", "");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
