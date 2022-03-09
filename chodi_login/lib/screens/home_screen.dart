import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/user.dart';
import 'package:flutter_chodi_app/screens/user/user_initialize_screen.dart';
import 'package:flutter_chodi_app/services/firebase_service.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/log_out_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/shared_preferences_service.dart';

class HomeSrceen extends StatefulWidget {
  HomeSrceen({Key? key}) : super(key: key);

  @override
  State<HomeSrceen> createState() => _HomeScreenState();
}

Future<String> getFutureName() async {
  String name = await FirebaseService().getUsername();
  //String name = '';
  return Future.delayed(const Duration(seconds: 1), () => name);
}

class _HomeScreenState extends State<HomeSrceen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getFutureName(),
      builder: (context, snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return _showToast("Something went wrong");
          } else {
            return Scaffold(
              body: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HomeScreen " + snapshot.data!),
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
                              builder: (context) =>
                                  const UserInitializeScreen()),
                          (route) => false);
                    },
                  ),
                ],
              )),
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


/*
Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("homeScreen"),
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
    */