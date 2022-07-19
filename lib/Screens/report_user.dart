import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/rendering.dart';
import 'package:group_radio_button/group_radio_button.dart';

class ReportUser extends StatefulWidget {
  const ReportUser({Key? key}) : super(key: key);

  @override
  State<ReportUser> createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser> {
  String _selectedGender = 'Inappropriate profile';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Report User"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left:10,top: 40, bottom: 20),
                child: Text(
                  "Reason for reporting the user",
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                )
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      trailing: Radio<String>(
                        value: 'Inappropriate profile',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Inappropriate profile'),
                    ),
                    ListTile(
                      trailing: Radio<String>(
                        value: 'Harassment and Bullying',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Harassment and Bullying'),
                    ),
                    ListTile(
                      trailing: Radio<String>(
                        value: 'Fraud User',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Fraud User'),
                    ),
                    ListTile(
                      trailing: Radio<String>(
                        value: 'Hate Speech/Discrimination',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Hate Speech/Discrimination'),
                    ),
                    ListTile(
                      trailing: Radio<String>(
                        value: 'Unknown user',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Unknown user'),
                    ),
                    ListTile(
                      trailing: Radio<String>(
                        value: 'Others',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Others'),
                    ),
                  ],
                ),
              ),
            ),
           // Spacer(),
           Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text("Send",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
