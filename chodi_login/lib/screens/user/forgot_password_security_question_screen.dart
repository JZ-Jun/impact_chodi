import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/user/reset_password_srceen.dart';
//import 'package:flutter_chodi_app/screens/user/reset_password_srceen.dart';
import 'package:flutter_chodi_app/services/firebase_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../configs/app_theme.dart';
import '../../models/user.dart';
import '../../widget/strip_guide_widget.dart';

class ForgotSecurityQuestionScreen extends StatefulWidget {
  final String email; //store email

  //This page requires an email input
  const ForgotSecurityQuestionScreen({Key? key, required this.email})
      : super(key: key);

  @override
  _ForgotSecurityQuestionScreenState createState() =>
      _ForgotSecurityQuestionScreenState();
}

class _ForgotSecurityQuestionScreenState
    extends State<ForgotSecurityQuestionScreen> {
  late User? user = ModalRoute.of(context)?.settings.arguments as User?;
  late TextEditingController securityQuestionController;
  late TextEditingController securityQuestionAnswerController;
  FirebaseService fbservice = FirebaseService();

  @override
  void initState() {
    super.initState();
    securityQuestionController = TextEditingController();
    securityQuestionAnswerController = TextEditingController();
  }

  Future<Map<String, dynamic>> getSecurityQuestion() async {
    Future<Map<String, dynamic>> question =
        FirebaseService().getSecurityQuestionAndAnswer(widget.email);

    return Future.delayed(const Duration(seconds: 1), () => question);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getSecurityQuestion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return _showToast("Something went wrong");
          } else {
            return Scaffold(
              body: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                decoration: const BoxDecoration(
                    gradient: AppTheme.containerLinearGradient),
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
                          top: MediaQuery.of(context).size.height * 0.035,
                          left: 20,
                          right: 20),
                      child: const StripGuide(index: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                              left: 20,
                              top: MediaQuery.of(context).size.height) *
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
                          bottom: 16,
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: 26),
                      child: const Text(
                        "Security Question",
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: securityQuestionController,
                          enabled: false,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 3),
                              isDense: true,
                              hintText: snapshot.data!["securityQuestion"],
                              border: InputBorder.none),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16, left: 26),
                      child: Text(
                        "Answer",
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: securityQuestionAnswerController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              hintText: "Input your answer",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (snapshot.data!["securityQuestionAnswer"] ==
                              securityQuestionAnswerController.text) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResetPasswordScreen(email: widget.email),
                                  settings: RouteSettings(arguments: user)),
                            );
                          } else {
                            _showToast("error");
                          }
                        },
                      ),
                    ))
                  ],
                ),
              ),
            );
          }
        }
      },
    );
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
