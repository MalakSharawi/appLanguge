import 'package:applanguge/models/user.dart';
import 'package:sqflite/sqflite.dart';

class User {
  late int id;
  late String name;
  late String email;
  late String password;

  static const tableName = 'users';
  User();

  User.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    name = rowMap['name'];
    email = rowMap['email'];
    password = rowMap['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
