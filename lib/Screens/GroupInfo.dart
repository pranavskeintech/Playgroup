import 'package:flutter/material.dart';
import 'package:playgroup/Utilities/Strings.dart';

class Groupinfo extends StatefulWidget {
  const Groupinfo({Key? key}) : super(key: key);

  @override
  State<Groupinfo> createState() => _GroupinfoState();
}

class _GroupinfoState extends State<Groupinfo> {
  bool value = false;

  bool _showDelete = false;

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Strings.appThemecolor,
        title: Text(
          "Group Info",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImageIcon(
              AssetImage("assets/imgs/back arrow.png"),
              color: Colors.white,
            )),
      ),
      bottomSheet: _showBottomSheet(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
            child: Row(
              children: [
                Text(
                  "Science Experiments",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/imgs/edit2.png",
                    fit: BoxFit.fill,
                    width: 18,
                    height: 18,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("(32) Friends"),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("Add Friends"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.person_add_alt_1,
                          size: 15,
                        )
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Container(
              height: 35,
              child: TextField(
                style: TextStyle(
                  height: 2.5,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ListTile(
                    onLongPress: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => ChildProfile()));
                      setState(() {
                        _isPressed = true;
                      });
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/imgs/child1.jpg"),
                    ),
                    trailing: _isPressed
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            width: 20,
                            height: 20,
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                  // side: BorderSide(color: Colors.black),
                                  checkColor: Colors.green,
                                  activeColor: Colors.transparent,
                                  //hoverColor: Colors.black,
                                  value: this.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.value = value!;
                                      print("value:$value");
                                      if (value == true) {
                                        _showDelete = true;
                                      }
                                    });
                                  }),
                            ),
                          )
                        : null,
                    title: Text("Christopher Janglen"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    thickness: 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget? _showBottomSheet() {
    if (_showDelete) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 5.0,
                  offset: new Offset(0.0, 2.0),
                ),
              ],
            ),
            height: 100,
            width: double.infinity,
            // color: Colors.white,
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => AddGroup()));
                  setState(() {
                    _showDelete = false;
                    _isPressed = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage("assets/imgs/delete_1.png"),
                        //color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Delete",
                        // style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                )),
          );
        },
      );
    } else {
      return null;
    }
  }
}
