import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer'; //for printing

//This class should handle the process for logging in using google

/*
notes for Google Authentication 
-follow firebase set-up instructions, enable google in firebase
    -need google-services.json file in /android/app
    -SHA-1 Certificate fingerprints for debug
-main.dart - initalize firebase app asynchronously
-on tap (or button press), sign in using _googleSignIn().signIn()
-update minSdkVersion to at least 19 in /android/app/build.gradle
-dependencies used in pubspec.yaml for google login: 
  firebase_core: ^1.12.0
  firebase_auth: ^3.3.7
  cloud_firestore: ^3.1.8
  google_sign_in: ^5.2.3
  provider: ^6.0.2
AVD Emulator with google play service
*/

class GoogleAuthentication extends ChangeNotifier {
  // final _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  //Extract user information from _user
  // GoogleSignInAccount? _user;
//  GoogleSignInAccount get user => _user!;

  //Future allows to run work asynchronously
  Future googleLogin() async {
    //  final googleUser = await _googleSignIn.signIn();

    //   if (googleUser == null) return;

    //  _user = googleUser; //otherwise get user

    //  final googleAuth = await googleUser.authentication;

    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //
    //   //need accessToken and idToken
    //   final authResult = await _auth.signInWithCredential(credential);
    //
    //   if (authResult.additionalUserInfo!.isNewUser) {
    //     //add initial data fields to Firebase here if a new user has signed in
    //     //addGoogleUserData(credential.idToken);
    //
    //     log("New user!"); //TO DELETE LATER
    //   }
    //
    //   notifyListeners();
    // }

    // Future<bool> isLoggedIn() async {
    //   if (_user != null) {
    //     return true;
    //   }
    //   return false;
    // }

    //log out function implemented for Google
    // Future googleLogOut() async {
    //   _googleSignIn.isSignedIn().then((sBool) {
    //     log("Signed Out"); //TO DELETE LATER
    //     signOutWithGoogle();
    //   });
    // }

    //sign out funciton implemented for Google
    // Future signOutWithGoogle() async {
    //   await _googleSignIn.disconnect();
    //   await _googleSignIn.signOut(); //sign out from google
    //   await _auth.signOut(); //sign out from firebase
    // }

    //add user to Firebase
    // Future addGoogleUserData(String? idToken) async {
    //   //CHANGE THIS TO FIT THE CHODI DATABASE LATER
    //   final user = FirebaseAuth.instance.currentUser;
    //   if (user != null) {
    //     CollectionReference chodiUsers = FirebaseFirestore.instance
    //         .collection('EndUsers'); //change to different collection
    //
    //     Map<String, dynamic>? idMap = getGivenAndFamilyName(idToken!);
    //
    //     chodiUsers.add({
    //       "Email": user.email,
    //       "Username": user.displayName,
    //       "FirstName": idMap!["given_name"],
    //       "LastName": idMap["family_name"],
    //     });
    //   }
    // }

    //get "given_name" and "family_name" using idtoken
    // static Map<String, dynamic>? getGivenAndFamilyName(String token) {
    //   // validate token
    //   final List<String> parts = token.split('.');
    //   if (parts.length != 3) {
    //     return null;
    //   }
    //   // retrieve token payload
    //   final String payload = parts[1];
    //   final String normalized = base64Url.normalize(payload);
    //   final String resp = utf8.decode(base64Url.decode(normalized));
    //   // convert to Map
    //   final payloadMap = json.decode(resp);
    //   if (payloadMap is! Map<String, dynamic>) {
    //     return null;
    //   }
    //   return payloadMap;
    // }
  }
}
