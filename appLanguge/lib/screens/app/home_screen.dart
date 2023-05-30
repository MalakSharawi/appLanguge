import 'package:applanguge/database/notes_provider.dart';
import 'package:applanguge/models/note.dart';
import 'package:applanguge/models/prosses_respons.dart';
import 'package:applanguge/screens/app/note_screen.dart';
import 'package:applanguge/utils/context-extenssion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../prf/shared_pref_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<NotesProvider>(context,listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                // await _logout();
                await _confirmLogout();
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoteScreen()));
              },
              icon: const Icon(Icons.note_add_outlined))
        ],
      ),
      body: Consumer<NotesProvider>(
          builder: (context, NotesProvider value, child) {
        if (value.notes.isNotEmpty) {
          return ListView.builder(
              itemCount: value.notes.length,
              itemBuilder: (context, Index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NoteScreen(note: value.notes[Index])));
                  },
                  leading: Icon(Icons.note),
                  title: Text(value.notes[Index].title),
                  subtitle: Text(value.notes[Index].info),
                  trailing: IconButton(
                    onPressed: () => _deleteNote(Index),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Text(
              'No DATA',
              style: GoogleFonts.aBeeZee(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
          );
        }
      }),
    );
  }

  void _deleteNote(int index) async {
    ProcessResponse processResponse =
        await Provider.of<NotesProvider>(context, listen: false).delete(index);
    context.shwoMassege(
        message: processResponse.message, error: !processResponse.success);
  }

  Future<void> _logout() async {
    bool cleared = await SharedPrefController().clear();
    if (cleared) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  Future<void> _confirmLogout() async {
    bool? rsult = await showDialog<bool>(
        barrierDismissible: false,
        barrierColor: Colors.black12,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentTextStyle: GoogleFonts.poppins(
              color: Colors.black45,
              fontSize: 14,
            ),
            titleTextStyle: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Are You Sure?'),
            content: Text('logout and return to login'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child:
                    Text('Yes', style: GoogleFonts.poppins(color: Colors.red)),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
    if (rsult ?? false) {
      await _logout();
    }
  }
}
