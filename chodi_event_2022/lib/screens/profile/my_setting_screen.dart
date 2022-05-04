import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/profile/set_pw_screen.dart';

class my_setting_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return my_setting_screenState();
  }
}

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
        title: Text('Setting and Privacy'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Account Setting'),
              SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return set_pw_screen();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change Password'),
                      Icon(Icons.arrow_forward_ios, size: 20)
                    ],
                  )),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Push notifications'),
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
