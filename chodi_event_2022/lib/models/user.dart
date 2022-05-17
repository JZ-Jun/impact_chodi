import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class chodiUser {
  String email;
  String username;
  String age;
  String securityQuestion;
  String securityQuestionAnswer;
  Map<dynamic, dynamic> registeredFor;
  Timestamp? lastUpdated;
  String? imageURL;
  String? gender;

  chodiUser({
    required this.email,
    required this.username,
    required this.age,
    required this.securityQuestion,
    required this.securityQuestionAnswer,
    required this.registeredFor,
    this.lastUpdated,
    this.imageURL,
    this.gender,
  });

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
      imageURL: data["imageURL"] ?? "",
      gender: data["Gender"] ?? "",
    );
  }
}
