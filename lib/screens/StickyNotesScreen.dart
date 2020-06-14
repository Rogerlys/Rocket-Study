import 'package:flutter/material.dart';
import '../widgets/StickNotes/Note.dart';
import '../widgets/StickNotes/NewNote.dart';

class StickNotesScreen extends StatefulWidget {
  static const routeName = "/Stick-Notes";
  final List<Widget> notes;
  StickNotesScreen(this.notes);
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    widget.notes.add(Note(title, body));
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
    body : GridView.count(
         primary: false,
        padding: const EdgeInsets.all(20),
         crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: widget.notes,
        ));
  }
}