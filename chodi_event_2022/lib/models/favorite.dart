import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  String EIN ;
  String eventCode ;
  bool isOrg ;

  Favorite({
    required this.EIN ,
    required this.eventCode,
    required this.isOrg,
}) ;

  factory Favorite.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    return Favorite(
      EIN: data['EIN'],
      eventCode: data['eventCode'],
      isOrg: data['isOrg'],
    );

  }

}