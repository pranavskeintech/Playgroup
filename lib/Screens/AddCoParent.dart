import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Utilities/Strings.dart';


class AddCoParent extends StatefulWidget 
{
  const AddCoParent({ Key? key }) : super(key: key);

  @override
  State<AddCoParent> createState() => _AddCoParentState();
}

class _AddCoParentState extends State<AddCoParent> {

  final _numberController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> items = [
    'View Only',
    'Complete',
  ];

  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
       // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Text(
          "Add Co-Parent",
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: ImageIcon(
              AssetImage("assets/imgs/menu_ver2.png"),
              color: Colors.white,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: 
        Column(
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
              SizedBox(height: 18,),
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
              DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Select Access',
                        style: TextStyle(
                            fontSize: 14,
                           // fontWeight: FontWeight.bold,
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
                              //fontWeight: FontWeight.bold,
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
               // buttonWidth: MediaQuery.of(context).size.width * 0.9,
                buttonPadding: const EdgeInsets.only(left: 15, right: 15),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(
                  //   color: Colors.black26,
                  // ),
                   color: Color.fromARGB(255,230,230,230)
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
                offset: const Offset(0, -10),
              ),
              SizedBox(height: 18,),
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
              Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RoundedLoadingButton(
                      resetDuration: Duration(seconds: 10),
                      resetAfterDuration: true,
                      successColor: Color.fromRGBO(94, 37, 108, 1),
                      width: 500,
                      borderRadius: 10,
                      color: Color.fromRGBO(94, 37, 108, 1),
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      controller: _btnController,
                      onPressed: ()
                      {
              //         Navigator.of(context).push(MaterialPageRoute(
              // builder: (BuildContext context) => ProfileScreen()));
                      },
                    ),
                  ),
      
          ],
        ),
      ),
      
    );
  }
}