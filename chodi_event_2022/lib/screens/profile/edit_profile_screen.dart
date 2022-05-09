import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:flutter_chodi_app/services/firebase_storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_calendar/r_calendar.dart';

import '../../configs/app_theme.dart';

// ignore: camel_case_types, must_be_immutable
class edit_profile_screen extends StatefulWidget {
  String savedProfileImageURL;
  String username;
  String agegroup;

  edit_profile_screen(
      {Key? key,
      required this.savedProfileImageURL,
      required this.username,
      required this.agegroup})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return edit_profile_screenState();
  }
}

// ignore: camel_case_types
class edit_profile_screenState extends State<edit_profile_screen> {
  // ignore: prefer_typing_uninitialized_variables
  var ageValue;
  List<String> ageList = [
    '12 or under',
    '13-17',
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    '65 and over',
    'Prefer not to say'
  ];
  final FirebaseAuth _user = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  Storage fbstorage = Storage();
  String path = '';
  late XFile pickedImage;
  late TextEditingController nameController;

  DropdownMenuItem<String> buildMenuItem(String ageValue) => DropdownMenuItem(
      value: ageValue,
      child: Text(ageValue, style: const TextStyle(color: AppTheme.fontColor)));

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.username);
    pickedImage = XFile('');
    path = widget.savedProfileImageURL;
  }

  Future _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      path = photo!.path;
    });
    pickedImage = photo!;
    return photo;
  }

  Future _getGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      path = image!.path;
    });
    pickedImage = image!;
    return image;
  }

  Future _editYourProfile() async {
    /*
        _takePhoto().then((photo) => {
              fbstorage.uploadImageToStorage(photo).then((downloadURL) => {
                    fbstorage
                        .uploadImageToFirestore(downloadURL!)
                        .then((res) => {log("PHOTO WORKED")})
                  })
            });
            */
/*
    await fbstorage
        .uploadImageToFirestore(pickedImage.path)
        .then((downloadURL) => {
              fbstorage.uploadImageToFirestore(downloadURL!).then((res) async {
                log("HA");
                /*
                await FirebaseFirestore.instance
                    .collection('EndUsers')
                    .doc(_user.currentUser!.uid)
                    .update({
                  "Age": ageValue,
                  "Username": nameController.text,
                  "lastUpdated": Timestamp.now(),
                }).then((res) {
                  log("IT WORKED");
                });
                */
              })
            });
*/

    await FirebaseFirestore.instance
        .collection('EndUsers')
        .doc(_user.currentUser!.uid)
        .update({
      "Age": ageValue,
      "Username": nameController.text,
      "lastUpdated": Timestamp.now(),
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
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        GestureDetector(
                            onTap: () => Navigator.pop(context, 0),
                            child: const Text('Take Photo',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        const SizedBox(height: 30),
                        GestureDetector(
                            onTap: () => Navigator.pop(context, 1),
                            child: const Text('Choose from album',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        const SizedBox(height: 30),
                        Container(height: 1, color: Colors.grey.shade400),
                        const SizedBox(height: 30),
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        const SizedBox(height: 30),
                      ],
                    )),
              ));
        }).then((value) {
      if (value == 0) {
        _takePhoto();
        /*
        _takePhoto().then((photo) => {
              fbstorage.uploadImageToStorage(photo).then((downloadURL) => {
                    fbstorage
                        .uploadImageToFirestore(downloadURL!)
                        .then((res) => {log("PHOTO WORKED")})
                  })
            });
            */
      } else if (value == 1) {}

      _getGallery();
      /*
      _getGallery().then((photo) => {
            fbstorage.uploadImageToStorage(photo).then((downloadURL) => {
                  fbstorage
                      .uploadImageToFirestore(downloadURL!)
                      .then((res) => {log("GALLERY WORKED")})
                })
          });
          */
    });
  }

  @override
  Widget build(BuildContext context) {
    //log(path);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            path == ''
                ? const Icon(Icons.account_circle, size: 80)
                : Image.network(
                    //switch between loading image from network and image from path
                    path,
                    fit: BoxFit.fill,
                    height: 80,
                    width: 80,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.file(
                        File(path),
                        fit: BoxFit.fill,
                        height: 80,
                        width: 80,
                      );
                    },
                  ),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () => _showBottomSheetMenu(),
                child: const Text('Change Profile Photo',
                    style: TextStyle(color: Colors.blue))),
            const SizedBox(height: 20),
            Container(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 30),
                const SizedBox(width: 100, child: Text('Username')),
                const SizedBox(width: 10),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 16),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        style: const TextStyle(color: AppTheme.fontColor),
                        controller: nameController,
                        onChanged: (text) => {},
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 3),
                            isDense: true,
                            hintText: 'Edit Username',
                            border: InputBorder.none),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 30),
                const SizedBox(width: 100, child: Text('Gender')),
                const SizedBox(width: 10),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 16),
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 30),
                const SizedBox(width: 100, child: Text('Age')),
                const SizedBox(width: 10),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      height: 38,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: DropdownButton<String>(
                          alignment: Alignment.center,
                          isExpanded: true,
                          hint: widget.agegroup != ''
                              ? Text(widget.agegroup)
                              : const Text("Enter in Age"),
                          dropdownColor: Colors.white,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down),
                          items: ageList.map(buildMenuItem).toList(),
                          value: ageValue,
                          onChanged: (newValue) {
                            setState(() {
                              ageValue = newValue!;
                            });
                          })),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 30),
                const SizedBox(width: 100, child: Text('Location')),
                const SizedBox(width: 10),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 16),
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () {
                _editYourProfile().then(
                  (res) => (Navigator.pop(context)),
                );
              },
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child:
                    const Text('SAVE', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // attempt to dispose controller when Widget is disposed
    super.dispose();
    nameController.dispose();
  }

  buildItem(IconData? icon, String txt) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Icon(icon, size: 30),
        const SizedBox(width: 40),
        Text(txt),
        const Expanded(child: SizedBox()),
        const Icon(Icons.arrow_forward_ios, size: 20),
        const SizedBox(width: 10),
      ],
    );
  }
}
