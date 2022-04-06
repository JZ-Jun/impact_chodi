import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class contact_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return contact_page_state();
  }
}

class contact_page_state extends State<contact_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: Colors.grey.shade400,
      ),
      body: Center(
        child: Text("coming soon"),
      ),
    );
  }
}
