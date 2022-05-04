import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/home_screen.dart';
import 'package:flutter_chodi_app/screens/user/user_initialize_screen.dart';
import 'package:flutter_chodi_app/services/shared_preferences_service.dart';
import 'package:flutter_chodi_app/widget/chodi_text.dart';

import '../configs/app_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Timer _timer;
  int time = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      time++;
      if (time >= 2) {
        _timer.cancel();
        SharedPreferencesService sha = SharedPreferencesService.instance;
        sha.getUserId().then((value) => {
              if (value <= 0)
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserInitializeScreen()),
                      (route) => false)
                }
              else
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false)
                }
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.31),
      decoration:
          const BoxDecoration(gradient: AppTheme.containerLinearGradient),
      child: const ChodiText(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
