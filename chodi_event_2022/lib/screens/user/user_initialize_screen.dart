import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/user/login_screen.dart';
import 'package:flutter_chodi_app/screens/user/sign_up_screen.dart';

import '../../configs/app_theme.dart';
import '../../widget/chodi_text.dart';

class UserInitializeScreen extends StatefulWidget {
  const UserInitializeScreen({Key? key}) : super(key: key);

  @override
  _UserInitializeScreenState createState() => _UserInitializeScreenState();
}

class _UserInitializeScreenState extends State<UserInitializeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
      decoration:
          const BoxDecoration(gradient: AppTheme.containerLinearGradient),
      child: Column(
        children: [
          const ChodiText(),
          GestureDetector(
            child: Container(
              width: 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.12),
              decoration: const BoxDecoration(
                  color: Color(0xFF76D6E1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
          ),
          GestureDetector(
            child: Container(
              width: 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              margin: const EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(
                  color: Color(0xFF76D6E1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
            },
          )
        ],
      ),
    );
  }
}
