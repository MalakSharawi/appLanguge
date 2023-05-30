import 'dart:core';
import 'package:applanguge/database/db_oparations.dart';
import 'package:applanguge/models/note.dart';
import 'package:applanguge/prf/shared_pref_controller.dart';

class NotDbController extends DbOperations<Note> {
  int userId=SharedPrefController().getValueFor(key: PrefKeys.id.name);

  @override
  Future<int> create(Note model) async {
    // int newRow = await database.rawInsert(
    //     'INSERT INTO nots (title , info ,userId) VALUE (?,?,?)',
    //     [model.title, model.info, model.userId]);
    return await database.insert(Note.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {

    int countOfDeletedRows =
        await database.rawDelete('DELETE FROM nots WHERE id = ? AND user_id =?', [id,userId]);
    return countOfDeletedRows == 1;
  }

  @override
  Future<List<Note>> read() async {
    //  List<Map<String,dynamic>> rowsMap =await database.rawQuery('SELECT * FROM nots WHERE user_id =?',[user]);
    List<Map<String, dynamic>> rowsMap = await database.query(Note.tableName,
        where: 'user_id = ?', whereArgs: [userId]);
    return rowsMap.map((rowMap) => Note.fromMap(rowMap)).toList();
  }

  @override
  Future<Note?> show(int id) async {
    List<Map<String, dynamic>> rowsMap = await database.rawQuery(
        'SELECT * FROM nots WHERE id = ? AND user_id = ? ',
        [id,userId]);
    return rowsMap.isNotEmpty ? Note.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(Note model) async{
    int countOfUpdatedRows =await database.rawUpdate('UPDATE nots SET title = ?, info = ? WHERE id = ? AND user_id = ?',[model.title,model.info,model.id,userId]);
    return countOfUpdatedRows==1;
  }
}
