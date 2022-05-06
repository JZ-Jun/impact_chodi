import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:flutter_chodi_app/screens/user/login_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/log_out_button.dart';
import 'package:r_calendar/r_calendar.dart';

import 'edit_profile_screen.dart';
import 'my_events_screen.dart';
import 'my_favorite_screen.dart';
import 'my_setting_screen.dart';

class profile_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profile_screenState();
  }
}

class profile_screenState extends State<profile_screen> {
  FirebaseAuth _user = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('C', style: TextStyle(fontSize: 25, color: Colors.yellow)),
            Text('H', style: TextStyle(fontSize: 25, color: Colors.orange)),
            Text('O', style: TextStyle(fontSize: 25, color: Colors.red)),
            Text('D', style: TextStyle(fontSize: 25, color: Colors.blue)),
            Text('I', style: TextStyle(fontSize: 25, color: Colors.green))
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Icon(Icons.account_circle, size: 80),
          SizedBox(height: 10),
          logOutWidget(),
          SizedBox(height: 20),
          Container(height: 1, color: Colors.grey.shade200),
          SizedBox(height: 20),
          buildItem(0, Icons.account_circle, 'Edit Profile'),
          SizedBox(height: 15),
          buildItem(1, Icons.calendar_month, 'My event'),
          SizedBox(height: 15),
          buildItem(2, Icons.people, 'My favorite community'),
          SizedBox(height: 15),
          buildItem(3, Icons.settings, 'Setting and privacy'),
          SizedBox(height: 20),
          Container(height: 1, color: Colors.grey.shade200),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.phone, size: 30),
              SizedBox(width: 40),
              _user.currentUser!.phoneNumber != null
                  ? Text(_user.currentUser!.phoneNumber.toString())
                  : const Text(""),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.email, size: 30),
              SizedBox(width: 40),
              Text(_user.currentUser!.email.toString()),
            ],
          )
        ],
      ),
    );
  }

  buildItem(int index, IconData? icon, String txt) {
    return GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return edit_profile_screen();
              }));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return my_events_screen();
              }));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return my_favorite_screen();
              }));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return my_setting_screen();
              }));
              break;
            default:
          }
        },
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(icon, size: 30),
            SizedBox(width: 40),
            Text(txt),
            Expanded(child: SizedBox()),
            Icon(Icons.arrow_forward_ios, size: 20),
            SizedBox(width: 10),
          ],
        ));
  }
}
