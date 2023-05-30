import 'package:applanguge/database/db_controller.dart';
import 'package:applanguge/models/prosses_respons.dart';
import 'package:applanguge/models/user.dart';
import 'package:applanguge/prf/shared_pref_controller.dart';
import 'package:sqflite/sqflite.dart';

class UserDbController {
  final Database _database = DbController().database;

  Future<ProcessResponse> login({required String email, required String password}) async {
    List<Map<String, dynamic>> rowsMap = await _database.query(User.tableName,
        where: 'email =? AND password =?', whereArgs: [email, password]);
    if(rowsMap.isNotEmpty){
      User user =User.fromMap(rowsMap.first);
      SharedPrefController().save(user: user);
      return ProcessResponse(message: 'Logged In Successfully',success: true);
    }
    return ProcessResponse(message: 'Login failed ,check data ',success: false);

  }

  Future<ProcessResponse> register({required User user}) async {
    if (await isUniqueEmail(email: user.email)) {
      int newRowId = await _database.rawInsert(
          'INSERT INTO users (name,email,password) Values (?,?,?)',
          [user.name, user.email, user.password]);
      return ProcessResponse(
          message: newRowId != 0 ? 'Successes' : 'Failed',
          success: newRowId != 0);
    }
    return ProcessResponse(
        message: 'Email exsist , use anothor!', success: false);
  }

  Future<bool> isUniqueEmail({required String email}) async {
    List<Map<String, dynamic>> rowMap =
        await _database.rawQuery('SELECT * FROM users WHERE email =?', [email]);
    return rowMap.isEmpty;
  }
}
