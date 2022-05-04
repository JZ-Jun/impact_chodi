import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class donate_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return donate_page_state();
  }
}

class donate_page_state extends State<donate_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Center(
        child: Text("coming soon"),
      ),
    );
  }
}
