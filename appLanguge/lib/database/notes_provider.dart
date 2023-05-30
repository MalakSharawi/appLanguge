import 'package:applanguge/database/note_db_controller.dart';
import 'package:applanguge/models/note.dart';
import 'package:applanguge/models/prosses_respons.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  final NotDbController _dbContrller = NotDbController();

  Future<ProcessResponse> create(Note note) async {
    int newRowId = await _dbContrller.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      notifyListeners();
    }
    return getRespose(newRowId != 0);
  }

  void read() async {
    notes = await _dbContrller.read();
    notifyListeners();
  }

  Future<ProcessResponse>update(Note note)async{
   bool updated= await _dbContrller.update(note);
    if(updated){
      int index = notes.indexWhere((element) => element.id == note.id);
      if(index !=- 1){
        notes[index]=note;
        notifyListeners();
      }

    }
    return getRespose(updated);
  }
  Future<ProcessResponse>delete(int index)async{
    bool deleted = await _dbContrller.delete(notes[index].id);
    if(deleted){
      notes.removeAt(index);
      notifyListeners();
    }
    return getRespose(deleted);
  }
  ProcessResponse getRespose(bool sucsses) {
    return ProcessResponse(
        message: sucsses ? 'Operation completed successful' : 'Operation Filed',
        success: sucsses);
  }
}
