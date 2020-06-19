import 'package:flutter/material.dart';

import 'package:actual/models/InspirationalQuotes.dart';

class InspirationalQuote extends StatelessWidget {
  final String quote = InspirationalQuotes.uniqueQuote;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        width: 270,
        height: 180,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.yellow,
              elevation: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Quote of the day',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              child: Text(
                quote,
                style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),  
          ],
        ),
      ),
    );
  }
}
