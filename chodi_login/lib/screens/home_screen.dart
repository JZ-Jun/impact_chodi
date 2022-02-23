import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/user/user_initialize_screen.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/log_out_button.dart';

import '../services/shared_preferences_service.dart';

class HomeSrceen extends StatefulWidget {
  const HomeSrceen({Key? key}) : super(key: key);

  @override
  State<HomeSrceen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeSrceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("homeScreen"),
          GestureDetector(
            child:
                const logOutWidget(), //log out function logs people from google and firebase
            onTap: () {
              SharedPreferencesService sharedPreferencesService =
                  SharedPreferencesService.instance;
              sharedPreferencesService.setUserId(-1);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInitializeScreen()),
                  (route) => false);
            },
          ),
        ],
      )),
    );
  }
}
