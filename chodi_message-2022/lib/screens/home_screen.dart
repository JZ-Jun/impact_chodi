import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';

import 'package:flutter_chodi_app/screens/calendar/calendar_screen.dart';
import 'package:flutter_chodi_app/screens/foryou/for_you_screen.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/viewmodel/main_view_model.dart';
import 'messages/messages_screen.dart';
import 'package:provider/provider.dart';
import '../configs/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<String> getFutureName() async {
  String name = await FirebaseService().getUsername();
  //String name = '';
  return Future.delayed(const Duration(seconds: 1), () => name);
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Colors.blue;
    if (_currentIndex == 0) {
      selectedColor = Colors.red;
    } else if (_currentIndex == 3) {
      selectedColor = Colors.purple;
    }
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFEEEAEA),
          selectedItemColor: selectedColor,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/impact2.png"),
                  size: 30,
                ),
                label: "Impact"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event, size: 30), label: "Events"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/fy.png"),
                  size: 30,
                ),
                label: "For You"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 30), label: "Messages"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30), label: "Profile")
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (index == 0) {
                Provider.of<MainScreenViewModel>(context, listen: false)
                    .setWidget(const ImpactScreen());
              } else if (index == 1) {
                Provider.of<MainScreenViewModel>(context, listen: false)
                    .setWidget(const CalendarScreen());
              } else if (index == 2) {
                Provider.of<MainScreenViewModel>(context, listen: false)
                    .setWidget(const ForYouScreen());
              } else if (index == 3) {
                Provider.of<MainScreenViewModel>(context, listen: false)
                    .setWidget(const MessagesScreen());
              } else if (index == 4) {
                Provider.of<MainScreenViewModel>(context, listen: false)
                    .setWidget(const CalendarScreen());
              }
            });
          },
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Provider.of<MainScreenViewModel>(context, listen: true).widget,
        ));
  }
}
