import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Storage {
  FirebaseStorage storage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    final ref = FirebaseStorage.instance.ref('organizationIcons/$imageName');

    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<String?> uploadImageToStorage(XFile image) async {
    String downloadURL;
    final ref =
        FirebaseStorage.instance.ref('profileIcons/${_auth.currentUser!.uid}');

    ref.putFile(File(image.path));

    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<String?> uploadImageToFirestore(String downloadURL) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference endUsers =
          FirebaseFirestore.instance.collection('EndUsers');

      //assume Favorites doc is already created
      await endUsers.doc(user.uid).update({"imageURL": downloadURL});
    }
    return null;
  }

  //testing

}
