import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/calendar/search_event_page.dart';
import 'package:flutter_chodi_app/screens/foryou/search_page.dart';
import 'package:r_calendar/r_calendar.dart';

class set_pw_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return set_pw_screenState();
  }
}

class set_pw_screenState extends State<set_pw_screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Password'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          SizedBox(height: 20),
          Container(height: 1, color: Colors.grey.shade200),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 15),
              Container(width: 150, child: Text('Set New Password')),
              SizedBox(width: 10),
              Container(
                width: 200,
                height: 40,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 15),
              Container(width: 150, child: Text('Comfire New Password')),
              SizedBox(width: 10),
              Container(
                width: 200,
                height: 40,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Text('DONE', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  buildItem(IconData? icon, String txt) {
    return Row(
      children: [
        SizedBox(width: 10),
        Icon(icon, size: 30),
        SizedBox(width: 40),
        Text(txt),
        Expanded(child: SizedBox()),
        Icon(Icons.arrow_forward_ios, size: 20),
        SizedBox(width: 10),
      ],
    );
  }
}
