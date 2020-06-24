import 'package:flutter/material.dart';

import '../../models/Note.dart';
import '../../screens/NoteDetail.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final Function delete;

  NoteWidget(this.note, this.delete);

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    void goToNotesScreen(Note note) async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NoteDetail(note, widget.delete)));
    }

    return GestureDetector(
      onTap: () => goToNotesScreen(widget.note),
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
                        widget.delete(widget.note.id);
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
          color: widget.note.col,
        ),
        child: Column(
          children: <Widget>[
            Text(
              widget.note.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.note.body.length < 100
                  ? widget.note.body
                  : widget.note.body.substring(0, 100) + '\n ....',
              style: TextStyle(color: Colors.black, fontSize: 18),
              maxLines: 7
            ),
          ],
        ),
      ),
    );
  }
}
