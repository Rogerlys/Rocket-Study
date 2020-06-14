import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class NewNote extends StatefulWidget {
  final Function add;
  NewNote(this.add);
  
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<NewNote> {
  final titleController =  TextEditingController();
  final bodyController = TextEditingController();
  
  void submit() {
    if(titleController.text.isEmpty || bodyController.text.isEmpty) {
      return;
    }
    widget.add(titleController.text, bodyController.text);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(child: Column(
      children: [
        TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Body'),
            controller: bodyController,
          ),
          FlatButton(
            child: Text('Add'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.black,
            onPressed: submit,
          )
      ]
    ),);
  }
  
}