import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Models/AddcoParentReq.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Network/ApiService.dart';
import '../Utilities/AppUtlis.dart';
import '../Utilities/Strings.dart';
import 'package:country_calling_code_picker/picker.dart';

class EditCoParent extends StatefulWidget {
  final String? name;
  final String? email;
  final String? PhoneNumber;
  final String? password;
  final String? selectedAcces;

  EditCoParent(
      {Key? key,
      this.email,
      this.name,
      this.PhoneNumber,
      this.password,
      this.selectedAcces})
      : super(key: key);

  @override
  State<EditCoParent> createState() => _EditCoParentState();
}

class _EditCoParentState extends State<EditCoParent> {
  final TextEditingController _coParentNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Country? _selectedCountry;
  List<String> items = [
    'VIEW',
    'COMPLETE',
  ];

  String? selectedAccess;
  void initState() {
    // TODO: implement initState
    print("jb:${widget.selectedAcces}");
    setState(() {
      _coParentNameController.text = widget.name!;
      _emailController.text = widget.email!;
      _passwordController.text = widget.password!;
      _phoneController.text = widget.PhoneNumber!;
      selectedAccess = widget.selectedAcces;
    });
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetLocalData());
  }

  _GetLocalData() {}

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext? ctx;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ApiService.create(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
          backgroundColor: Strings.appThemecolor,
          title: Text(
            "Edit Co-Parent",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:
                // ImageIcon(
                //   AssetImage("assets/imgs/menu_ver2.png"),
                //   color: Colors.white,
                // )
                Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            ),
          ),
        ),
        body: Builder(builder: (BuildContext newContext) {
          return EditCoParent(newContext);
        }),
      ),
    );
  }

  EditCoParent(BuildContext context) {
    ctx = context;
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: const Text(
                  "Co-Parent Name",
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
                color: Strings.textFeildBg,
                border: Border.all(color: Strings.textFeildBg),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              style: TextStyle(color: Colors.black),
              controller: _coParentNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Strings.textFeildBg, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Strings.textFeildBg, width: 0.0),
                ),
                fillColor: Strings.textFeildBg,
                filled: true,
                hintText: "Enter Co-Parent Name",
                contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: const Text(
                  "Email ID",
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
                color: Strings.textFeildBg,
                border: Border.all(color: Strings.textFeildBg),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Strings.textFeildBg, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Strings.textFeildBg, width: 0.0),
                ),
                fillColor: Strings.textFeildBg,
                filled: true,
                hintText: "Enter Email Id",
                contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: const Text(
                  "Phone Number",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
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
                      onTap: () {
                        _showCountryPicker();
                      },
                      child: Text(
                        _selectedCountry?.callingCode ?? "+91",
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
                Icon(Icons.arrow_drop_down),
                Container(
                  height: 40,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Strings.textFeildBg, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Strings.textFeildBg, width: 0.0),
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
          SizedBox(height: 18),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: const Text(
                  "Access",
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
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Select Access',
                      style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black54),
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
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedAccess,
              onChanged: (value) {
                setState(() {
                  selectedAccess = value as String;
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              // iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              // buttonWidth: MediaQuery.of(context).size.width * 0.9,
              buttonPadding: const EdgeInsets.only(left: 15, right: 15),
              buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(
                  //   color: Colors.black26,
                  // ),
                  color: Strings.textFeildBg),
              buttonElevation: 0,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 300,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              dropdownElevation: 0,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(0, -10),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: const Text(
                  "Password",
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
                color: Strings.textFeildBg,
                border: Border.all(color: Strings.textFeildBg),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              obscureText: true,
              style: TextStyle(color: Colors.black),
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Strings.textFeildBg, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Strings.textFeildBg, width: 0.0),
                ),
                fillColor: Strings.textFeildBg,
                filled: true,
                hintText: "Enter Password",
                contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Spacer(),
          Container(
            //margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
            width: MediaQuery.of(context).size.width * 0.9,
            child: RoundedLoadingButton(
              animateOnTap: false,
              resetDuration: Duration(seconds: 10),
              resetAfterDuration: true,
              successColor: Color.fromRGBO(94, 37, 108, 1),
              width: 500,
              borderRadius: 5,
              color: Color.fromRGBO(94, 37, 108, 1),
              child: Text('Save Changes',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              controller: _btnController,
              onPressed: () {
                if (_coParentNameController.text == "") {
                  AppUtils.createSnackBar(context, "Please enter parent name");
                } else if (_emailController.text == "") {
                  AppUtils.createSnackBar(context, "Please enter parent name");
                } else if (selectedAccess == "") {
                  AppUtils.createSnackBar(context, "Please enter parent name");
                } else if (_passwordController.text.length < 6) {
                  AppUtils.createSnackBar(
                      context, "Password must be at least 6 characters");
                } else if (_phoneController.text.length != 10) {
                  AppUtils.createSnackBar(
                      context, "Please enter valid phone number");
                } else {
                  if (AppUtils.validateEmail(
                      _emailController.text.replaceAll(' ', ''))) {
                    AppUtils.showprogress();
                    createCoparent();
                  } else {
                    AppUtils.createSnackBar(context, "Invalid email");
                    _btnController.stop();
                  }
                }

                //         Navigator.of(context).push(MaterialPageRoute(
                // builder: (BuildContext context) => ProfileScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }

  createCoparent() {
    final api = Provider.of<ApiService>(ctx!, listen: false);

    AddcoParentReq addcoParentReq = AddcoParentReq();
    addcoParentReq.parentName = _coParentNameController.text;
    addcoParentReq.emailId = _emailController.text;
    // addcoParentReq.access = selectedAccess?.toUpperCase();
    addcoParentReq.password = _passwordController.text;

    api.updateCoParent(addcoParentReq).then((response) {
      print('response ${response.status}');
      if (response.status == true) {
        AppUtils.dismissprogress();

        api.updateAccess(selectedAccess!.toUpperCase()).then((response) {
          if (response.status!) {
            AppUtils.dismissprogress();
            AppUtils.showToast("Co-Parent updated successfully", ctx);
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (BuildContext context) => ProfileScreen()));
            Navigator.pop(context);
          }
          {
            print("Unable to update access");
          }
        }).catchError((error) {
          print('error ${error.toString()}');
          AppUtils.dismissprogress();
          AppUtils.showToast("Something went wrong", ctx);
        });

        //Navigator.pop(context);

        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) => ProfileScreen()));
      } else {
        AppUtils.dismissprogress();
        AppUtils.showError(context, response.message, "");
        Navigator.pop(context);
        print("error");
      }
    }).onError((error, stackTrace) {
      AppUtils.showError(context, "Unable to reach servers", "");
    });
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
}
