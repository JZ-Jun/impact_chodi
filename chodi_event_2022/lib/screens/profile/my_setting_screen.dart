import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/profile/set_pw_screen.dart';

// ignore: camel_case_types
class my_setting_screen extends StatefulWidget {
  const my_setting_screen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return my_setting_screenState();
  }
}

// ignore: camel_case_types
class my_setting_screenState extends State<my_setting_screen> {
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting and Privacy'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Account Settings'),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return set_pw_screen();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Change Password'),
                      Icon(Icons.arrow_forward_ios, size: 20)
                    ],
                  )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Push notifications'),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      child: Icon(isOpen ? Icons.toggle_on : Icons.toggle_off,
                          size: 40))
                ],
              )
            ],
          )),
    );
  }
}
