import 'package:flutter/material.dart';
import '../widgets/StickNotes/Note.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  NoteDetail(this.note);
  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
  }
}
class NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    return 
          Scaffold(
          appBar: AppBar(actions: <Widget>[
              FlatButton(child: Icon(Icons.delete),
                onPressed: ()=> widget.note.delete(widget.note.id),
              )
          ],),
          backgroundColor: widget.note.col,
          body: SingleChildScrollView(
            child: Container(
          color: widget.note.col,
          child: Column(children: <Widget>[
            Text(widget.note.title,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Text(widget.note.body,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
          ],),
      ),
    ),
        );
  }
}