// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../configs/app_theme.dart';

class set_pw_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return set_pw_screenState();
  }
}

class set_pw_screenState extends State<set_pw_screen> {
  final FirebaseAuth _user = FirebaseAuth.instance;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmController;
  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              Container(height: 1, color: Colors.grey.shade200),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 15),
                  const SizedBox(width: 150, child: Text('Password')),
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
                            controller: oldPasswordController,
                            onChanged: (text) => {},
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 3),
                                isDense: true,
                                border: InputBorder.none),
                          ))),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 15),
                  const SizedBox(width: 150, child: Text('Set New Password')),
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
                            controller: newPasswordController,
                            onChanged: (text) => {},
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 3),
                                isDense: true,
                                border: InputBorder.none),
                          ))),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 15),
                  const SizedBox(
                      width: 150, child: Text('Confirm New Password')),
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
                            controller: confirmController,
                            onChanged: (text) => {},
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 3),
                                isDense: true,
                                border: InputBorder.none),
                          ))),
                ],
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  if (_validateCurrentPassword(oldPasswordController.text) ==
                      null) {
                    _showToast("Password is not validated");
                  }
                  if (newPasswordController.text.length < 6) {
                    _showToast("Password must be min 6 characters long");
                  } else if (newPasswordController.text !=
                      confirmController.text) {
                    _showToast("Make sure your password is correct");
                  } else {
                    updateUserPassword(confirmController.text);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: const Text('UPDATE',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // attempt to dispose controller when Widget is disposed
    super.dispose();
    newPasswordController.dispose();
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

  Future<bool> _validateCurrentPassword(String password) async {
    var currentChodiUser = _user.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: currentChodiUser!.email!, password: oldPasswordController.text);
    var authResult =
        await currentChodiUser.reauthenticateWithCredential(authCredentials);

    return authResult.user != null;
  }

  Future updateUserPassword(String newPassword) async {
    var currentChodiUser = _user.currentUser;
    currentChodiUser!.updatePassword(newPassword);
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
