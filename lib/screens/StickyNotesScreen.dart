import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/StickNotes/Note.dart';
import '../widgets/StickNotes/NewNote.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import 'NoteDetail.dart';

class StickNotesScreen extends StatefulWidget {
  static const routeName = "/Stick-Notes";
  final List<Note> notes;
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
    final List<Color> colours = [
      Color.fromRGBO(252, 252, 154, 1),
      Color.fromRGBO(252, 252, 252, 0.5),
      Color.fromRGBO(252, 183, 249, 0.5),
      Color.fromRGBO(252, 222, 183, 0.5),
      Color.fromRGBO(252, 196, 183, 0.5),
      Color.fromRGBO(159, 242, 156, 0.5),
      Color.fromRGBO(242, 156, 156, 0.5),
    ];
    final _random = new Random();
    int x = _random.nextInt(6);
    setState(() {
      widget.notes.add(
          Note(DateTime.now().toString(), title, body, delete, colours[x]));
    });
  }

  void delete(String id) {
    setState(() {
      widget.notes.removeWhere((item) => id == item.id);
    });
  }

  void goToNotesScreen(Note note) async {
      await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteDetail(note)));
  }

  Widget getStaggeredList() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      physics: BouncingScrollPhysics(),
      itemCount: widget.notes.length,
      itemBuilder: (BuildContext context, int index) => new GestureDetector(
        onTap: ()=> goToNotesScreen(widget.notes[index]),
        //widget.notes[index] => the current note that we are on
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: widget.notes[index].col,
          ),
          child: Column(
            children: <Widget>[
              Text(
                widget.notes[index].title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.notes[index].body.length < 100 ?
                widget.notes[index].body :
                 widget.notes[index].body.substring(0,100) +'\n ....' ,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
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
        floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
        body: getStaggeredList());
  }
}
