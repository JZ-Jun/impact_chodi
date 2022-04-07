import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/activity.dart';
import 'package:flutter_chodi_app/screens/home_screen.dart';
import 'package:flutter_chodi_app/screens/user/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: library_prefixes
import 'package:flutter_chodi_app/models/user.dart' as ChodiUser;

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Sign-up/Login Methods
  Future userSignUp(
      ChodiUser.User user, String password, BuildContext context) async {
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
  Future<ChodiUser.User?> getDataOfCurrentUser() async {
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
        final chodiUser = ChodiUser.User(
          email: personalInfo["Email"],
          username: personalInfo["Username"],
          age: '',
          securityQuestion: '',
          securityQuestionAnswer: '',
        );
        return chodiUser;
      } else {
        final chodiUser = ChodiUser.User(
          email: personalInfo["Email"],
          username: personalInfo["Username"],
          age: personalInfo['Age'],
          securityQuestionAnswer: personalInfo["SecurityQuestionAnswer"],
          securityQuestion: personalInfo["SecurityQuestion"],
        );
        return chodiUser;
      }
    }
    return null;
  }

  Future<String> getUsername() async {
    ChodiUser.User? user = await getDataOfCurrentUser();
    String username = user!.username;
    return username;
  }

  //User is not currently logged in but needs information based on the email
  Future<ChodiUser.User?> getDataOfUserGivenEmail(String email) async {
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
              final chodiUser = ChodiUser.User(
                email: allData[i]["Email"],
                username: allData[i]["Username"],
                age: allData[i]['Age'],
                securityQuestionAnswer: allData[i]["SecurityQuestionAnswer"],
                securityQuestion: allData[i]["SecurityQuestion"],
              );
              return chodiUser;
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
      ChodiUser.User? user = await getDataOfUserGivenEmail(email);
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

  Future<void> getDataGivenDocumentID() async {
    DocumentSnapshot<Map<String, dynamic>> personalInfo =
        await FirebaseFirestore.instance
            .collection('EndUsers')
            .doc(exampleID)
            .get();

    print(personalInfo);
  }

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
}
