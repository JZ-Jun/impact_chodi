import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/home_screen.dart';
import 'package:flutter_chodi_app/screens/user/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: library_prefixes
import 'package:flutter_chodi_app/models/user.dart' as ChodiUser;

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future userSignUp(ChodiUser.User user, BuildContext context) async {
    Map<String, Object?> userMap = user.toMap();
    String email = userMap["email"].toString();
    String password = userMap["password"].toString();
    String username = userMap["username"].toString();
    String age = userMap["age"].toString();
    String securityQuestion = userMap["securityQuestion"].toString();
    String securityQuestionAnswer =
        userMap["securityQuestionAnswer"].toString();

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
                      "Password": password,
                      "Username": username,
                      "Age": age,
                      "SecurityQuestion": securityQuestion,
                      "SecurityQuestionAnswer": securityQuestionAnswer,
                    })
                  }
              });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeSrceen()));
    } on Exception catch (e) {
      _showToast("email account is already in use");
    }

    notifyListeners();
  }

  Future userSignIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _showToast("Invalid email or password");
    }
  }

  Future userLogOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future resetPassword(String email, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showToast("Password Reset Email was sent");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuth catch (e) {
      Navigator.of(context).pop();
      _showToast("account does not exist");
    }
  }

  Future<bool> checkIfEmailExistsInFirebase(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await _auth.fetchSignInMethodsForEmail(email);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Existing user address in firebase
        return true;
      } else {
        // user address not in firebase
        return false;
      }
    } catch (error) {
      _showToast("error");
      return true;
    }
  }

  Future<ChodiUser.User?> getDataOfCurrentUser() async {
    if (_auth.currentUser != null) {
      String userId = await _auth.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> personalInfo =
          await FirebaseFirestore.instance
              .collection('EndUsers')
              .doc(userId)
              .get();

      final chodiUser = ChodiUser.User(
        email: personalInfo["Email"],
        userName: personalInfo["Username"],
        age: int.parse(personalInfo['Age']),
        password: '',
        securityQuestionAnswer: personalInfo["SecurityQuestionAnswer"],
        securityQuestion: personalInfo["SecurityQuestion"],
      );
      return chodiUser;
    }
    return null;
  }

  Future getDataOfUserGivenEmail(String email) async {
    await checkIfEmailExistsInFirebase(email).then((value) => {});

    return null;
  }

  Future<String> getSecurityQuestion() async {
    //this function doesn't work currently because the user isn't logged in
    //so we need to create a function that gets the user data given a user uid
    ChodiUser.User? user = await getDataOfCurrentUser();
    Map<String, Object?> userMap = user!.toMap();
    String securityQuestion = userMap["securityQuestion"].toString();
    return securityQuestion;
  }

  Future<String> getUsername() async {
    ChodiUser.User? user = await getDataOfCurrentUser();
    Map<String, Object?> userMap = user!.toMap();
    String username = userMap["userName"].toString();
    return username;
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
}
