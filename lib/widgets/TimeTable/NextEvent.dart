import 'package:flutter/material.dart';
import '../../models/Event.dart'; 

class NextEvent extends StatelessWidget {
  Event next;
  NextEvent(this.next);
  @override
  Widget build(BuildContext context) {
    return 
    Card(
      child: ListTile(title: Text(next.time.format(context)),
                      trailing: Text(next.title),),
    );
  }
}