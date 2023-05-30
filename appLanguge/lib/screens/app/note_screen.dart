import 'package:applanguge/database/notes_provider.dart';
import 'package:applanguge/models/note.dart';
import 'package:applanguge/models/prosses_respons.dart';
import 'package:applanguge/prf/shared_pref_controller.dart';
import 'package:applanguge/utils/context-extenssion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.note}) : super(key: key);
  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleEditingController;
  late TextEditingController _infoEditingController;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.note?.title);
    _infoEditingController = TextEditingController(text: widget.note?.info);
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _infoEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          TextField(
            controller: _titleEditingController,
            keyboardType: TextInputType.text,
            style: GoogleFonts.aBeeZee(),
            decoration: InputDecoration(
                hintText: 'Title',
                prefixIcon: Icon(Icons.title),
                hintStyle: GoogleFonts.aBeeZee(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _infoEditingController,
            keyboardType: TextInputType.text,
            style: GoogleFonts.aBeeZee(),
            decoration: InputDecoration(
                hintText: 'Information ',
                prefixIcon: Icon(Icons.info),
                hintStyle: GoogleFonts.aBeeZee(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () => _performSave(), child: Text('Save'))
        ],
      ),
    );
  }

  void _performSave() {
    if (_checkData()) {
      _save();
    }
  }

  bool _checkData() {
    if (_titleEditingController.text.isNotEmpty &&
        _infoEditingController.text.isNotEmpty) {
      return true;
    }
    context.shwoMassege(message: 'error data', error: true);
    return false;
  }

  void _save() async{
    ProcessResponse processResponse = isNewNote
        ? await Provider.of<NotesProvider>(context,listen: false).create(note)
        : await Provider.of<NotesProvider>(context,listen: false).update(note);
    if(processResponse.success){
      isNewNote?clear():Navigator.pop(context);
    }
    context.shwoMassege(message: processResponse.message,error: !processResponse.success);
  }
  void clear(){
    _titleEditingController.clear();
    _infoEditingController.clear();
  }
  Note get note{
    Note note =isNewNote? Note() :widget.note!;
    note.title=_titleEditingController.text;
    note.info=_infoEditingController.text;
    note.userId=SharedPrefController().getValueFor<int>(key: PrefKeys.id.name)!;
    return note;

  }

  bool get isNewNote => widget.note == null;

  String get title => isNewNote ? 'create' : 'update';
}
