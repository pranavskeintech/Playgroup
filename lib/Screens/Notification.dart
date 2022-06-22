import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Models/GetNotificationList.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Screens/Mark_availability.dart';
import 'package:playgroup/Screens/Own_Availability.dart';
import 'package:playgroup/Screens/ShowOtherChild.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Data>? NotificationList;

  BuildContext? ctx;

  bool _isLoading = true;

  List<String> dateFormate = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => GetNotificationList());
  }

  GetNotificationList() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetNotificationList(Strings.SelectedChild).then((response) async {
      print(response.status);
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          NotificationList = response.data!;
          for (int index = 0;
                      index < NotificationList!.length;
                      index++) {
                    dateFormate.add(DateFormat("dd-MM-yyyy").format(
                        DateTime.parse(NotificationList![index].createdDate!)));
                  }
                                          print(dateFormate);

        });
        


      } else {
        //functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, "Unable to fetch deatils", "");
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
           appBar: AppBar(
              //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
              backgroundColor: Strings.appThemecolor,
              title: Text(
                "Notification",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                   // _scaffoldKey.currentState?.openDrawer();
                   Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
            )),
          body: Builder(builder: (BuildContext newContext) {
            return NotificationScreen(newContext);
          }),
        ));
  }

  NotificationScreen(BuildContext context) {
    ctx = context;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: NotificationList!.length,
                itemBuilder: (context, mainIndex) {
                  Widget separator = SizedBox();
                  if (mainIndex != 0 &&
                      dateFormate[mainIndex] != dateFormate[mainIndex - 1]) {
                    separator = Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Strings.chipsbg
                        ),
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: Text(
                          dateFormate[mainIndex],
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ));
                  }
                  else if(mainIndex == 0)
                  {
                    separator = Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Strings.chipsbg
                        ),
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: Text(
                          dateFormate[mainIndex],
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ));
                  }

                  print("date:${dateFormate[mainIndex]}");
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        separator,
                        SizedBox(
                          height: 90,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 8.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      2.0, // Move to right 10  horizontally
                                      2.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  // Strings.FriendNotification = true;


                                  if(NotificationList![mainIndex].title!.contains("Mark"))
                                  {

                                    print(NotificationList![mainIndex].markavailId);
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Own_Availability(markavailId: NotificationList![mainIndex].markavailId,)));
                                  }
                                  else
                                  {
                                      Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ShowOtherChildProfile(otherChildID: NotificationList![mainIndex].otherChildId,)));
                                  }

                                  
                                },
                                title: Text(
                                  NotificationList![mainIndex].title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                subtitle: Text(
                                  NotificationList![mainIndex].body!,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}