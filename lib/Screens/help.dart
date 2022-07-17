import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Help"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Text(
                    "Get Help From Us",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              Text(
                "Lorem Ipsum",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                  "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text("Phone Number"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 33,
                  ),
                  const Text("+91987654321",style: TextStyle(color: Colors.green),),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35,right: 35),
                child: DottedLine(dashColor: Colors.grey,),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text("Email Id"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 33,
                  ),
                  const Text("playgroupenquiry@gmail.com",style: TextStyle(color: Colors.green),),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ],
          ),
        ),
      ),
    ));
  }
}
