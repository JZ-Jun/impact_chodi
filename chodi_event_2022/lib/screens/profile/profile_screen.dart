import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/models/user.dart';
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

// ignore: camel_case_types
class profile_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profile_screenState();
  }
}

// ignore: camel_case_types
class profile_screenState extends State<profile_screen> {
  final FirebaseAuth _user = FirebaseAuth.instance;

//"Oie3XAw1g3VZUaH6oNXWCVIwFre2"
  late Stream dataList;
  @override
  void initState() {
    dataList = FirebaseFirestore.instance
        .collection("EndUsers")
        .doc(_user.currentUser!.uid)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('C',
                        style: TextStyle(fontSize: 25, color: Colors.yellow)),
                    Text('H',
                        style: TextStyle(fontSize: 25, color: Colors.orange)),
                    Text('O',
                        style: TextStyle(fontSize: 25, color: Colors.red)),
                    Text('D',
                        style: TextStyle(fontSize: 25, color: Colors.blue)),
                    Text('I',
                        style: TextStyle(fontSize: 25, color: Colors.green))
                  ],
                ),
                centerTitle: true,
                backgroundColor: Colors.grey.shade400,
                elevation: 0,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  snapshot.data["imageURL"] != null ||
                          snapshot.data["imageURL"] != ''
                      ? CachedNetworkImage(
                          imageUrl: snapshot.data["imageURL"],
                          width: 80,
                          height: 80, //testing image
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 80,
                          ),
                        )
                      : const Icon(Icons.account_circle),
                  const SizedBox(height: 10),
                  const logOutWidget(),
                  const SizedBox(height: 20),
                  Container(height: 1, color: Colors.grey.shade200),
                  const SizedBox(height: 20),
                  buildItem(
                      0,
                      Icons.account_circle,
                      'Edit Profile',
                      snapshot.data["imageURL"],
                      snapshot.data["Username"] ?? '',
                      snapshot.data["Age"] ?? '',
                      snapshot.data["Gender"] ?? ''),
                  const SizedBox(height: 15),
                  buildItem(1, Icons.calendar_month, 'Registered Events', '',
                      '', '', ''),
                  const SizedBox(height: 15),
                  buildItem(
                      2, Icons.people, 'Favorite Communities', '', '', '', ''),
                  const SizedBox(height: 15),
                  buildItem(3, Icons.settings, 'Settings', '', '', '', ''),
                  const SizedBox(height: 20),
                  Container(height: 1, color: Colors.grey.shade200),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      SizedBox(width: 10),
                      Icon(Icons.phone, size: 30),
                      SizedBox(width: 40),
                      Text("+1 (239) 876-554"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      SizedBox(width: 10),
                      Icon(Icons.email, size: 30),
                      SizedBox(width: 40),
                      Text("191abChoDi@gmail.com"),
                    ],
                  )
                ],
              ),
            );
          }
        });
  }

  buildItem(int index, IconData? icon, String txt, String imageURL,
      String username, String age_group, String gender) {
    return GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return edit_profile_screen(
                  savedProfileImageURL: imageURL,
                  username: username,
                  agegroup: age_group,
                  gender: gender,
                );
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
            const SizedBox(width: 10),
            Icon(icon, size: 30),
            const SizedBox(width: 40),
            Text(txt),
            const Expanded(child: SizedBox()),
            const Icon(Icons.arrow_forward_ios, size: 20),
            const SizedBox(width: 10),
          ],
        ));
  }
}
