import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("25-03-2022",style: TextStyle(color: Colors.grey),),
              SizedBox(height: 10,),
              for(int i = 0; i<2; i++)
              SizedBox(
                height: 100,
                child: Center(
                  child: Card(
                    elevation: 3,
                    borderOnForeground: true,
                    shadowColor: Colors.grey.withOpacity(0.5),
                          child: ListTile(
                            title: Text("You have a new Friend Request."),
                            subtitle: Text("Ramya has send you Friend Request"),)
                        ),
                ),
              ),
            ],
          ),
        );
      },),
      
    );
  }
}