import 'package:flutter/material.dart';

import 'package:actual/models/Note.dart';

import 'StickyNotesScreen.dart';

class NoteDetail extends StatefulWidget {
  Note note;
  Function delete;
  NoteDetail(this.note, this.delete);
  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
  }
}

class NoteDetailState extends State<NoteDetail> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String newTitle;
  String newBody;

  void updateTitle() {
    newTitle = titleController.text;
  }

  void updateBody() {
    newBody = bodyController.text;
  }

  void onSubmit() {
    if (newTitle != null) widget.note.title = newTitle;
    if (newBody != null) widget.note.body = newBody;
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.note.title;
    bodyController.text = widget.note.body;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: widget.note.col,
        title: Text(
          'Edit',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.popAndPushNamed(context, StickNotesScreen.routeName);
            }),
        actions: <Widget>[
          //added stuff below
          GestureDetector(
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          onTap: () => onSubmit()
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.black,
              onPressed: () {
                widget.delete(widget.note.id);
                Navigator.pop(context, true);
              })
        ],
      ),
      backgroundColor: widget.note.col,
      body: Container(
        color: widget.note.col,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                    controller: titleController,
                    onChanged: (_) {
                      updateTitle();
                    },
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: InputDecoration.collapsed(
                      hintText: '',
                    )),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: bodyController,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  onChanged: (_) {
                    updateBody();
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: 'Description',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
