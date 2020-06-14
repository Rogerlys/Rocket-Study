import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  String title;
  String body;
  Note(this.title, this.body);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
      Text(title,
      style: TextStyle(fontSize: 25,
      fontWeight: FontWeight.bold),),
      Text(body,
      style: TextStyle(color: Colors.grey),)
    ],);
  }
}