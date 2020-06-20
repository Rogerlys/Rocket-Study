import 'package:actual/widgets/StickyNotes/NoteWidget.dart';
import 'package:flutter/material.dart';
import 'package:actual/models/Note.dart';
import '../widgets/StickyNotes/NewNote.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

import 'NoteDetail.dart';

class StickNotesScreen extends StatefulWidget {
  static const routeName = "/Stick-Notes";
  final List<Note> notes;
  StickNotesScreen(this.notes);

  @override
  State<StatefulWidget> createState() {
    return _StickNoteState();
  }
}

class _StickNoteState extends State<StickNotesScreen> {
  void startAddNewNote(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewNote(addNewNote),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addNewNote(String title, String body) {
    final List<Color> colours = [
      Color.fromRGBO(252, 252, 154, 1),
      Color.fromRGBO(252, 252, 252, 0.5),
      Color.fromRGBO(252, 183, 249, 0.5),
      Color.fromRGBO(252, 222, 183, 0.5),
      Color.fromRGBO(252, 196, 183, 0.5),
      Color.fromRGBO(159, 242, 156, 0.5),
      Color.fromRGBO(242, 156, 156, 0.5),
    ];
    final _random = new Random();
    int x = _random.nextInt(6);
    setState(() {
      widget.notes
          .add(Note(DateTime.now().toString(), title, body, colours[x]));
    });
  }

  void delete(String id) {
    setState(() {
      widget.notes.removeWhere((item) => id == item.id);
    });
  }

  num calcNoteHeight(String body) {
    int length = body.length;
    if (length < 20) return 1;
    if (length < 100) return 2;
    if (length > 100) return 2.5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 20,
          child: Icon(Icons.add),
          onPressed: () => startAddNewNote(context)),
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
            sliver: SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              forceElevated: false,
              expandedHeight: 250,
              floating: false,
              pinned: false,
              // title: Text(
              //   'Sticky Notes',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              // ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/whiteBackground.jpg',
                        fit: BoxFit.cover, //can be Boxfit.fill
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 80, left: 20),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'Sticky Notes',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverStaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: <Widget>[
              for (var i = 0; i < widget.notes.length; i++)
                NoteWidget(widget.notes[i], delete)
            ],
            staggeredTiles: <StaggeredTile>[
              for (var i = 0; i < widget.notes.length; i++)
                StaggeredTile.count(2, calcNoteHeight(widget.notes[i].body))
            ],
          )
        ],
      ),
    );
  }
}

// return Scaffold(
//     appBar: AppBar(title: Text("Stick notes")),
//     floatingActionButton: FloatingActionButton(
//       elevation: 20,
//       child: Icon(Icons.add),
//       onPressed: () => startAddNewNote(context),
//       backgroundColor: Colors.greenAccent,
//     ),
//     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     body: getStaggeredList());

//  void goToNotesScreen(Note note) async {
//     await Navigator.push(
//         context, MaterialPageRoute(builder: (context) => NoteDetail(note)));
//   }

//   Widget getStaggeredList() {
//     return StaggeredGridView.countBuilder(
//       crossAxisCount: 4,
//       physics: BouncingScrollPhysics(),
//       itemCount: widget.notes.length,
//       itemBuilder: (BuildContext context, int index) => new GestureDetector(
//         onTap: () =>
//             goToNotesScreen(widget.notes[index]), //add dialog to ask to delete
//         onLongPress: () => delete(widget.notes[index].id),
//         //widget.notes[index] => the current note that we are on
//         child: Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.blue,
//             ),
//             borderRadius: BorderRadius.circular(10.0),
//             color: widget.notes[index].col,
//           ),
//           child: Column(
//             children: <Widget>[
//               Text(
//                 widget.notes[index].title,
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 widget.notes[index].body.length < 100
//                     ? widget.notes[index].body
//                     : widget.notes[index].body.substring(0, 100) + '\n ....',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//       staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
//       mainAxisSpacing: 4.0,
//       crossAxisSpacing: 4.0,
//     );
//   }
