import 'package:flutter/material.dart';

import '../../models/Note.dart';
import '../../screens/NoteDetail.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final Function delete;

  NoteWidget(this.note, this.delete);

  @override
  Widget build(BuildContext context) {
    void goToNotesScreen(Note note) async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoteDetail(note, delete)));
    }

    return GestureDetector(
      onTap: () => goToNotesScreen(note),
      onLongPress: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to delete this note?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('No')),
                  FlatButton(
                      onPressed: () {
                        delete(note.id);
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Yes'))
                ],
              )),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: note.col,
        ),
        child: Column(
          children: <Widget>[
            Text(
              note.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              note.body.length < 100
                  ? note.body
                  : note.body.substring(0, 100) + '\n ....',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
