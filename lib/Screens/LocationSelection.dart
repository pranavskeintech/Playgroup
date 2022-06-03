import 'package:flutter/material.dart';
import 'package:playgroup/Models/Get_CityRes.dart';
import 'package:playgroup/Models/RegisterReq.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/ChildDetails.dart';
import 'package:playgroup/Screens/ChooseChild.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import '../Utilities/AppUtlis.dart';
import '../Utilities/Strings.dart';

class LocationSelection extends StatefulWidget {
  const LocationSelection({Key? key}) : super(key: key);

  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  final _btnController = RoundedLoadingButtonController();
  String? selectedValue;
  List<Message> items = [];

  BuildContext? ctx;

  List<Message>? Cities;

  bool _isLoading = true;

  final TextEditingController controller = TextEditingController();
  List countries = [];
  String? filter;

  bool _showList = false;

  _GetCities() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.Get_City().then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          Cities = response.message!;
          items = response.message!;
          _isLoading = false;
          print("Cities:" + Cities![0].name!);
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetCities());
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return SignUP(newContext);
          }),
        ));
  }

  SignUP(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            resizeToAvoidBottomInset: false,
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
                          child: Text(
                            "Enter your current location",
                            style: TextStyle(color: Strings.textFeildHeading),
                          )),
                      SizedBox(
                        height: 10,
                      ),
<<<<<<< HEAD
                      Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                _showList = true;
                              });
                            },
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            // decoration: InputDecoration(
                            //   // prefixIcon: Icon(Icons.search),
                            //   // suffixIcon: IconButton(
                            //   //   icon: Icon(Icons.close),
                            //   //   onPressed: () {
                            //   //     controller.clear();
                            //   //     FocusScope.of(context)
                            //   //         .requestFocus(FocusNode());
                            //   //   },
                            //   // ),

                            //   hintText: "Search...",
=======
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
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.name,
                                    child: Text(
                                      item.name!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(
                            //   color: Colors.black26,
>>>>>>> b08f1f8f1b89ab5e61280a58ff7662ee9e5ce404
                            // ),

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Search",
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 0.0),
                                    borderRadius: BorderRadius.circular(6)),
                                filled: true,
                                fillColor: Strings.textFeildBg,
                                suffixIcon: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(
                                    _showList
                                        ? Icons.clear
                                        : Icons.arrow_forward_ios_outlined,
                                  ),
                                  onPressed: () {
                                    controller.clear();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                )),
                            controller: controller,
                          )),
                      _showList
                          ? Expanded(child: _buildListView())
                          : SizedBox(),
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButton2(
                      //     isExpanded: true,
                      //     hint: Row(
                      //       children: const [
                      //         Expanded(
                      //           child: Text(
                      //             'Select Location',
                      //             style: TextStyle(
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     items: items
                      //         .map((item) => DropdownMenuItem<String>(
                      //               value: item.name,
                      //               child: Text(
                      //                 item.name!,
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.black,
                      //                 ),
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ))
                      //         .toList(),
                      //     value: selectedValue,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedValue = value as String;
                      //       });
                      //     },
                      //     icon: const Icon(
                      //       Icons.arrow_forward_ios_outlined,
                      //     ),
                      //     iconSize: 14,
                      //     iconEnabledColor: Colors.black,
                      //     iconDisabledColor: Colors.grey,
                      //     buttonHeight: 50,
                      //     buttonWidth: MediaQuery.of(context).size.width * 0.9,
                      //     buttonPadding:
                      //         const EdgeInsets.only(left: 14, right: 14),
                      //     buttonDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       // border: Border.all(
                      //       //   color: Colors.black26,
                      //       // ),
                      //       color: Strings.textFeildBg,
                      //     ),
                      //     buttonElevation: 0,
                      //     itemHeight: 40,
                      //     itemPadding:
                      //         const EdgeInsets.only(left: 14, right: 14),
                      //     dropdownMaxHeight: 200,
                      //     // dropdownWidth: 300,
                      //     dropdownPadding: null,
                      //     dropdownDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       color: Colors.white,
                      //     ),
                      //     dropdownElevation: 8,
                      //     scrollbarRadius: const Radius.circular(40),
                      //     scrollbarThickness: 6,
                      //     scrollbarAlwaysShow: true,
                      //     offset: const Offset(0, 0),
                      //   ),
                      // ),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          controller: _btnController,
                          onPressed: () {
                            var email = Strings.EmailId;
                            var name = Strings.UserName;
                            var phonenum = Strings.PhoneNumber;
                            var pass = Strings.Password;
                            print("1");

                            if (selectedValue != null) {
                              _Signup(email, name, phonenum, pass);
                            } else {
                              _btnController.stop();
                              AppUtils.showError(
                                  context, "Please Select the Location", "");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _Signup(email, uname, phone, pass) {
    UserRegisterReq UserReg = UserRegisterReq();
    UserReg.emailId = email;
    UserReg.parentName = uname;
    UserReg.phone = phone;
    UserReg.password = pass;
    UserReg.location = selectedValue;
    print("name:$uname");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.Register(UserReg).then((response) {
      print('response ${response.status}');
      print("result1:${response.toJson()}");

      if (response.status == true) {
        // _isLoading = false;
        //  Get.off(() => DashPage());
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) =>  FeedsCommentsScreen(fid)));
        // print("uhad:$fid");
        // int feedid = fid;
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) => FeedsCommentsScreen(feedid)));
        print("res:${response.userId}");
        //print("user_iid: ${response..}");
        Strings.Parent_Id = response.userId ?? 0;
        Strings.authToken = response.token!;
        Strings.refreshToken = response.refreshToken!.refreshToken!;
        print("tokr${Strings.authToken}");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ChildDetails()));
        print("result2:$response");
      } else {
        functions.createSnackBar(context, response.message.toString());
        _btnController.stop();
        print("error");
      }
    });
  }

  Widget _buildListView() {
    return Scrollbar(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: Cities!.length,
          itemBuilder: (BuildContext context, int index) {
            if (filter == null || filter == "") {
              return ListTile(
                onTap: () {
                  selectedValue = Cities![index].name!;
                  controller.text = selectedValue!;
                  print("1:$selectedValue");
                },
                title: Text(
                  Cities![index].name!,
                ),
              );
            } else {
              if (Cities![index]
                  .name!
                  .toLowerCase()
                  .contains(filter!.toLowerCase())) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      selectedValue = Cities![index].name!;
                      controller.text = selectedValue!;
                    });
                    print("2:$selectedValue");
                  },
                  title: Text(
                    Cities![index].name!,
                  ),
                );
              } else {
                return Container();
              }
            }
          }),
    );
  }
}
