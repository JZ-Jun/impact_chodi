import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/configs/app_theme.dart';
import 'package:flutter_chodi_app/models/user.dart';
import 'package:flutter_chodi_app/screens/user/forgot_password_security_question_screen.dart';
import 'package:flutter_chodi_app/services/firebase_service.dart';
import 'package:flutter_chodi_app/widget/strip_guide_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordEmailScreenState createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  FirebaseService fbservice = FirebaseService();
  late TextEditingController emailController;
  late User user;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16),
        decoration:
            const BoxDecoration(gradient: AppTheme.containerLinearGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: 20,
                  right: 20),
              child: const StripGuide(index: 0),
            ),
            Padding(
              padding: EdgeInsets.only(
                      left: 20, top: MediaQuery.of(context).size.height) *
                  0.035,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Forgot",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 39,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "password?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 39,
                        decoration: TextDecoration.none),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20,
                  top: MediaQuery.of(context).size.height * 0.11,
                  left: 26),
              child: const Text(
                "Email",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 16),
                height: 38,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: const TextStyle(color: AppTheme.fontColor),
                  controller: emailController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 3),
                      hintText: 'Enter your email',
                      isDense: true,
                      border: InputBorder.none),
                )),
            Expanded(
                child: Center(
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  margin: const EdgeInsets.only(top: 47),
                  decoration: const BoxDecoration(
                      color: Color(0xFF76D6E1),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onTap: () async {
                  if (_validateEmail() &&
                      await fbservice
                          .checkIfEmailExistsInFirebase(emailController.text)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotSecurityQuestionScreen(
                                email: emailController.text)));
                  } else {
                    _showToast("Invalid email");
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  //should be fixed later. Emails such as uciID@gmail.edy or uciID@gmail.e get accepted.
  bool _validateEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(emailController.text);
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
