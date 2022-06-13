import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playgroup/Models/GetNotificationList.dart';
import 'package:playgroup/Network/ApiService.dart';
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
    api.GetNotificationList(Strings.SelectedChild).then((response) {
      print(response.status);
      if (response.status == true) {
        setState(() {
          _isLoading = false;
          NotificationList = response.data!;
        });
      } else {
        //functions.createSnackBar(context, response.message.toString());
        AppUtils.dismissprogress();
        AppUtils.showError(context, "Unable to fetch details for child", "");
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
                reverse: true,
                physics: BouncingScrollPhysics(),
                itemCount: NotificationList!.length,
                itemBuilder: (context, index) {
                  for (int index = 0;
                      index < NotificationList!.length;
                      index++) {
                    dateFormate!.add(DateFormat("dd-MM-yyyy").format(
                        DateTime.parse(NotificationList![index].createdDate!)));
                  }
                  Widget separator = SizedBox();
                  if (index != 0 &&
                      dateFormate![index] != dateFormate![index - 1]) {
                    separator = Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Strings.chipsbg
                        ),
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: Text(
                          dateFormate![index],
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ));
                  }

                  print("date:${dateFormate![index]}");
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        separator,
                        // Text(
                        //   dateFormate!,
                        //   style: TextStyle(color: Colors.grey, fontSize: 13),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // for (int i = 0; i < 2; i++)
                        SizedBox(
                          height: 100,
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
                                  Strings.FriendNotification = true;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ShowOtherChildProfile()));
                                },
                                title: Text(
                                  NotificationList![index].title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                subtitle: Text(
                                  NotificationList![index].body!,
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
