import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_calendar/r_calendar.dart';

class edit_profile_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return edit_profile_screenState();
  }
}

class edit_profile_screenState extends State<edit_profile_screen> {
  final ImagePicker _picker = ImagePicker();
  String path = '';

  @override
  void initState() {
    super.initState();
  }

  takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      path = photo!.path;
    });
  }

  getGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      path = image!.path;
    });
  }

  void _showBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return AnimatedPadding(
              padding:
                  MediaQuery.of(context).viewInsets, // 我们可以根据这个获取需要的padding
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: 220,
                color: Colors.transparent,
                child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        GestureDetector(
                            onTap: () => Navigator.pop(context, 0),
                            child: Text('Take Photo',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        SizedBox(height: 30),
                        GestureDetector(
                            onTap: () => Navigator.pop(context, 1),
                            child: Text('Choose from album',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        SizedBox(height: 30),
                        Container(height: 1, color: Colors.grey.shade400),
                        SizedBox(height: 30),
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        SizedBox(height: 30),
                      ],
                    )),
              ));
        }).then((value) {
      if (value == 0) {
        takePhoto();
      } else if (value == 1) {
        getGallery();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('C', style: TextStyle(fontSize: 25, color: Colors.yellow)),
            Text('H', style: TextStyle(fontSize: 25, color: Colors.orange)),
            Text('O', style: TextStyle(fontSize: 25, color: Colors.red)),
            Text('D', style: TextStyle(fontSize: 25, color: Colors.blue)),
            Text('I', style: TextStyle(fontSize: 25, color: Colors.green))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          path == ''
              ? Icon(Icons.account_circle, size: 80)
              : Image.file(File(path), width: 80, height: 80, fit: BoxFit.fill),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _showBottomSheetMenu(),
              child: Text('Chang profile photo',
                  style: TextStyle(color: Colors.blue))),
          SizedBox(height: 20),
          Container(height: 1, color: Colors.grey.shade200),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30),
              Container(width: 100, child: Text('Name')),
              SizedBox(width: 10),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 30),
              Container(width: 100, child: Text('Gender')),
              SizedBox(width: 10),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 30),
              Container(width: 100, child: Text('Birth Date')),
              SizedBox(width: 10),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 30),
              Container(width: 100, child: Text('Location')),
              SizedBox(width: 10),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Text('DONE', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  buildItem(IconData? icon, String txt) {
    return Row(
      children: [
        SizedBox(width: 10),
        Icon(icon, size: 30),
        SizedBox(width: 40),
        Text(txt),
        Expanded(child: SizedBox()),
        Icon(Icons.arrow_forward_ios, size: 20),
        SizedBox(width: 10),
      ],
    );
  }
}
