import 'package:flutter/foundation.dart';

class ToDo {
  String id;
  String title;
  String description;
  DateTime date;

  ToDo({
    @required this.id,
    @required this.title,
    @required this.date
  });
}