import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/home_screen.dart';
import 'package:flutter_chodi_app/screens/user/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: library_prefixes
import 'package:flutter_chodi_app/models/user.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Sign-up/Login Methods
  Future userSignUp(
      chodiUser user, String password, BuildContext context) async {
    String email = user.email;
    String username = user.username;
    String age = user.age;
    String securityQuestion = user.securityQuestion;
    String securityQuestionAnswer = user.securityQuestionAnswer;

    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) async => {
                if (_auth.currentUser != null)
                  {
                    //add to database
                    await FirebaseFirestore.instance
                        .collection('EndUsers')
                        .doc(credential.user!.uid)
                        .set({
                      "Email": email,
                      "Username": username,
                      "Age": age,
                      "SecurityQuestion": securityQuestion,
                      "SecurityQuestionAnswer": securityQuestionAnswer,
                      "lastUpdated": Timestamp.now(),
                      "imageURL": '',
                      "Gender": '',
                    }).then((res) async => {
                              await FirebaseFirestore.instance
                                  .collection('Favorites')
                                  .doc(credential.user!.uid)
                                  .set({
                                "Favorite Organizations": [],
                                "Favorite Events": {},
                              })
                            })
                  }
              });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on Exception {
      _showToast("Email account is already in use");
    }

    notifyListeners();
  }

  Future userSignIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      _showToast("Invalid email or password");
    }
  }

  //log out users out of email/password - does not log out users that sign in with google
  Future userLogOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Future<bool> checkIfEmailExistsInFirebase(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await _auth.fetchSignInMethodsForEmail(email);

      debugPrint(list[0]);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Existing user address in firebase
        return true;
      } else {
        // user address not in firebase
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future resetPassword(String email, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showToast("Password Reset Email Sent");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException {
      Navigator.of(context).pop();
      _showToast("Account does not exist");
    }
  }

//User must be logged in to use the this function
//Does not access the subcollections of the User
  Future<chodiUser?> getDataOfCurrentUser() async {
    if (_auth.currentUser != null) {
      String userId = _auth.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> personalInfo =
          await FirebaseFirestore.instance
              .collection('EndUsers')
              .doc(userId)
              .get();

      if (personalInfo['Age'] == null ||
          (personalInfo["SecurityQuestionAnswer"] == null ||
              personalInfo['SecurityQuestion'] == null)) {
        final chodiuser = chodiUser(
          email: personalInfo["Email"],
          username: personalInfo["Username"],
          age: '',
          securityQuestion: '',
          securityQuestionAnswer: '',
          registeredFor: personalInfo["registeredFor"],
          lastUpdated: personalInfo["lastUpdated"],
        );
        return chodiuser;
      } else {
        final chodiuser = chodiUser(
          email: personalInfo["Email"],
          username: personalInfo["Username"],
          age: personalInfo['Age'],
          securityQuestionAnswer: personalInfo["SecurityQuestionAnswer"],
          securityQuestion: personalInfo["SecurityQuestion"],
          registeredFor: personalInfo["registeredFor"],
          lastUpdated: personalInfo["lastUpdated"],
        );
        return chodiuser;
      }
    }
    return null;
  }

  Future<String> getUsername() async {
    chodiUser? user = await getDataOfCurrentUser();
    String username = user!.username;
    return username;
  }

  //User is not currently logged in but needs information based on the email
  Future<chodiUser?> getDataOfUserGivenEmail(String email) async {
    if (await checkIfEmailExistsInFirebase(email)) {
      CollectionReference securityQuestionData =
          FirebaseFirestore.instance.collection("EndUsers");

      QuerySnapshot querySnapshot = await securityQuestionData.get();

      //turn into List
      List<dynamic> allData =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      //only 1 email per chodi account
      for (var i = 0; i < allData.length; i++) {
        if (allData[i]['Email'] == email) {
          final list = await _auth.fetchSignInMethodsForEmail(email);

          //search login provider: google.com
          for (var pIndex = 0; pIndex < list.length; pIndex++) {
            //if email used is not google-authenticated
            if (list[pIndex] != 'google.com') {
              final chodiuser = chodiUser(
                  email: allData[i]["Email"],
                  username: allData[i]["Username"],
                  age: allData[i]['Age'],
                  securityQuestionAnswer: allData[i]["SecurityQuestionAnswer"],
                  securityQuestion: allData[i]["SecurityQuestion"],
                  registeredFor: allData[i]["registeredFor"],
                  lastUpdated: allData[i]["lastUpdated"]);
              return chodiuser;
            }
          }
        }
      }
    }

    return null;
  }

  //User is not currently logged
  //Returns a map containing both the security question and security question answer
  Future<Map<String, dynamic>> getSecurityQuestionAndAnswer(
      String email) async {
    if (await getDataOfUserGivenEmail(email) != null) {
      chodiUser? user = await getDataOfUserGivenEmail(email);
      String securityQuestion = user!.securityQuestion;
      String securityQuestionAnswer = user.securityQuestionAnswer;
      return {
        "securityQuestion": securityQuestion,
        "securityQuestionAnswer": securityQuestionAnswer
      };
    }

    return {"securityQuestion": null, "securityQuestionAnswer": null};
  }

  _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xFF76D6E1),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //BELOW ARE METHODS FOR TESTING PURPOSES
  static const exampleID = 'aoeh5HZzZqcqhLn2iugc';

  Future<List<dynamic>> getUserRecentHistoryData() async {
    List<dynamic> allData = [];

    QuerySnapshot<dynamic> history = await FirebaseFirestore.instance
        .collection("EndUsers")
        .doc(exampleID)
        .collection("History")
        .orderBy("date", descending: true) //change field to createdAt?
        .get();
    for (var postDoc in history.docs) {
      final data = postDoc.data();
      allData.add(data);
    }

    return allData;
  }

  Future<List<dynamic>> getUserSupportedOrganizationsData() async {
    List<dynamic> allData = [];

    QuerySnapshot organization = await FirebaseFirestore.instance
        .collection("EndUsers")
        .doc(exampleID)
        .collection("SupportedOrganizations")
        .get();
    for (var postDoc in organization.docs) {
      final data = postDoc.data();
      allData.add(data);
    }

    return allData;
  }

