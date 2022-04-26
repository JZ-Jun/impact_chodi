import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String? img;
  String? name;
  String? hours;
  String? date;

  Activity(this.img, this.name, this.hours, this.date);
}
