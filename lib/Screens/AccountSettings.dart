import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';


class AccountSettings extends StatefulWidget {
  const AccountSettings({ Key? key }) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {


  List<int> extendedIndex = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Strings.appThemecolor,
        title: Text("Account Settings"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: FAQBody(),
    );
  }

  FAQBody()
  {
    return Container(
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          ListTile(title: Text("Profile"),),
          Container(color: Colors.grey.withOpacity(0.2),height: 1,),
          ListTile(title: Text("Account Delete"),)

         
        ],

      ),
    );
  }
}