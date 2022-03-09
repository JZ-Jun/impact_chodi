//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/configs/app_theme.dart';
import 'package:flutter_chodi_app/screens/user/forgot_password_email_screen.dart';
import 'package:flutter_chodi_app/screens/user/sign_up_screen.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/google_authentication.dart';
import 'package:flutter_chodi_app/services/shared_preferences_service.dart';
import 'package:flutter_chodi_app/services/sqlite_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../widget/chodi_text.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SqliteService service = SqliteService.instance;
  bool _rememberMe = false;
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  bool _watchPassword = true;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //User from ../../models/user.dart
        body: StreamBuilder<User?>(
            stream: null,
            // FirebaseAuth.instance
            //     .authStateChanges(), //check user firebase login state
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                //user has signed into chodi firebase
                _showToast("success");

                return HomeScreen();
              } else if (snapshot.hasError) {
                return _showToast("Something went wrong");
              } else {
                //user is not signed in to chodi firebase
                /* might want to test logging in/signing up with email/password to see
                if the route works after signing up (to firebase eventually)?*/
                return Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 16,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  decoration: const BoxDecoration(
                      gradient: AppTheme.containerLinearGradient),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Welcome back!",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.09),
                      ),
                      const ChodiText(),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 16),
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08,
                        ),
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: AppTheme.fontColor),
                          controller: userNameController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 3),
                              hintText: 'Email/Username',
                              isDense: true,
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 16),
                        margin: const EdgeInsets.only(top: 16),
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 22,
                              width: 130,
                              child: TextField(
                                style:
                                    const TextStyle(color: AppTheme.fontColor),
                                obscureText: _watchPassword,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 3),
                                    hintText: 'Password',
                                    isDense: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Material(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10.0),
                                    radius: 50,
                                    splashColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child: Image.asset(
                                      "assets/images/eye_off.png",
                                      width: 13,
                                      height: 13,
                                      fit: BoxFit.fill,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _watchPassword = !_watchPassword;
                                      });
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 13),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Transform.scale(
                                scale: 0.6,
                                child: Checkbox(
                                    value: _rememberMe,
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

                                      return Colors.white;
                                    }),
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    }),
                              ),
                              width: 8,
                              height: 8,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 12, color: AppTheme.fontColor),
                                )),
                            const Expanded(child: SizedBox()),
                            GestureDetector(
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 12, color: AppTheme.fontColor),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordEmailScreen()),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 26, right: 26, top: 10, bottom: 10),
                          margin: const EdgeInsets.only(top: 47),
                          decoration: const BoxDecoration(
                              color: Color(0xFF76D6E1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          service
                              .getUser(userNameController.text.toString(),
                                  userNameController.text.toString())
                              .then((value) => {
                                    if (value.id == null ||
                                        passwordController.text !=
                                            value.password)
                                      _showToast('wrong account or password')
                                    else if (passwordController.text.isEmpty ||
                                        userNameController.text.isEmpty)
                                      _showToast('cannot be empty')
                                    else
                                      {
                                        if (_rememberMe)
                                          {
                                            SharedPreferencesService.instance
                                                .setUserId(value.id as int)
                                          },
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()),
                                            (route) => false)
                                      }
                                  });
                        },
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom + 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Or Connect With",
                              style: TextStyle(color: AppTheme.fontColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 6),
                              child: GestureDetector(
                                  child: SvgPicture.asset(
                                    "assets/svg/google.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                  onTap: () {
                                    final provider =
                                        Provider.of<GoogleAuthentication>(
                                            context,
                                            listen: false);
                                    provider.googleLogin();
                                  }),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New to ChoDi?",
                                  style: TextStyle(color: AppTheme.fontColor),
                                ),
                                GestureDetector(
                                  child: const Text(
                                    " Sign up",
                                    style: TextStyle(color: Color(0xFF0000FF)),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              }
            }));
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
