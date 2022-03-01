class User {
  int? id;
  String? email;
  String? userName;
  int? age;
  String? securityQuestion;
  String? securityQuestionAnswer;
  String? password;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'email': email,
      'userName': userName,
      'age': age,
      'securityQuestion': securityQuestion,
      'securityQuestionAnswer': securityQuestionAnswer,
      'password': password,
    };
    return map;
  }

  User({
    this.id,
    required this.email,
    required this.userName,
    this.age,
    this.securityQuestion,
    this.securityQuestionAnswer,
    this.password,
  });

  User.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int?;
    email = map['email'] as String?;
    userName = map['userName'] as String?;
    age = map['age'] as int?;
    securityQuestion = map['securityQuestion'] as String?;
    securityQuestionAnswer = map['securityQuestionAnswer'] as String?;
    password = map['password'] as String?;
  }
}
