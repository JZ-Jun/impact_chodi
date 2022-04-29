import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class Impact {
  String EIN ;
  int hours ;
  bool? isEvent ;
  Timestamp? date ;
  int donationAmount ;
  bool? showedUp ;

  Impact({this.EIN = "", this.hours = 0, this.isEvent, this.date, this.donationAmount = 0, this.showedUp});

  returnDonations(){
    return donationAmount.toInt() ;
  }

  returnHours(){
    return hours.toInt() ;
  }

  returnDate(){
    return date ;
  }

  returnEIN() {
    return EIN ;
  }

  returnIsEvent(){
    return isEvent ;
  }

  @override
  toString(){
    return EIN ;
  }

  factory Impact.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;
    return Impact(
      EIN: data['EIN'] ?? '',

      hours: data['hours'] ?? '',
      isEvent: data['IsEvent'] ?? '',
      date: data['date'] ?? '',
      donationAmount: data['donationAmount'] ?? '',
      showedUp: data['showedUp'] ?? '',
    );
  }
}
