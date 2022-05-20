import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playgroup/Screens/PastActivityDetailView.dart';

class PastActivity extends StatefulWidget {
  const PastActivity({Key? key}) : super(key: key);

  @override
  State<PastActivity> createState() => _PastActivityState();
}

class _PastActivityState extends State<PastActivity> 
{
  List<String> childImgs = [
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300",
    "https://picsum.photos/500/300"
  ];

  bool isHighlighted = true;
  @override
  Widget build(BuildContext context) 
  {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 520,
          width: 370,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/imgs/child.jpg"),
                ),
                title: Text("Kingston Jackey"),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("14 Jan 2021"),
                        SizedBox(width: 5),
                        Container(
                          width: 1,
                          height: 10,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "4-5 Pm",
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Past_Activity_Details()));
                      }),
                      child: Text(
                        "See More",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                        //overflow: TextOverflow.fade,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Art Work - Natural Painting"),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: PhotoGrid(
                  imageUrls: childImgs,
                  onImageClicked: (i) => print('Image $i was clicked!'),
                  onExpandClicked: () => print('Expand Image was clicked'),
                  maxImages: 3,
                ),
              ),
              Row(children: [
                Column(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onHighlightChanged: (value) {
                        setState(() {
                          isHighlighted = !isHighlighted;
                        });
                      },
                      onTap: () {
                        setState(() {});
                      },
                      child: Image.asset(
                        "assets/imgs/Like2.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {}),
                      child: Text("5 likes",
                          style: TextStyle(fontSize: 8, color: Colors.black87)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/imgs/Comments.png",
                      width: 60,
                      height: 60,
                    ),
                    Text("3 comments",
                        style: TextStyle(fontSize: 8, color: Colors.black87)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/imgs/share3.png",
                      width: 60,
                      height: 60,
                    ),
                    Text("3 share",
                        style: TextStyle(fontSize: 8, color: Colors.black87)),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text("Participants(06)",
                        style: TextStyle(fontSize: 13, color: Colors.black87)),
                  ),
                )
              ]),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  PhotoGrid(
      {required this.imageUrls,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      Key? key})
      : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.15,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child:
                // Image.asset('assets/imgs/${imageUrl[index]}'),
                Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}