//Grab data from Firebase
//Organization
  Future addUserFavoriteOrganizationData(var ein) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('Favorites');

      //assume Favorites doc is already created
      await favorites.doc(user.uid).update({
        "Favorite Organizations": FieldValue.arrayUnion([ein]),
        //add to Favorited Organizations array
      });
    }
  }

  Future addUserFavoriteOrganizationDataSubcollection(var ein) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference favorites = FirebaseFirestore.instance
          .collection("EndUsers/" + user.uid + "/Favorites");

      await favorites.doc(ein).set({
        "EIN": ein,
        "eventCode": '',
        "isOrg": true,
      });
    }
  }

  Future removeUserFavoriteOrganizationData(var ein) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('Favorites');

      //assume Favorites doc is already created
      await favorites.doc(user.uid).update({
        "Favorite Organizations": FieldValue.arrayRemove([ein]),
      });
    }
  }

  Future removeUserFavoriteOrganizationDataSubcollection(var ein) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference favorites = FirebaseFirestore.instance
          .collection("EndUsers/" + user.uid + "/Favorites");

      //assume Favorites doc is already created
      await favorites.doc(ein).delete();
    }
  }

//Event
  Future addUserFavoriteEvent(var ein, var eventID) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('Favorites');

      //assume Favorites doc is already created
      await favorites.doc(user.uid).update({
        'Favorite Events.$eventID': ein,
      });
    }
  }

  Future addUserFavoriteEventSubcollection(var ein, var eventCode) async {
    final user = _auth.currentUser;
    if (user != null) {
      CollectionReference favorites = FirebaseFirestore.instance
          .collection("EndUsers/" + user.uid + "/Favorites");

      await favorites.doc(eventCode).set({
        "EIN": ein,
        "eventCode": eventCode,
        "isOrg": false,
      });
    }
  }

  Future removeUserFavoriteEvent(var eventID) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('Favorites');

      //assume Favorites doc is already created
      await favorites.doc(user.uid).update({
        'Favorite Events.$eventID': FieldValue.delete(),
      });
    }
  }

  Future removeUserFavoriteEventSubcollection(var eventCode) async {
    final user = _auth.currentUser;
    if (user != null) {
      CollectionReference favorites = FirebaseFirestore.instance
          .collection("EndUsers/" + user.uid + "/Favorites");

      await favorites.doc(eventCode).delete();
    }
  }

  //Registration for Event
  Future registerForEvent(var eventID, var ngoEIN) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference endUsers =
          FirebaseFirestore.instance.collection('EndUsers');

      await endUsers.doc(user.uid).update({
        'registeredFor.$eventID': Timestamp.now(),
      });

      CollectionReference events =
          FirebaseFirestore.instance.collection('Events (User)');

      await events.doc(eventID).update({
        'attendees.${user.uid}': user.email,
      });
    }
  }

  Future unregisterForEvent(var eventID, var ngoEIN) async {
    final user = _auth.currentUser;

    if (user != null) {
      CollectionReference endUsers =
          FirebaseFirestore.instance.collection('EndUsers');

      //assume Favorites doc is already created
      await endUsers.doc(user.uid).update({
        'registeredFor.$eventID': FieldValue.delete(),
      });

      CollectionReference events =
          FirebaseFirestore.instance.collection('Events (User)');

      await events.doc(eventID).update({
        //delete according to current user's uid
        'attendees.${user.uid}': FieldValue.delete(),
      });
    }
  }
}
