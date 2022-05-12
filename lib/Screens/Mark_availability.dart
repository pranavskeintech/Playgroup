import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/Profile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

class Mark_Availabilty extends StatefulWidget {
  const Mark_Availabilty({Key? key}) : super(key: key);

  @override
  State<Mark_Availabilty> createState() => _Mark_AvailabiltyState();
}

class _Mark_AvailabiltyState extends State<Mark_Availabilty> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dobController = TextEditingController();

  String? selectedStartTime;
  String? selectedEndTime;
  List<String> items = [
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 Pm',
    '6 PM',
    '7 PM',
    '8 PM',
  ];

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (picked != null) {
      setState(() {
        String date1 = "${picked.day}-${picked.month}-${picked.year}";
        _dobController.text = date1;
        print("date selected");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              "assets/imgs/appicon.png",
              width: 32,
              height: 32,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "PlayGroup",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileScreen()));
            },
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/imgs/child5.jpg"),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/imgs/chat.png",
                width: 25,
                height: 25,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: ImageIcon(
              AssetImage("assets/imgs/menu_ver2.png"),
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mark your Availabilty"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: 60,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: const [
                        Color.fromARGB(255, 251, 182, 149),
                        Color.fromARGB(255, 245, 106, 133),
                      ],
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Today",
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "12-05-22",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: 60,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: const [
                        Color.fromARGB(255, 146, 202, 247),
                        Color.fromARGB(255, 137, 123, 247),
                      ],
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Tommorow",
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "13-05-22",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "DOB",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
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
                          controller: _dobController,
                          enabled: false,
                          style: TextStyle(color: Colors.black),
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Timing",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text("From"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text("To"),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Select time',
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
                      value: selectedStartTime,
                      onChanged: (value) {
                        setState(() {
                          selectedStartTime = value as String;
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
                        color: Color.fromARGB(255, 230, 230, 230),
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Select time',
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
                      value: selectedEndTime,
                      onChanged: (value) {
                        setState(() {
                          selectedEndTime = value as String;
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
                        color: Color.fromARGB(255, 230, 230, 230),
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
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
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
                        //controller: _numberController,
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
              SizedBox(height: 20,),
              Container(
                child: const Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5,),
              Text("Choose your location",style: TextStyle(color: Colors.grey),),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 230, 230, 1),
    borderRadius: BorderRadius.circular(10),
  ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextDropdownFormField(
                        
    options: const ["Male", "Female"],
    // decoration: InputDecoration(
    //     border: OutlineInputBorder(),
    //     suffixIcon: Icon(Icons.arrow_drop_down),
    //     labelText: "Gender"),
    decoration: InputDecoration(
      fillColor: Colors.transparent,
      filled: true,
      border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        //labelText: "Gender"),
    ),
    dropdownHeight: 120,
),
                    ),
                    SizedBox(width: 5,),
                    Row(children: const [Text("Map",style: TextStyle(color: Colors.blue),),Icon(Icons.location_pin,color: Colors.red,)],)
                  ],
                ),
              ),
              SizedBox(height: 28,),
              SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.grey.withOpacity(0.3))))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen()));
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
