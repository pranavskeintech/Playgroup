import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../Utilities/Strings.dart';


class EditAvailabilityTime extends StatefulWidget {
  const EditAvailabilityTime({ Key? key }) : super(key: key);

  @override
  State<EditAvailabilityTime> createState() => _EditAvailabilityTimeState();
}

class _EditAvailabilityTimeState extends State<EditAvailabilityTime> {
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
  List<String> childImgs = 
  [
    "child1.jpg",
    "child2.jpg",
    "child3.jpg",
    "child4.jpg",
    "child5.jpg",
    "child6.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Availability"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [              const Text(
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text("From"),
                    ),
                    Container(
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
                    Container(
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
                    Container(
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
                  height: 10,
                ), Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Participating Friends",
                       style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: (){}, child: TextButton(onPressed: (){}, child: Text("Edit")))
                  ],
                ),
         
          Card(
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          if (index < 5)
                            return Container(
                              padding: EdgeInsets.all(2),
                              width: 40,
                              height: 40,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/imgs/${childImgs[index]}"),
                              ),
                            );
                          else
                            return Container(
                              padding: EdgeInsets.all(3),
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                child: Text(
                                  "3+",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ), //Text
                              ),
                            );
                        })),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Align(alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(child: Text("Save"),onPressed: ()
            {
              
            },),
          ),)
          ],
        ),
      ),
    );
  }
}