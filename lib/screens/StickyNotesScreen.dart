import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/StickNotes/Note.dart';
import '../widgets/StickNotes/NewNote.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StickNotesScreen extends StatefulWidget {
  static const routeName = "/Stick-Notes";
  final List<Note> notes;
  StickNotesScreen(this.notes);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    notes.add(Note(
        'd',
        "title",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galle",
        null,
        Color.fromRGBO(252, 252, 154, 1)));
    return _StickNoteState();
  }
}

class _StickNoteState extends State<StickNotesScreen> {
  void startAddNewNote(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewNote(addNewNote),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addNewNote(String title, String body) {
    setState(() {
      final List<Color> colours = [
        Color.fromRGBO(252, 252, 154, 1),
        Color.fromRGBO(252, 252, 252, 0.5),
        Color.fromRGBO(252, 183, 249, 0.5),
        Color.fromRGBO(252, 222, 183, 0.5),
        Color.fromRGBO(252, 196, 183, 0.5),
        Color.fromRGBO(159, 242, 156, 0.5),
        Color.fromRGBO(242, 156, 156, 0.5),

      ];

      widget.notes.add(
          Note(DateTime.now().toString(), title, body, delete, colours[1]));
    });
  }

  void delete(String id) {
    setState(() {
      widget.notes.removeWhere((item) => id == item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Stick notes")),
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          child: Icon(Icons.add),
          onPressed: () => startAddNewNote(context),
          backgroundColor: Colors.greenAccent,
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: widget.notes.toList(),
        ));
  }
}
