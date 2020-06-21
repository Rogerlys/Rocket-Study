import 'package:flutter/material.dart';

class NewEvent extends StatefulWidget {
  final Function add;
  NewEvent(this.add);

  @override
  NewEventState createState() => NewEventState();
}

class NewEventState extends State<NewEvent> {
  final titleController =  TextEditingController();
  final placeController = TextEditingController();
  String weekday = 'Monday';
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay picked;

  var map = {'Monday':0, 'Tuesday':1, 'Wednesday':2, 'Thursday':3, 'Friday':4
  , 'Saturday':5, 'Sunday':6};
  void submit() {
    if(placeController.text.isEmpty || titleController.text.isEmpty|| weekday == null 
     || picked == null) {
      return;
    }
    final newTitile = titleController.text;
    int d = map[weekday];

    widget.add(
      newTitile,
      picked,
      placeController.text,
      d
    );

    Navigator.of(context).pop();
  }

  
  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    setState(() {
      time = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    var weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
          DropdownButton<String>(
            items: weekdays.map((String day) {
              return DropdownMenuItem<String>(
                value: day,
                child: Text(day),
              );
            }).toList(),
            onChanged: (String value){
              setState(() {
                weekday = value;
              });
            },
            value: weekday
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Place'),
            controller: placeController,
          ),
          FlatButton(
            child: Text(picked == null ? "Select Time" : picked.format(context)),
            onPressed: ()=> selectTime(context),
            color: Theme.of(context).primaryColor,
          )
          ,
          FlatButton(
            child: Text('Add event'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.black,
            onPressed: submit,
          )
        ],),),
    );
  }
}