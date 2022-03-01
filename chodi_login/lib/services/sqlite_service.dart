/*
import 'package:flutter_chodi_app/models/user.dart';

import 'package:sqflite/sqflite.dart';

class SqliteService {
  late Database dataBase;
  final String dataBaseName = 'chodi_app.db';
  final String tableUser = 'user';

  SqliteService._privateConstructor() {
    openUserTable();
  }

  static final SqliteService instance = SqliteService._privateConstructor();

  Future openUserTable() async {
    dataBase =
        await openDatabase(dataBaseName, version: 1, onCreate: (db, version) {
      db.execute('create table $tableUser('
          'id integer primary key autoincrement,'
          'email text not null,'
          'userName text not null,'
          'age integer not null,'
          'password text not null,'
          'securityQuestion text not null,'
          'securityQuestionAnswer text not null)');
    });
  }

  Future closeUserTable() async {
    await dataBase.close();
  }

  Future<User> getUser(String email, String userName) async {
    List<Map> emailMaps =
        await dataBase.query(tableUser, where: 'email = ?', whereArgs: [email]);
    List<Map> userNameMaps = await dataBase
        .query(tableUser, where: 'userName = ?', whereArgs: [userName]);
    if (emailMaps.isEmpty && userNameMaps.isEmpty) return User();
    if (emailMaps.isNotEmpty) {
      User user = User.fromMap(emailMaps.first);
      return user;
    }
    if (userNameMaps.isNotEmpty) {
      User user = User.fromMap(userNameMaps.first);
      return user;
    }
    return User();
  }

  Future<User> insertUser(User user) async {
    user.id = await dataBase.insert(tableUser, user.toMap());
    return user;
  }

  Future<int> deleteUser(int id) async {
    return await dataBase.delete(tableUser, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    int res = await dataBase
        .update(tableUser, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return res;
  }

  Future close() async => dataBase.close();
}
*/