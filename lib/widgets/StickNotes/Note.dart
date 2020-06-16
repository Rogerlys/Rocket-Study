import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  final String title;
  final String body;
  final String id;
  final Function delete;
  Color col;
  Note(this.id, this.title, this.body, this.delete, this.col);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: widget.col
      ),
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.body,
            style: TextStyle(color: Colors.grey),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => widget.delete(this.widget.id)),
        ],
      ),
    );
  }
}
