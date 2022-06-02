import 'package:flutter/material.dart';
import 'package:playgroup/Models/GetSportsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'Availability-Choose_friends.dart';

class Choose_Category extends StatefulWidget {
  const Choose_Category({Key? key}) : super(key: key);
  @override
  State<Choose_Category> createState() => _Choose_CategoryState();
}

class _Choose_CategoryState extends State<Choose_Category> {
  int tag = 1;
  // List<String> options = [
  //   'News',
  //   'Entertainment',
  //   'Politics',
  //   'Automotive',
  //   'Sports',
  //   'Education',
  //   'Fashion',
  //   'Travel',
  //   'Food',
  //   'Tech',
  //   'Science',
  //   'Cricket',
  //   'FoodBall',
  //   'Hockey',
  //   'Tennis',
  //   'Kabbadi',
  //   'Table Tennis',
  // ];
  int? selectedIndex;

  int? SelectedCategory;

  BuildContext? ctx;

  List<Data>? Categories;

  bool _isLoading = true;

  _GetCatagories() {
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.GetSports(Strings.markAvailabiltyTopic).then((response) {
      if (response.status == true) {
        print("response ${response.status}");
        setState(() {
          Categories = response.data!;
          _isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _GetCatagories());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return ChooseCategory(newContext);
          }),
        ));
  }

  ChooseCategory(BuildContext context) {
    ctx = context;
    var media = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  )),
              title: Text("Your Availability"),
              backgroundColor: Strings.appThemecolor,
            ),
            body: Container(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                              child: Text(
                                "What do you want to play?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ))),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                        child: GridView.builder(
                          itemCount: Categories!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 30 / 10,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    SelectedCategory =
                                        Categories![index].sportsId!;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedIndex != index
                                        ? Strings.chipsbg
                                        : Colors.green,
                                    // border:
                                    //     Border.all(color: Colors.grey.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(25),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.3),
                                    //     blurRadius: 0.0, // soften the shadow
                                    //     spreadRadius: 0.0, //extend the shadow
                                    //     offset: Offset(
                                    //       0.0, // Move to right 10  horizontally
                                    //       0.5, // Move to bottom 10 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                      // child: Flexible(
                                      child: Text(
                                        Categories![index].sportsName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: selectedIndex != index
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                      // ),
                                    ),
                                  ),
                                ));
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (SelectedCategory != null) {
                                      Strings.markAvailabiltycategory =
                                          Categories![SelectedCategory!].sportsId ?? 0;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Availability_choose_friends()));
                                    } else {
                                      AppUtils.showWarning(context,
                                          "Please select anyone category", "");
                                    }
                                  },
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Strings.appThemecolor)),
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                                //    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1),
                                // ),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
