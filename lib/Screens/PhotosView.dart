import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class photosView extends StatefulWidget {
  List<XFile>? imageFileList;
  photosView({Key? key, this.imageFileList}) : super(key: key);

  @override
  State<photosView> createState() => _photosViewState();
}

class _photosViewState extends State<photosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Multiple Images'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // selectImages();
                },
                child: Text('Select Images'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: widget.imageFileList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(widget.imageFileList![index].path),
                          fit: BoxFit.cover,
                        );
                        //return Text("data");
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
