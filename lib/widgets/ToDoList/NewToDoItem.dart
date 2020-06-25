import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewToDoItem extends StatefulWidget {
  final Function addToDoItem;

  NewToDoItem(this.addToDoItem);

  @override
  _NewToDoItemState createState() => _NewToDoItemState();
}

class _NewToDoItemState extends State<NewToDoItem> {
  final _titleController = TextEditingController();
  DateTime _deadline;

  void _submitData() {
    if (_titleController.text.isEmpty || _deadline == null) {
      return;
    } else {
      widget.addToDoItem(_titleController.text, _deadline);
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2021))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _deadline = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(_deadline == null
                        ? 'Please select a date'
                        : 'Picked Date: ${DateFormat.yMd().format(_deadline)}')),
                FlatButton(
                    onPressed: _presentDatePicker, child: Text('Pick a date')),
                RaisedButton(
                    child: Text('Confirm'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: _submitData),
              ],
            )
          ],
        ),
      ),
    );
  }
}
