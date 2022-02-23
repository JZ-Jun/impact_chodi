class User {
  int? id;
  String? email;
  String? userName;
  int? age;
  String? password;
  String? securityQuestion;
  String? securityQuestionAnswer;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'email': email,
      'userName': userName,
      'age': age,
      'password': password,
      'securityQuestion': securityQuestion,
      'securityQuestionAnswer': securityQuestionAnswer
    };
    return map;
  }

  User(
      {this.id,
      this.email,
      this.userName,
      this.age,
      this.password,
      this.securityQuestion,
      this.securityQuestionAnswer});

  User.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int?;
    email = map['email'] as String?;
    userName = map['userName'] as String?;
    age = map['age'] as int?;
    password = map['password'] as String?;
    securityQuestion = map['securityQuestion'] as String?;
    securityQuestionAnswer = map['securityQuestionAnswer'] as String?;
  }
}
