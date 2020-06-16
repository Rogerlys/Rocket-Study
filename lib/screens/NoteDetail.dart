import 'package:flutter/material.dart';
import '../widgets/StickNotes/Note.dart';

class NoteDetail extends StatefulWidget {
  Note note;
  NoteDetail(this.note);
  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
  }
}
class NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
          child: Container(
        color: widget.note.col,
        child: Column(children: <Widget>[
          Text(widget.note.title),
          Text(widget.note.body),
          Row(children: <Widget>[
            FlatButton(child: Icon(Icons.arrow_back),
            onPressed: ()=> ( Navigator.pop(context, true)),),
            FlatButton(child: Icon(Icons.delete),
              onPressed: ()=> widget.note.delete(widget.note.id),
            )
          ],)
        ],),
      ),
    );
  }
}