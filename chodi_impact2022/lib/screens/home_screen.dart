import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calender/calendar_screen.dart';
import 'package:flutter_chodi_app/screens/foryou/for_you_screen.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';
import 'package:flutter_chodi_app/screens/impact/organization_screen.dart';
import 'package:flutter_chodi_app/screens/user/user_initialize_screen.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/log_out_button.dart';
import 'package:flutter_chodi_app/viewmodel/main_view_model.dart';
import 'package:provider/provider.dart';

import '../configs/app_theme.dart';
import '../services/shared_preferences_service.dart';
import 'messages/messages_screen.dart';

//SingleChildScrollView(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//               padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).padding.top + 10)),
//           const Text("homeScreen"),
//           GestureDetector(
//             child: const logOutWidget(),
//             //log out function logs people from google and firebase
//             onTap: () {
//               SharedPreferencesService sharedPreferencesService =
//                   SharedPreferencesService.instance;
//               sharedPreferencesService.setUserId(-1);
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const UserInitializeScreen()),
//                   (route) => false);
//             },
//           ),
//         ],
//       ))

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Widget _nowWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFEEEAEA),
          selectedItemColor: Colors.blue,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/impact.png"),
                  size: 20,
                ),
                label: "Impact"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/events.png"),
                  size: 20,
                ),
                label: "Calendar"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/for_you.png"),
                  size: 20,
                ),
                label: "For You"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/messages.png"),
                  size: 20,
                ),
                label: "Messages"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/notifications.png"),
                  size: 20,
                ),
                label: "Notifications")
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
                    .setWidget(const MessagesScreen());
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
