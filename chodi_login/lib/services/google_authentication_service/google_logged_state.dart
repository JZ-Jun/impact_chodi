import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chodi_app/screens/home_screen.dart';
import 'dart:developer';

import 'package:flutter_chodi_app/screens/welcome_screen.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/log_out_button.dart';

class GoogleLoggedState extends StatelessWidget {
  const GoogleLoggedState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Google sign up/login navigation
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                //go to new page after logging in
                log("google user has signed so go to new page");
                return logOutWidget();
              } else if (snapshot.hasError) {
                log("Something went wrong");
                return const Center(child: Text('Something went wrong!'));
              } else {
                log("No data and no error"); //change this later?
                return Text('');
              }
            }));
  }
}
