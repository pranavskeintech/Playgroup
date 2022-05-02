import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playgroup/Screens/AddCoParent.dart';
import 'package:playgroup/Utilities/Strings.dart';


class ProfileScreen extends StatefulWidget 
{
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Text(
          "PlayGroup",
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
        padding: EdgeInsets.fromLTRB(28, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Profile",style: TextStyle(color: Colors.grey),),TextButton(onPressed: (){}, child: Row(children: [Text("Edit"),SizedBox(width: 5,),Icon(Icons.edit_outlined,size: 15,)],))
              ],
            ),
            Divider(color: Colors.grey,),
            Container(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 5,),
                      Text("Jhon Doe",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Container(color: Colors.grey.withOpacity(0.3),width: 1,height: 40,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email ID",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 5,),
                      Text("jhondoe@gmail.com",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 28,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Number",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 5,),
                      Text("+91 8898767890",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Container(color: Colors.grey.withOpacity(0.3),width: 1,height: 40,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 5,),
                      InkWell(child: Text("Change Password",style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 30,),
            Container(
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Co-Parent",style: TextStyle(color: Colors.grey),
                ),
                ElevatedButton(onPressed: ()
                {
                  Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddCoParent()));
                }, child: Text("Add Co-Parent"))
              ],),
            ),
            SizedBox(height: 20,),
            Text("Children",style: TextStyle(fontWeight: FontWeight.bold,)),
            Expanded(
              child: ListView.builder(itemCount: 2,
                itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                  ),
                  title: Text("Christopher Janglen"),
                  subtitle: Text("7 years"),
                  trailing: Text("Remove",style: TextStyle(color: Colors.red),),
                );
                
              },),
            ),
            Align(alignment: Alignment.bottomCenter,child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(onPressed: (){}, child: Text("Add Child",style: TextStyle(color: Colors.black),),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),),
            )),
          
          ],
        ),

      ),
      
    );
  }
}