import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class search_event_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return search_event_page_state();
  }
}

class search_event_page_state extends State<search_event_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                height: 45,
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(22.5))),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.highlight_off))
                  ],
                ),
              )),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text('Cancel'))),
            ],
          )
        ],
      ),
    );
  }
}
