import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/configs/app_theme.dart';
import 'package:flutter_chodi_app/models/user.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var ageValue;
  List<String> ageList = _createAgeList();

  bool _checkboxValue = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController userNameController;
  late TextEditingController securityQuestionController;
  late TextEditingController securityQuestionAnswerController;

  FirebaseService fbservice = FirebaseService();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userNameController = TextEditingController();
    securityQuestionController = TextEditingController();
    securityQuestionAnswerController = TextEditingController();
  }

  DropdownMenuItem<String> buildMenuItem(String ageValue) => DropdownMenuItem(
      value: ageValue,
      child: Text(ageValue, style: const TextStyle(color: AppTheme.fontColor)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:
            const BoxDecoration(gradient: AppTheme.containerLinearGradient),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                        left: 20, top: MediaQuery.of(context).size.height) *
                    0.02,
                child: const Text(
                  "Sign up to ChoDi",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 39,
                      decoration: TextDecoration.none),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.038,
                    right: MediaQuery.of(context).size.width * 0.038),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 30, left: 13),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: emailController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              hintText: 'Enter your email',
                              border: InputBorder.none),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 13, left: 16),
                      child: Text(
                        "User Name",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: userNameController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              hintText: 'Enter your username',
                              border: InputBorder.none),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 13, left: 16),
                      child: Text(
                        "Age",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: DropdownButton<String>(
                            alignment: Alignment.center,
                            isExpanded: true,
                            hint: const Text("Enter your age"),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 13, left: 16),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              border: InputBorder.none),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 13, left: 16),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          obscureText: true,
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              border: InputBorder.none),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 13, left: 16),
                      child: Text(
                        "Security Question",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: securityQuestionController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              hintText: 'Enter your favorite question',
                              border: InputBorder.none),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13, top: 13, left: 16),
                      child: Text(
                        "Security Question Answer",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        height: 38,
                        decoration: const BoxDecoration(
                            color: AppTheme.editTextColors,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: securityQuestionAnswerController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              isDense: true,
                              hintText: 'Enter your security question answer',
                              border: InputBorder.none),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                color: Colors.white,
                                child: Transform.scale(
                                  scale: 0.6,
                                  child: Checkbox(
                                      value: _checkboxValue,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (Set<MaterialState> states) {
                                        const Set<MaterialState>
                                            interactiveStates = <MaterialState>{
                                          MaterialState.pressed,
                                          MaterialState.hovered,
                                          MaterialState.focused,
                                        };
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return ThemeData.from(
                                                  colorScheme:
                                                      const ColorScheme.light())
                                              .disabledColor;
                                        }
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return ThemeData()
                                              .toggleableActiveColor;
                                        }
                                        if (states
                                            .any(interactiveStates.contains)) {
                                          return Colors.red;
                                        }
                                        // 最终返回
                                        return Colors.white;
                                      }),
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxValue = value!;
                                        });
                                      }),
                                ),
                                width: 8,
                                height: 8,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "I agree with Terms and Privacy",
                              style: TextStyle(color: AppTheme.fontColor),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: GestureDetector(
                  child: Container(
                    width: 130,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    decoration: const BoxDecoration(
                        color: Color(0xFF76D6E1),
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    if (_checkNull()) {
                      _showToast("cannot be empty");
                    } else if (!_validateEmail()) {
                      _showToast("email error");
                    } else if (!_checkPassword()) {
                      _showToast("password error");
                    } else if (passwordController.text.length < 6) {
                      _showToast("password must be min 6 character long");
                    } else if (!_checkboxValue) {
                      _showToast("Please agree to the Terms and Privacy");
                    } else {
                      chodiUser user = chodiUser(
                        email: emailController.text,
                        username: userNameController.text,
                        age: ageValue,
                        securityQuestionAnswer:
                            securityQuestionAnswerController.text,
                        securityQuestion: securityQuestionController.text,
                        registeredFor: {},
                        lastUpdated: Timestamp.now(),
                      );

                      final provider =
                          Provider.of<FirebaseService>(context, listen: false);
                      provider.userSignUp(
                          user, passwordController.text, context);
                    }
                  },
                ),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: AppTheme.fontColor),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color(0xFF0000FF)),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                    )
                  ]),
              const SizedBox(
                height: 16,
              )
            ],
          ),
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

  bool _checkPassword() {
    return passwordController.text == confirmPasswordController.text;
  }

  bool _checkNull() {
    return emailController.text.trim().isEmpty ||
        userNameController.text.isEmpty ||
        ageValue == null ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        securityQuestionController.text.isEmpty ||
        securityQuestionAnswerController.text.isEmpty;
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

List<String> _createAgeList() {
  List<String> list = [
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

  return list;
}
