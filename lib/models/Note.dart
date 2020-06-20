import 'package:flutter/material.dart';

class Note  {
  final String title;
  final String body;
  final String id;
  final Function delete;
  Color col;
  Note(this.id, this.title, this.body, this.delete, this.col);
}
