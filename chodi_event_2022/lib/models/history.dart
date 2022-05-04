import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  String ein;
  // ignore: non_constant_identifier_names
  bool IsEvent;
  Timestamp date;
  double hours;
  bool showedUp;
  double? donationAmount;
  //may add more

  History(
      {required this.ein,
      required this.IsEvent,
      required this.date,
      required this.hours,
      required this.showedUp,
      this.donationAmount});

  factory History.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    return History(
        ein: data["EIN"],
        IsEvent: data["IsEvent"],
        date: data["date"],
        hours: data["hours"],
        showedUp: data["showedUp"],
        donationAmount: data["donationAmount"] ?? 0);
  }
}
