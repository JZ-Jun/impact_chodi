import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/user.dart';
import 'package:flutter_chodi_app/screens/user/login_screen.dart';
import 'package:flutter_chodi_app/services/sqlite_service.dart';

import '../../configs/app_theme.dart';
import '../../widget/strip_guide_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  SqliteService sqliteService = SqliteService.instance;
  late User? user = ModalRoute.of(context)?.settings.arguments as User?;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                  top: MediaQuery.of(context).size.height * 0.035,
                  left: 20,
                  right: 20),
              child: const StripGuide(index: 2),
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
                    "Reset",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 39,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "password",
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
                "New Password",
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
                  obscureText: true,
                  style: const TextStyle(color: AppTheme.fontColor),
                  controller: passwordController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 3),
                      isDense: true,
                      border: InputBorder.none),
                )),
            const Padding(
              padding: EdgeInsets.only(bottom: 16, top: 16, left: 26),
              child: Text(
                "Confirm New Password",
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
                  obscureText: true,
                  style: const TextStyle(color: AppTheme.fontColor),
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 3),
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
                    "Confirm",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onTap: () {
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;
                  if (user?.id != null &&
                      password.isNotEmpty &&
                      confirmPassword.isNotEmpty &&
                      password == confirmPassword) {
                    user?.password = password;
                    sqliteService.updateUser(user!).then((value) => {
                          if (value == 1)
                            {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false)
                            }
                        });
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
