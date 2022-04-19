import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String username;
  String age;
  String securityQuestion;
  String securityQuestionAnswer;

  User({
    required this.email,
    required this.username,
    required this.age,
    required this.securityQuestion,
    required this.securityQuestionAnswer,
  });

  factory User.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    return User(
      email: data['Email'],
      username: data["Username"],
      age: data["Age"],
      securityQuestion: data["SecurityQuestion"],
      securityQuestionAnswer: data["SecurityQuestionAnswer"],
    );
  }
}
