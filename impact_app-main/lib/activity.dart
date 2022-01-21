import 'package:flutter/material.dart';
import 'nonprofit.dart';
class Activity {
  String org="";
  DateTime date = DateTime.now();
  String summary = "";
  Icon icon = Icon(Icons.public);
  Activity(String org, DateTime date,Icon i) {

    this.org = org;
    this.date = date;
    this.icon = i;
    this.summary=" ";
  }
  
  }