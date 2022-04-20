import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

/*
  Future<void> uploadOrganizationIconImages(
      String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('organizationIcons/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
  */

  Future<String> downloadURL(String imageName) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('organizationIcons/$imageName');

    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  //testing

}
