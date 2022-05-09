import 'package:cloud_firestore/cloud_firestore.dart';

class chodiUser {
  String email;
  String username;
  String age;
  String securityQuestion;
  String securityQuestionAnswer;
  Map<dynamic, dynamic> registeredFor;
  Timestamp? lastUpdated;
  String? imageURL;

  chodiUser(
      {required this.email,
      required this.username,
      required this.age,
      required this.securityQuestion,
      required this.securityQuestionAnswer,
      required this.registeredFor,
      this.lastUpdated,
      this.imageURL});

  factory chodiUser.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    return chodiUser(
        email: data['Email'] ?? '',
        username: data["Username"] ?? '',
        age: data["Age"] ?? '',
        securityQuestion: data["SecurityQuestion"] ?? '',
        securityQuestionAnswer: data["SecurityQuestionAnswer"] ?? '',
        registeredFor: data["registeredFor"] ?? {},
        lastUpdated: data["LastUpdated"],
        imageURL: data["imageURL"] ?? "");
  }
}
